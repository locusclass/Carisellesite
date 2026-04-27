# Cariselle Technologies — Liquid Glass GitHub Pages Site

A premium Flutter Web landing page for **Cariselle Technologies**, built with `liquid_glass_widgets` and ready for GitHub Pages deployment.

## Run locally

```bash
flutter pub get
flutter run -d chrome
```

## Build for GitHub Pages

Replace `REPO_NAME` with your repository name:

```bash
flutter build web --release --base-href "/REPO_NAME/"
```

## Deploy

This project includes:

```text
.github/workflows/deploy.yml
```

Push to the `main` branch, then enable GitHub Pages:

1. Go to your repository on GitHub.
2. Open **Settings → Pages**.
3. Under **Build and deployment**, choose **GitHub Actions**.
4. Push the project to `main`.

## Connect Namecheap domain

After GitHub Pages is live, add your custom domain in **Settings → Pages**.

Recommended DNS at Namecheap:

```text
CNAME  www  your-github-username.github.io
```

For root domain, add GitHub Pages A records:

```text
A  @  185.199.108.153
A  @  185.199.109.153
A  @  185.199.110.153
A  @  185.199.111.153
```

Then enable **Enforce HTTPS** in GitHub Pages.