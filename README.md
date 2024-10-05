![Logo](https://raw.githubusercontent.com/impaktfull/flutter_snacky/master/assets/logo.svg)

[![pub package](https://img.shields.io/pub/v/snacky.svg)](https://pub.dartlang.org/packages/snacky)
[![publish to github pages](https://github.com/impaktfull/flutter_snacky/actions/workflows/publish_to_githubpages.yaml/badge.svg)](https://github.com/impaktfull/flutter_snacky/actions/workflows/publish_to_githubpages.yaml/badge.svg)
[![live_demo](https://img.shields.io/badge/Live%20Demo-Available-7D64F2)](https://example.snacky.opensource.impaktfull.com)

# You deserve a simple snack!

A lot of the current snackbar & toast libraries are too complicated for simple use cases. Snacky is a simple library that allows you to create a snackbar with minimal setup
and an easy to use API.

# Demo 

[Live Web demo](https://example.snacky.opensource.impaktfull.com)

https://github.com/Impaktfull/flutter_snacky/assets/21172855/daf176b6-77b1-44d4-a065-5e625d0ee50c

# Usage

```dart
@override
Widget build(BuildContext context) {
    return SnackyConfiguratorWidget(
        app: MaterialApp(
            ...
            // Optional if you want to close snackies on push/replacement
            navigatorObservers: [
                SnackyNavigationObserver(),
            ],
            ...
        ),
    );
}
```

## Show a snacky

```dart
final snacky = Snacky(
    title: 'My super simple snacky title',
    type: SnackyType.info, // or SnackyType.error, SnackyType.success, SnackyType.warning, SnackyType.info
    showDuration: Duration(seconds: 3), // How long the snacky should be shown
    transitionDuration: Duration(milliseconds: 300), // How long the transition should take
    transitionCurve: Curves.easeInOut, // The curve of the transition
    location: SnackyLocation.top, // Where the snacky should be shown (SnackyLocation.top or SnackyLocation.bottom)
    openUntillClosed: false, // If the snacky should be open untill closed or canceled
    canBeClosed: true, // If the snacky can be closed by the user (X button)
    onTap: () => print('Snacky tapped'), // What should happen when the snacky is tapped
    subtitle: 'My super simple snacky subtitle', // The subtitle of the snacky
    leadingWidgetBuilder: (context, snacky) => Icon(Icons.check), // A widget that should be shown before the title
    trailingWidgetBuilder: (context, snacky) => Icon(Icons.close), // A widget that should be shown after the title
);
SnackyController.instance.showMessage((context) => snacky);
```

## Show a snacky with a custom widget

```dart
final snacky = Snacky.widget(
  builder: (context, cancelableSnacky) => YourCustomSnackyWidget(),
  showDuration: Duration(seconds: 3), // How long the snacky should be shown
  transitionDuration: Duration(milliseconds: 300), // How long the transition should take
  transitionCurve: Curves.easeInOut, // The curve of the transition
  location: SnackyLocation
      .top, // Where the snacky should be shown (SnackyLocation.top or SnackyLocation.bottom)
);
SnackyController.instance.showMessage((context) => snacky);
```

## Cancel the active snacky

```dart
SnackyController.instance.cancelActiveSnacky()
```

## Cancel all snackies

```dart
SnackyController.instance.cancelAll()
```

## Easy to extend

You can use your own `SnackyController`, `SnackyBuilder` and `Snacky`-messages. This allows you to create your own snacky messages and use your own snacky controller.

By default the `SnackyController` is a singleton, but you can create your own instance of the `SnackyController` and use it in your app. Make sure to pass it to the `SnackyConfiguratorWidget` so that it can be used in the app.

By default the `SnackyBuilder` is a `SimpleSnackyBuilder`, but you can create your own `SnackyBuilder` and use it in your app. Make sure to pass it to the `SnackyConfiguratorWidget` so that it can be used in the app.

# Todo

- [ ] Add tests
- [ ] Add support for "material"-like snackies
