![Logo](https://raw.githubusercontent.com/impaktfull/flutter_snacky/main/assets/logo.svg)

[![pub package](https://img.shields.io/pub/v/snacky.svg)](https://pub.dartlang.org/packages/snacky)
[![publish to github pages](https://github.com/impaktfull/flutter_snacky/actions/workflows/publish_to_githubpages.yaml/badge.svg)](https://github.com/impaktfull/flutter_snacky/actions/workflows/publish_to_githubpages.yaml/badge.svg)
[![live_demo](https://img.shields.io/badge/Live%20Demo-Available-7D64F2)](https://example.snacky.opensource.impaktfull.com)

# You deserve a simple snack!

A lot of the current snackbar & toast libraries are too complicated for simple use cases. Snacky is a simple library that lets you show a snackbar with minimal setup and an easy-to-use API — while still giving you full control when you need it.

## 📚 Documentation

**Full documentation lives at [docs.page/impaktfull/flutter_snacky](https://docs.page/impaktfull/flutter_snacky).**

It covers installation, every option, theming with builders, responsive layout, the queue & controller, navigation handling, and the architecture & design decisions behind Snacky.

## Demo

[Live web demo](https://example.snacky.opensource.impaktfull.com)

https://github.com/Impaktfull/flutter_snacky/assets/21172855/daf176b6-77b1-44d4-a065-5e625d0ee50c

## Quick start

Wrap your app once:

```dart
@override
Widget build(BuildContext context) {
  return SnackyConfiguratorWidget(
    app: MaterialApp(
      // Optional: close snackies on push/replacement
      navigatorObservers: [
        SnackyNavigationObserver(),
      ],
      home: const HomeScreen(),
    ),
  );
}
```

Then show a snacky from anywhere:

```dart
SnackyController.instance.showMessage(
  (context) => const Snacky(
    title: 'Saved!',
    subtitle: 'Your changes have been stored.',
    type: SnackyType.success,
  ),
);
```

See the [Quick Start guide](https://docs.page/impaktfull/flutter_snacky/quick-start) for the full walkthrough, and [Showing Snackies](https://docs.page/impaktfull/flutter_snacky/guides/showing-snackies) for every option.

## License

See [LICENSE](LICENSE).
