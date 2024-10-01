import 'package:impaktfull_ui/impaktfull_ui.dart';

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
        navigatorObservers: [
          SnackyNavigationObserver(),
        ],
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
          ImpaktfullButton.accent(
            label: 'show success at the top of the screen',
            onTap: () {
              const snacky = Snacky(
                title: 'Top',
                type: SnackyType.success,
              );
              SnackyController.instance.showMessage((context) => snacky);
            },
          ),
          ImpaktfullButton.accent(
            label: 'show error at the top of the screen',
            onTap: () {
              const snacky = Snacky(
                title: 'Top',
                type: SnackyType.error,
              );
              SnackyController.instance.showMessage((context) => snacky);
            },
          ),
          ImpaktfullButton.accent(
            label: 'show warning at the top of the screen',
            onTap: () {
              const snacky = Snacky(
                title: 'Top',
                type: SnackyType.warning,
              );
              SnackyController.instance.showMessage((context) => snacky);
            },
          ),
          ImpaktfullButton.accent(
            label: 'show info at the top of the screen',
            onTap: () {
              const snacky = Snacky(
                title: 'Top',
                type: SnackyType.info,
              );
              SnackyController.instance.showMessage((context) => snacky);
            },
          ),
          const SizedBox(height: 32),
          ImpaktfullButton.accent(
            label: 'show success at the bottom of the screen',
            onTap: () {
              const snacky = Snacky(
                title: 'Bottom',
                type: SnackyType.success,
                location: SnackyLocation.bottom,
              );
              SnackyController.instance.showMessage((context) => snacky);
            },
          ),
          ImpaktfullButton.accent(
            label: 'show success that can be canceled',
            onTap: () {
              const snacky = Snacky(
                title: 'Top (cancelable)',
                type: SnackyType.success,
                canBeClosed: true,
              );
              SnackyController.instance.showMessage((context) => snacky);
            },
          ),
          ImpaktfullButton.accent(
            label: 'show success that can be canceled by tap',
            onTap: () {
              final snacky = Snacky(
                title: 'Top (tap to cancel)',
                type: SnackyType.success,
                onTap: () => SnackyController.instance.cancelAll(),
              );
              SnackyController.instance.showMessage((context) => snacky);
            },
          ),
          ImpaktfullButton.accent(
            label: 'show successs that will stay open untill closed',
            onTap: () {
              const snacky = Snacky(
                title: 'Top (open untill closed/cancelled)',
                canBeClosed: true,
                type: SnackyType.success,
                openUntillClosed: true,
              );
              SnackyController.instance.showMessage((context) => snacky);
            },
          ),
          ImpaktfullButton.accent(
            label: 'show custom widget',
            onTap: () {
              final snacky = Snacky.widget(
                builder: (context, cancelabelSnacky) => Container(
                  color: Colors.amber,
                  padding: const EdgeInsets.all(16),
                  child: const Text('This is a custom widget'),
                ),
                location: SnackyLocation.topEnd,
              );
              SnackyController.instance.showMessage((context) => snacky);
            },
          ),
          ImpaktfullButton.primary(
            label: 'cancel all snackies',
            onTap: () => SnackyController.instance.cancelAll(),
          ),
          ImpaktfullButton.primary(
            label: 'cancel active snacky',
            onTap: () => SnackyController.instance.cancelActiveSnacky(),
          ),
        ],
      ),
    );
  }
}
