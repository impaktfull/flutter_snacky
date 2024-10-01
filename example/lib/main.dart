import 'package:impaktfull_ui/impaktfull_ui.dart';
import 'package:snacky_example/widget/snacky_example.dart';

const colorAccent = Color(0xFF7D64F2);
const colorPrimary = Color(0xFF1A1A1A);

final _taostSnackyController = SnackyController();
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ImpaktfullThemeConfiguratorWidget(
      child: SnackyConfiguratorWidget(
        snackyBuilder: SimpleSnackyBuilder(
          borderRadius: BorderRadius.circular(4),
        ),
        app: SnackyConfiguratorWidget(
          snackyBuilder: const ToastSnackyBuilder(),
          snackyController: _taostSnackyController,
          app: MaterialApp(
            title: 'Flutter Demo',
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
    return ImpaktfullScreen(
      child: ImpaktfullListView(
        spacing: 8,
        children: [
          Image.asset(
            '../assets/logo.png',
            height: 50,
          ),
          const SizedBox(height: 48),
          ImpaktfullButton.primary(
            label: 'Simple',
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => SnackyExampleScreen(
                  title: 'Simple',
                  controller: SnackyController.instance,
                ),
              ),
            ),
          ),
          ImpaktfullButton.primary(
            label: 'Toast',
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => SnackyExampleScreen(
                  title: 'Toast',
                  controller: _taostSnackyController,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
