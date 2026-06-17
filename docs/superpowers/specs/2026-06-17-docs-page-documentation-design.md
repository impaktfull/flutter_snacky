# Design: docs.page documentation for `snacky`

Date: 2026-06-17
Status: Approved

## Goal

Replace the limited `README.md` with a full documentation site hosted on
[docs.page](https://use.docs.page/), making `snacky` easy to implement and
making its design decisions easy to understand. The setup mirrors the two
existing impaktfull docs.page projects (`impaktfull_cli` and `xray`).

## Hosting model

docs.page serves directly from the GitHub repo `impaktfull/flutter_snacky` —
there is no build step. We add:

- `docs.json` at the repo root (site config + sidebar).
- A `docs/` folder of `.mdx` files (one per page).

The published site lives at `https://docs.page/impaktfull/flutter_snacky`
(or a custom domain if one is pointed at it later).

## `docs.json` configuration

```jsonc
{
  "$schema": "https://docs.page/schema.json",
  "name": "Snacky",
  "description": "You deserve a simple snack! Simple, customizable snackbars & toasts for Flutter.",
  "logo": {
    "light": "https://raw.githubusercontent.com/impaktfull/flutter_snacky/master/assets/logo.svg",
    "dark": "https://raw.githubusercontent.com/impaktfull/flutter_snacky/master/assets/logo.svg"
  },
  "theme": {
    "primaryLight": "#7D64F2",
    "primaryDark": "#7D64F2"
  },
  "scripts": {
    "googleAnalytics": "G-XXXXXXXXXX"
  },
  "social": {
    "github": "impaktfull",
    "website": "https://impaktfull.com"
  },
  "anchors": [
    { "title": "Live Demo", "icon": "play", "href": "https://example.snacky.opensource.impaktfull.com" },
    { "title": "pub.dev", "icon": "box", "href": "https://pub.dev/packages/snacky" },
    { "title": "GitHub", "icon": "github", "href": "https://github.com/impaktfull/flutter_snacky" }
  ]
}
```

Notes:
- `googleAnalytics` is a placeholder (`G-XXXXXXXXXX`) for the user to fill in.
- Theme reuses the impaktfull purple (`#7D64F2`), matching the CLI and xray docs.
- Logo references the existing `assets/logo.svg` via the GitHub raw URL.

## Sidebar / page structure

11 pages across 4 groups:

```
Getting Started
  📖 Overview            /                         What it is, why it exists, demo video, links
  🚀 Installation        /installation             pub.dev add, import
  ⚡ Quick Start         /quick-start              SnackyConfiguratorWidget setup + first snacky

Guides
  🍿 Showing Snackies    /guides/showing-snackies   All Snacky options: type, location, duration,
                                                    onTap, leading/trailing/bottom builders
  🎨 Custom Widgets      /guides/custom-widgets     Snacky.widget + CancelableSnacky, margin/padding
  🖌️ Builders & Theming  /guides/builders           Simple/Toast/Gradient builders + custom SnackyBuilder
  📐 Layout & Responsive /guides/layout             SnackyLayoutConfig, breakpoints, width, location
  🧭 Queue & Controller  /guides/controller         Singleton vs custom controller, queue, cancel APIs
  🚦 Navigation          /guides/navigation         SnackyNavigationObserver

Concepts
  🏗️ Architecture & Design Decisions  /concepts/architecture

Reference
  📚 API Reference       /reference/api             Tables for the public API
```

## Page content outline

### `/` — Overview (`docs/index.mdx`)
- Tagline: "You deserve a simple snack!"
- The problem snacky solves (existing libraries are too complicated for simple cases).
- Embedded demo video / link to live web demo.
- Links: pub.dev, GitHub, Live Demo.
- A short "next steps" pointing to Installation / Quick Start.

### `/installation` (`docs/installation.mdx`)
- `flutter pub add snacky` (and `pubspec.yaml` snippet).
- `import 'package:snacky/snacky.dart';`
- Supported SDK constraints (Dart `>=3.2.0`, Flutter `>=1.17.0`).

### `/quick-start` (`docs/quick-start.mdx`)
- Wrap the app in `SnackyConfiguratorWidget(app: MaterialApp(...))`.
- Optional `SnackyNavigationObserver` in `navigatorObservers`.
- Show the first snacky via `SnackyController.instance.showMessage(...)`.
- Note that the configurator must sit above the `Navigator` and stay mounted.

### `/guides/showing-snackies` (`docs/guides/showing-snackies.mdx`)
- Full walkthrough of the structured `Snacky(...)` constructor.
- Every parameter: `title`, `subtitle`, `type`, `showDuration` (incl. auto-calc
  behavior), `transitionDuration`, `transitionCurve`, `location`,
  `openUntillClosed`, `canBeClosed`, `onTap`, `leadingWidgetBuilder`,
  `trailingWidgetBuilder`, `bottomWidgetBuilder`, `margin`, `padding`.
- `SnackyType` values: success, error, warning, info, branded.
- `SnackyLocation` values: top/bottom × center/start/end.

### `/guides/custom-widgets` (`docs/guides/custom-widgets.mdx`)
- `Snacky.widget(builder: (context, cancelableSnacky) => ...)`.
- How `CancelableSnacky.cancel()` dismisses from inside a custom widget.
- `margin` vs `padding` (lifting above a `BottomNavigationBar`).

### `/guides/builders` (`docs/guides/builders.mdx`)
- The `SnackyBuilder` abstraction (global appearance of structured snackies).
- Built-in builders: `SimpleSnackyBuilder` (default), `ToastSnackyBuilder`,
  `GradientSnackyBuilder`, with their customization hooks
  (`backgroundColorBuilder`, `iconBuilder`, `borderBuilder`, `textStyleBuilder`,
  `shadowBuilder`, `closeIconBuilder`, `borderRadius`, `margin`, `padding`).
- Passing a builder to `SnackyConfiguratorWidget(snackyBuilder: ...)`.
- Writing a custom `SnackyBuilder`.

### `/guides/layout` (`docs/guides/layout.mdx`)
- `SnackyLayoutConfig` and `SnackyLayoutBreakpointConfig`.
- Per-breakpoint `snackyMaxWidth`, `snackyPercentage`, `snackyLocation`.
- Width resolution logic and the no-overlap validation rule.
- Per-snacky `location` override vs breakpoint default.

### `/guides/controller` (`docs/guides/controller.mdx`)
- Singleton `SnackyController.instance` vs creating a custom instance
  (must be passed to `SnackyConfiguratorWidget`).
- The one-at-a-time queue behavior.
- `showMessage`, `cancelActiveSnacky`, `cancelAll`, `activeSnacky`.

### `/guides/navigation` (`docs/guides/navigation.mdx`)
- `SnackyNavigationObserver` cancels snackies on push/replace.
- Wiring it into `navigatorObservers`, optionally with a custom controller.

### `/concepts/architecture` (`docs/concepts/architecture.mdx`)
The "why" page — directly serves the goal of understanding design decisions:
- **Overlay-based rendering**: snackies render into the `Navigator`'s `Overlay`
  (discovered by walking the element tree from the configurator), so they float
  above all content and survive across screens. Implications: the configurator
  must wrap the `Navigator` and stay mounted.
- **Single-active queue**: the controller holds a queue and shows one snacky at
  a time; rationale and behavior.
- **Builder decoupled from message**: `Snacky` carries data; `SnackyBuilder`
  controls presentation — why they're separate and how that enables theming.
- **Structured vs custom (`Snacky` vs `Snacky.widget`)**: when to use each.
- **`CancelableSnacky` handle**: why dismissal is exposed as a handle.
- **Auto-duration**: `SnackyDurationUtil` rationale (base 5s + 1s per 120 chars,
  capped at 30s) and how to override.

### `/reference/api` (`docs/reference/api.mdx`)
- Hand-written reference tables for the public API surface (exports from
  `lib/snacky.dart`): `Snacky` / `Snacky.widget`, `SnackyController`,
  `SnackyConfiguratorWidget`, `SnackyType`, `SnackyLocation`,
  `SnackyLayoutConfig`, `SnackyLayoutBreakpointConfig`, the three builders,
  `CancelableSnacky`, `SnackyNavigationObserver`, `SnackyDurationUtil`.
- Links out to the full auto-generated API docs on pub.dev.

## README changes

Slim `README.md` down to:
- Logo + badges (pub version, CI, live demo).
- One-line description / tagline.
- Demo (video + live demo link).
- A ~10-line quick start (configurator + one snacky).
- A prominent "📚 Full documentation" link to the docs.page site.

All deep content (per-option guides, theming, layout, architecture) lives in the
docs site, not the README.

## Style conventions (match existing impaktfull docs)

- Each `.mdx` starts with `---\ntitle: ...\ndescription: ...\n---` frontmatter.
- Practical, example-first prose; code fences use ```dart.
- Sidebar titles include a leading emoji, matching the CLI/xray docs.

## Out of scope (YAGNI)

- No custom domain setup in this task (site uses the default docs.page URL).
- No changes to the example app, library source, or CI workflows.
- No auto-generated API doc tooling — the API Reference page is hand-written and
  links to pub.dev for the exhaustive generated docs.

## Verification

- `docs.json` validates against `https://docs.page/schema.json` (well-formed
  JSON, every sidebar `href` maps to an existing `.mdx` file).
- All 11 `.mdx` files exist at the paths referenced by the sidebar.
- Every Dart code snippet uses only the public API exported from
  `lib/snacky.dart` and matches the current signatures.
- README links resolve to the docs site.
