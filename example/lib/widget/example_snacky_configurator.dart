import 'package:impaktfull_ui/impaktfull_ui.dart';

final taostSnackyController = SnackyController();
final gradientSnackyController = SnackyController();
final layoutConfigSnackyController = SnackyController();

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
          snackyBuilder: GradientSnackyBuilder(
            borderRadius: BorderRadius.circular(4),
          ),
          snackyController: gradientSnackyController,
          app: SnackyConfiguratorWidget(
            snackyBuilder: SimpleSnackyBuilder(
              borderRadius: BorderRadius.circular(4),
            ),
            snackyController: layoutConfigSnackyController,
            layoutConfig: const SnackyLayoutConfig(
              breakpoints: [
                SnackyLayoutBreakpointConfig(
                  minWidth: 0,
                  maxWidth: 600,
                  snackyMaxWidth: double.infinity,
                  snackyLocation: SnackyLocation.top,
                ),
                SnackyLayoutBreakpointConfig(
                  minWidth: 600,
                  maxWidth: 900,
                  snackyMaxWidth: 300,
                  snackyLocation: SnackyLocation.topEnd,
                ),
                SnackyLayoutBreakpointConfig(
                  minWidth: 900,
                  maxWidth: double.infinity,
                  snackyPercentage: 0.33,
                  snackyMaxWidth: 600,
                  snackyLocation: SnackyLocation.topEnd,
                ),
              ],
            ),
            app: child,
          ),
        ),
      ),
    );
  }
}
