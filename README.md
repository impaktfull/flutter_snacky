![Logo](https://raw.githubusercontent.com/impaktfull/flutter_snacky/master/assets/logo.svg)

[![pub package](https://img.shields.io/pub/v/snacky.svg)](https://pub.dartlang.org/packages/snacky)

# You deserve a simple snack!

A lot of the current snackbar & toast libraries are too complicated for simple use cases. Snacky is a simple library that allows you to create a snackbar with minimal setup 
and an easy to use API.

# Demo

https://github.com/Impaktfull/flutter_snacky/assets/21172855/daf176b6-77b1-44d4-a065-5e625d0ee50c

# Usage

```dart
@override
Widget build(BuildContext context) {
    return SnackyConfiguratorWidget(
        app: MaterialApp(
            ...
        ),
    );
}
```

## Show a snacky
```dart
final snacky = Snacky(
    title: 'My super simple snacky title',
);
SnackyController.instance.showMessage(snacky);
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
