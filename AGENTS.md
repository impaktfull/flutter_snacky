# Snacky

A Flutter package to show snackbars and toasts with minimal configuration.

- `lib/` - the package, exported from `lib/snacky.dart`
- `test/` - widget and unit tests
- `example/` - the example app, deployed to GitHub Pages from `main`
- `docs/` - the documentation on [docs.page](https://docs.page/impaktfull/flutter_snacky)

## Releases & Changelog

Releases are automated with [release-please](https://github.com/googleapis/release-please). **Do not edit `CHANGELOG.md`, the `version` in `pubspec.yaml` or `.release-please-manifest.json` by hand.**

Pull requests are squash-merged, so the **pull request title** must be a [Conventional Commit](https://www.conventionalcommits.org). It becomes the changelog entry and decides the version bump:

| PR title | Release |
|----------|---------|
| `fix: ...` | patch (0.0.x) |
| `feat: ...` | minor (0.x.0) |
| `feat!: ...` | major (x.0.0) |
| `docs:`, `ci:`, `chore:`, `refactor:`, `test:` | no release on their own |

How a release happens:

1. Every push to `main` runs `.github/workflows/release.yml`. release-please keeps one open **release PR** (`chore(main): release x.y.z`) that bumps `pubspec.yaml`, `.release-please-manifest.json` and prepends the new section to `CHANGELOG.md`.
2. Merging that PR creates the GitHub release and pushes the tag `vX.Y.Z`.
3. The tag push runs `.github/workflows/publish_to_pubdev.yaml`, which publishes to pub.dev.

`release.yml` uses the `IMPAKTFULL_GITHUB_PAT` secret instead of `GITHUB_TOKEN`: a tag pushed with `GITHUB_TOKEN` does not trigger other workflows, and pub.dev only accepts publishes triggered by a tag push. The token needs Contents, Pull requests and Issues as "Read and write" on this repository.

To force a specific version (e.g. a pre-release), set `"release-as": "x.y.z"` in `release-please-config.json` and remove it again after that release is merged. `pubspec.yaml` must always hold a plain `x.y.z` version: release-please keeps anything after it as a build suffix (`1.0.0-dev.1` would become `1.0.0+-dev.1`).

### More than one changelog entry per pull request

A pull request that changes several things documents each of them in the changelog: put one Conventional Commit line per change in the **commit message body**, separated by blank lines. release-please turns every line into its own entry. The repository squash-merges with the commit messages as the body, so the lines must be in the branch's commits (check them in the squash dialog before merging).

```
feat: add a close animation

fix: the display timer is cancelled when a snacky is closed early

deprecate: OldName, use NewName
```

`deprecate:` lines are listed under **Deprecations** (configured in `changelog-sections` of `release-please-config.json`). They do not trigger a release on their own, so a pull request that deprecates something always also has a `feat:` title for the replacement.

## Changing public API

Everything exported from `lib/snacky.dart` is public API, including constructor parameters, fields, getters and enum values. Never rename or remove it in one step: add the new API, keep the old one working and mark it `@Deprecated('Use <replacement> instead.')`, and remove it only in a major release.

## Validate

Use the latest stable Flutter release (`flutter channel stable && flutter upgrade`); CI does the same. There is no pinned version: when a new stable release changes the output of `dart format`, update it in its own pull request.

```bash
dart format .
flutter analyze .
flutter test
```

Every pull request and push to `main` runs `.github/workflows/validate.yml` (`dart format` with no changes allowed, `flutter analyze .` of the package and the example, and `flutter test`), which must pass before merging.

## Create Pull Request

Pull requests are created on GitHub. `main` is the default branch. All changes to `main` go through a pull request.
