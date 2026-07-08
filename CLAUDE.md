# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Static HTML/CSS portfolio website deployed to AWS using S3 and CloudFront, provisioned with Terraform, and automated via GitHub Actions.

Used in the **DevOps Micro Internship (DMI)** for teaching Linux, Nginx, and deployment fundamentals.

- **Type**: Static site (no JS, no build step)
- **Host**: AWS S3 + CloudFront (CI/CD automated)
- **Size**: ~1,750 lines (613 HTML + 1,145 CSS)
- **Responsive**: Mobile-first (breakpoints: 900px, 768px, 600px)

## Architecture

Pure HTML5 and CSS3. No JavaScript. No build step. No framework.

```
index.html          — Main portfolio (About, Services, Courses, Books, Contact)
style.css           — All styling (~1145 lines), mobile-first responsive
privacy.html        — Standalone page with inline styles
terms.html          — Standalone page with inline styles
images/             — Static assets (logo, profile, hero background, course thumbnails)
.github/workflows/  — GitHub Actions: auto-sync to S3 + CloudFront invalidation on push to main
.claude/skills/     — Custom skills for infrastructure setup (optional, not deployed to site)
terraform/          — Infrastructure as Code (S3, CloudFront, OIDC, state management)
README.md           — DMI student guide for manual Nginx deployment
```

## Editing Content

**Site content**: Edit `index.html` or `style.css` directly. Push to `main` → GitHub Actions auto-deploys to S3.

**Ownership proof (DMI requirement)**: Add deployment details to the footer in `index.html`:
```html
<p><strong>Deployed by:</strong> [Name] | [Group] | [Date]</p>
```

**Images**: Place in `images/` folder, reference as `<img src="images/filename" alt="...">` or `background-image: url('images/filename')`.

**New pages**: Create standalone `.html` files with inline `<style>` tags (matches structure of `privacy.html` and `terms.html`).

## Deployment

### Automated (Production)
Push to `main` → GitHub Actions:
1. Syncs all files to S3 (`pravinmishradmi-site-production`)
2. Invalidates CloudFront cache (distribution `E3V6O6MRE2E21P`)
3. Excludes: `.git/`, `.github/`, `.claude/`, `terraform/`, `*.md`

Use the `/deploy` skill to manually trigger the same workflow locally (for debugging).

### Manual (Student Exercise)
Deploy to Ubuntu VM via Nginx (see README.md for full steps):
```bash
sudo apt install nginx
sudo cp -r . /var/www/html/
sudo systemctl start nginx
# Access via http://<public-ip>
```

## Commands

```bash
# Terraform
cd terraform && terraform init
cd terraform && terraform plan
cd terraform && terraform apply

# Preview locally
open index.html

# Manual S3 sync (if needed)
aws s3 sync . s3://pravinmishradmi-site-production \
  --delete \
  --exclude ".git/*" \
  --exclude ".github/*" \
  --exclude ".claude/*" \
  --exclude "terraform/*" \
  --exclude "*.md"

# Invalidate CloudFront cache
aws cloudfront create-invalidation \
  --distribution-id E3V6O6MRE2E21P \
  --paths "/*"
```

## Conventions

- **All infrastructure changes go through Terraform** — Never modify AWS resources manually
- **No JavaScript in this project** — Keep it pure HTML5 and CSS3
- **CSS uses mobile-first approach** — Define mobile styles first, then use `@media (min-width: ...)` for breakpoints at 900px, 768px, and 600px

## Infrastructure Skills (Optional)

These skills set up optional infrastructure (not required for the basic site). Use only if expanding the project:

- `/scaffold-terraform [region] [name]` — Generate Terraform for AWS resources
- `/scaffold-cicd [aws-account-id]` — Generate GitHub Actions + OIDC IAM
- `/tf-plan` — Preview infrastructure changes
- `/tf-apply` — Apply infrastructure changes
- `/infra-status` — Check resource health

If you use these skills, they will create a `terraform/` directory and agents (not deployed to the site).

## Style Guide

- **Mobile-first CSS**: Define mobile styles first, then use `@media (min-width: ...)` for larger screens
- **Responsive breakpoints**: 600px, 768px, 900px (already defined in style.css)
- **Font stack**: CSS includes Font Awesome icons via CDN
- **Colors**: Check existing CSS for the palette (look for hex/rgb values in style.css)
- **Spacing**: Use consistent margins/padding (review style.css for existing patterns)

## Common Tasks

```bash
# Update portfolio content
edit index.html          # Add new sections, update text

# Add new images
# 1. Place image in images/ folder
# 2. Reference in index.html: <img src="images/new.png" alt="description">
# 3. Push to main (auto-deploys)

# Test responsive design locally
# 1. open index.html
# 2. Inspect → Toggle device toolbar (Chrome DevTools)
# 3. Test at 600px, 768px, 900px, 1200px widths

# Check deployment status
# → Visit https://pravinmishradmi-site-production.s3.amazonaws.com (if S3 public access enabled)
# → Or check GitHub Actions tab in this repo
```

## Safety

Never put secrets in this file. No API keys, passwords, or AWS credentials.

## Notes

- No build step, no dependencies, no npm/yarn required
- AWS credentials for deployment are managed via GitHub OIDC (no long-lived keys stored)
- GitHub Actions workflow only runs on push to `main`; other branches don't deploy
- `.claude/skills/` is for Claude Code operators only; not deployed to the site
- Terraform and agent infrastructure (if scaffolded) is also not deployed to the site
