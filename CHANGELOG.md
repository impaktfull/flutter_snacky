# Changelog

## [0.9.0](https://github.com/impaktfull/flutter_snacky/compare/v0.8.0...v0.9.0) (2026-09-22)


### Features

* Updated docs & example to support latest flutter version ([b963d9f](https://github.com/impaktfull/flutter_snacky/commit/b963d9fac2b3735f5d2eff00a0d3863dd92c0651))


### Bug Fixes

* cancel the display timer when a snacky is closed early ([#11](https://github.com/impaktfull/flutter_snacky/issues/11)) ([120dc49](https://github.com/impaktfull/flutter_snacky/commit/120dc49c08d0de45ef8a9f592b5fa784e6e31c1e))
* documentation ([99d51cd](https://github.com/impaktfull/flutter_snacky/commit/99d51cdb5e1e45f80468cfa6e2b2b9760cb547f6))
* full width buttons ([c7054e0](https://github.com/impaktfull/flutter_snacky/commit/c7054e00d683abeb2bd148a0fb3b323401df6cf0))
* SnackyController shows snackies again after its configurator is removed while a snacky is active ([120dc49](https://github.com/impaktfull/flutter_snacky/commit/120dc49c08d0de45ef8a9f592b5fa784e6e31c1e))

## 0.8.0

### Feat

- Added `padding` to `Snacky`
- Added `openUntilClosed` and `canBeClosed` as an option for a `Snacky.widget`

## 0.7.0

### Feat

- Added `margin` to `Snacky`

## 0.6.1 - 0.6.2

### Fix

- Fix `OverlayState` null check

- github action to publish to github pages

## 0.6.0

### Feat

- Make shadow configurable in the `SimpleSnackyBuilder`

### Fix

- Deprecated `color.withOpacity` by using our own `color.withOpacityPercentage` extension

## 0.5.7

### Fix

- Updated license

## 0.5.6

### Fix

- layout config `width`

## 0.5.5

### Fix

- Example app name

## 0.5.4

### Fix

- Example name & app icons

## 0.5.3

### Docs

- improved readme docs

## 0.5.2

### Docs

- README.md updated to have the links to the web demo

## 0.5.1

### Fix

- Deploy to web github action

## 0.5.0

### Feat

- Deploy to web github action
- Calculate the duration of a snacky based on the title & subtitle
- Expose SnackyDurationUtil so other people can also use the calculation

## 0.4.0

### Feat

- Added layout config with SnackyLayoutConfig
- Breakpoints support with SnackyLayoutBreakpointConfig
- Default location support with SnackyLayoutBreakpointConfig

### Breaking

- Requires SnackyLayoutConfig to be passed to the building blocks
- Snacky.location is now optional. null (defaults to SnackyLayoutBreakpointConfig.snackyLocation)

### Fix

- Snackies always stayed in the widgettree. (Fixed by using `OverlayEntry.remove()` function)

## 0.3.0

### Feat

- ToastSnackyBuilder is added
- GradientSnackyBuilder is added
- Simplified the example app

### Breaking

- Changed the leading icons for the SimpleSnackyBuilder

## 0.2.5

### Fix

- Yellow underline (because of missing `Material` widget)

### Docs

- Added documentation on the Snacky custom widget implementation

## 0.2.4

### CI

- improved CI test job

## 0.2.3

### CI

- CI test job

## 0.2.2

### Test

- Smoke test to show notifications
- Smoke test to check if onTap works

## 0.2.1

### Documentation

- Fixed readme.md

## 0.2.0

### Breaking

- Added support to use context before creating the `Snacky` object

### Feat

- Switch to OverlayState instead of a custom implementation

## 0.1.0

### Feat

- Added support for custom notification builders.
- Added support for more SnackyLocations. (top, topStart, topEnd, bottom, bottomStart, bottomEnd)
- Better swipe to dismiss support.

## 0.0.14

### Fix

- Better documentation in the `README.md` about the `SnackyNavigationObserver`

## 0.0.12 - 0.0.13

### Fix

- Extra documentation in the `README.md`

## 0.0.10 - 0.0.11

### Fix

- Automated builds using GitHub Actions
- Added preview video to the `README.md`

## 0.0.4 - 0.0.9

### Fix

- Added `Snacky` logo to the `README.md`

## 0.0.3

### Fix

- Exported all requried files
- Cancel all snackies when a new route is pushed or a route is replaced `SnackyNavigationObserver`

## 0.0.2

### Fix

- Description of the package
- Spacing between leading & text & trailing widgets

## 0.0.1

- initial release
