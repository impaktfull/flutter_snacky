# 0.5.5

## Fix

- Example app name

# 0.5.4

## Fix

- Example name & app icons

# 0.5.3

## Docs

- improved readme docs

# 0.5.2

## Docs

- README.md updated to have the links to the web demo

# 0.5.1

## Fix

- Deploy to web github action

# 0.5.0

## Feat

- Deploy to web github action
- Calculate the duration of a snacky based on the title & subtitle
- Expose SnackyDurationUtil so other people can also use the calculation

# 0.4.0

## Feat

- Added layout config with SnackyLayoutConfig
- Breakpoints support with SnackyLayoutBreakpointConfig
- Default location support with SnackyLayoutBreakpointConfig

## Breaking

- Requires SnackyLayoutConfig to be passed to the building blocks
- Snacky.location is now optional. null (defaults to SnackyLayoutBreakpointConfig.snackyLocation)

## Fix

- Snackies always stayed in the widgettree. (Fixed by using `OverlayEntry.remove()` function)

# 0.3.0

## Feat

- ToastSnackyBuilder is added
- GradientSnackyBuilder is added
- Simplified the example app

## Breaking

- Changed the leading icons for the SimpleSnackyBuilder

# 0.2.5

## Fix

- Yellow underline (because of missing `Material` widget)

## Docs

- Added documentation on the Snacky custom widget implementation

# 0.2.4

## CI

- improved CI test job

# 0.2.3

## CI

- CI test job

# 0.2.2

## Test

- Smoke test to show notifications
- Smoke test to check if onTap works

# 0.2.1

## Documentation

- Fixed readme.md

# 0.2.0

## Breaking

- Added support to use context before creating the `Snacky` object

## Feat

- Switch to OverlayState instead of a custom implementation

# 0.1.0

## Feat

- Added support for custom notification builders.
- Added support for more SnackyLocations. (top, topStart, topEnd, bottom, bottomStart, bottomEnd)
- Better swipe to dismiss support.

# 0.0.14

## Fix

- Better documentation in the `README.md` about the `SnackyNavigationObserver`

# 0.0.12 - 0.0.13

## Fix

- Extra documentation in the `README.md`

# 0.0.10 - 0.0.11

## Fix

- Automated builds using GitHub Actions
- Added preview video to the `README.md`

# 0.0.4 - 0.0.9

## Fix

- Added `Snacky` logo to the `README.md`

# 0.0.3

## Fix

- Exported all requried files
- Cancel all snackies when a new route is pushed or a route is replaced `SnackyNavigationObserver`

# 0.0.2

## Fix

- Description of the package
- Spacing between leading & text & trailing widgets

# 0.0.1

- initial release
