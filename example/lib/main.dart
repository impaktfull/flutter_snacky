import 'package:flutter/material.dart';
import 'package:snacky/snacky.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SnackyConfiguratorWidget(
      app: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Snacky Example'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          FilledButton(
            onPressed: () {
              const snacky = Snacky(
                title: 'Top',
              );
              SnackyController.instance.showMessage(snacky);
            },
            child: const Text('show snacky at the top of the screen'),
          ),
          FilledButton(
            onPressed: () {
              const snacky = Snacky(
                title: 'Bottom',
                location: SnackyLocation.bottom,
              );
              SnackyController.instance.showMessage(snacky);
            },
            child: const Text('show snacky at the bottom of the screen'),
          ),
          FilledButton(
            onPressed: () {
              const snacky = Snacky(
                title: 'Top (cancelable)',
                canBeClosed: true,
              );
              SnackyController.instance.showMessage(snacky);
            },
            child: const Text('show snacky that can be canceled'),
          ),
          FilledButton(
            onPressed: () {
              final snacky = Snacky(
                title: 'Top (tap to cancel)',
                onTap: () => SnackyController.instance.cancelAll(),
              );
              SnackyController.instance.showMessage(snacky);
            },
            child: const Text('show snacky that can be canceled by tap'),
          ),
          FilledButton(
            onPressed: () {
              const snacky = Snacky.openUntillClosed(
                title: 'Top (open untill closed/cancelled)',
                canBeClosed: true,
              );
              SnackyController.instance.showMessage(snacky);
            },
            child: const Text('show snacky that will stay open untill closed'),
          ),
          FilledButton(
            onPressed: () => SnackyController.instance.cancelAll(),
            child: const Text('cancel all snackies'),
          ),
          FilledButton(
            onPressed: () => SnackyController.instance.cancelActiveSnacky(),
            child: const Text('cancel active snacky'),
          ),
        ],
      ),
    );
  }
}
