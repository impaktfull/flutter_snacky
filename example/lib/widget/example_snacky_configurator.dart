import 'package:impaktfull_ui/impaktfull_ui.dart';

final taostSnackyController = SnackyController();
final gradientSnackyController = SnackyController();

class ExampleSnackyConfigurator extends StatelessWidget {
  final Widget child;

  const ExampleSnackyConfigurator({
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SnackyConfiguratorWidget(
      snackyBuilder: SimpleSnackyBuilder(
        borderRadius: BorderRadius.circular(4),
      ),
      app: SnackyConfiguratorWidget(
        snackyBuilder: const ToastSnackyBuilder(),
        snackyController: taostSnackyController,
        app: SnackyConfiguratorWidget(
          snackyBuilder: const GradientSnackyBuilder(),
          snackyController: gradientSnackyController,
          app: child,
        ),
      ),
    );
  }
}
