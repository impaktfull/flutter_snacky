import 'package:flutter/material.dart';
import 'package:snacky/snacky.dart';

const colorAccent = Color(0xFF7D64F2);
const colorPrimary = Color(0xFF1A1A1A);
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SnackyConfiguratorWidget(
      snackyBuilder: SimpleSnackyBuilder(
        borderRadius: BorderRadius.circular(4),
      ),
      app: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: colorAccent),
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
      body: ListView(
        padding: const EdgeInsets.all(16).add(MediaQuery.of(context).padding),
        children: [
          Image.asset(
            '../assets/logo.png',
            height: 50,
          ),
          const SizedBox(height: 16),
          ExampleButton(
            title: 'show success at the top of the screen',
            onTap: () {
              const snacky = Snacky(
                title: 'Top',
                type: SnackyType.success,
              );
              SnackyController.instance.showMessage(snacky);
            },
          ),
          ExampleButton(
            title: 'show error at the top of the screen',
            onTap: () {
              const snacky = Snacky(
                title: 'Top',
                type: SnackyType.error,
              );
              SnackyController.instance.showMessage(snacky);
            },
          ),
          ExampleButton(
            title: 'show warning at the top of the screen',
            onTap: () {
              const snacky = Snacky(
                title: 'Top',
                type: SnackyType.warning,
              );
              SnackyController.instance.showMessage(snacky);
            },
          ),
          ExampleButton(
            title: 'show info at the top of the screen',
            onTap: () {
              const snacky = Snacky(
                title: 'Top',
                type: SnackyType.info,
              );
              SnackyController.instance.showMessage(snacky);
            },
          ),
          const SizedBox(height: 32),
          ExampleButton(
            title: 'show success at the bottom of the screen',
            onTap: () {
              const snacky = Snacky(
                title: 'Bottom',
                type: SnackyType.success,
                location: SnackyLocation.bottom,
              );
              SnackyController.instance.showMessage(snacky);
            },
          ),
          ExampleButton(
            title: 'show success that can be canceled',
            onTap: () {
              const snacky = Snacky(
                title: 'Top (cancelable)',
                type: SnackyType.success,
                canBeClosed: true,
              );
              SnackyController.instance.showMessage(snacky);
            },
          ),
          ExampleButton(
            title: 'show success that can be canceled by tap',
            onTap: () {
              final snacky = Snacky(
                title: 'Top (tap to cancel)',
                type: SnackyType.success,
                onTap: () => SnackyController.instance.cancelAll(),
              );
              SnackyController.instance.showMessage(snacky);
            },
          ),
          ExampleButton(
            title: 'show successs that will stay open untill closed',
            onTap: () {
              const snacky = Snacky.openUntillClosed(
                title: 'Top (open untill closed/cancelled)',
                canBeClosed: true,
                type: SnackyType.success,
              );
              SnackyController.instance.showMessage(snacky);
            },
          ),
          ExampleButton.primary(
            title: 'cancel all snackies',
            onTap: () => SnackyController.instance.cancelAll(),
          ),
          ExampleButton.primary(
            title: 'cancel active snacky',
            onTap: () => SnackyController.instance.cancelActiveSnacky(),
          ),
        ],
      ),
    );
  }
}

class ExampleButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final Color color;

  const ExampleButton({
    required this.title,
    required this.onTap,
    super.key,
  }) : color = colorAccent;

  const ExampleButton.primary({
    required this.title,
    required this.onTap,
    super.key,
  }) : color = colorPrimary;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              color: color,
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Positioned.fill(
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: onTap,
                  child: const ColoredBox(color: Colors.transparent),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
