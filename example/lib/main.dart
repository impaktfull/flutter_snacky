import 'package:flutter/material.dart';
import 'package:impaktfull_ui/impaktfull_ui.dart';
// We import this one because normally you would never use ImpaktfullUiThemeConfigurator directly because it is an internal widget
// ignore: implementation_imports
import 'package:impaktfull_ui/src/components/theme/theme_configurator.dart';
// We import this one because normally you would never use ImpaktfullUiLocalizationConfigurator directly because it is an internal widget
// ignore: implementation_imports
import 'package:impaktfull_ui/src/components/localization/localization_configurator.dart';
import 'package:snacky_example/widget/example_snacky_configurator.dart';
import 'package:snacky_example/widget/snacky_example.dart';

const colorAccent = Color(0xFF7D64F2);
const colorPrimary = Color(0xFF1A1A1A);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ImpaktfullUiThemeConfigurator(
      theme: ImpaktfullUiTheme.getDefault(),
      child: ImpaktfullUiLocalizationConfigurator(
        localizations: const ImpaktfullUiLocalizations(),
        child: ExampleSnackyConfigurator(
          child: MaterialApp(
            title: 'Snacky',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: colorAccent),
              useMaterial3: true,
            ),
            navigatorObservers: [
              SnackyNavigationObserver(),
            ],
            home: const HomeScreen(),
          ),
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ImpaktfullUiScreen(
      child: ImpaktfullUiListView(
        spacing: 8,
        padding: const EdgeInsets.all(16),
        children: [
          Image.asset(
            '../assets/logo.png',
            height: 50,
          ),
          const SizedBox(height: 48),
          ImpaktfullUiButton(
            type: ImpaktfullUiButtonType.primary,
            title: 'Simple',
            fullWidth: true,
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => SnackyExampleScreen(
                  title: 'Simple',
                  controller: SnackyController.instance,
                ),
              ),
            ),
          ),
          ImpaktfullUiButton(
            type: ImpaktfullUiButtonType.primary,
            title: 'Toast',
            fullWidth: true,
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => SnackyExampleScreen(
                  title: 'Toast',
                  controller: taostSnackyController,
                ),
              ),
            ),
          ),
          ImpaktfullUiButton(
            type: ImpaktfullUiButtonType.primary,
            title: 'Gradient',
            fullWidth: true,
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => SnackyExampleScreen(
                  title: 'Gradient',
                  controller: gradientSnackyController,
                ),
              ),
            ),
          ),
          ImpaktfullUiButton(
            type: ImpaktfullUiButtonType.primary,
            title: 'Layout Config tester',
            fullWidth: true,
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => SnackyExampleScreen(
                  title: 'Layout Config',
                  controller: layoutConfigSnackyController,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
