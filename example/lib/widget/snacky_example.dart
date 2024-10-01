import 'package:impaktfull_ui/impaktfull_ui.dart';

class SnackyExampleScreen extends StatelessWidget {
  final String title;
  final SnackyController controller;

  const SnackyExampleScreen({
    required this.title,
    required this.controller,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ImpaktfullScreen(
      title: '$title Snacky Example',
      onBackTapped: () => Navigator.of(context).pop(),
      child: ImpaktfullListView(
        spacing: 8,
        children: [
          ImpaktfullButton.accent(
            label: 'show success at the Top of the screen',
            onTap: () {
              const snacky = Snacky(
                title: 'Success (Top)',
                type: SnackyType.success,
              );
              controller.showMessage((context) => snacky);
            },
          ),
          ImpaktfullButton.accent(
            label: 'show error at the Top of the screen',
            onTap: () {
              const snacky = Snacky(
                title: 'Error (Top)',
                type: SnackyType.error,
              );
              controller.showMessage((context) => snacky);
            },
          ),
          ImpaktfullButton.accent(
            label: 'show warning at the Top of the screen',
            onTap: () {
              const snacky = Snacky(
                title: 'Warning (Top)',
                type: SnackyType.warning,
              );
              controller.showMessage((context) => snacky);
            },
          ),
          ImpaktfullButton.accent(
            label: 'show info at the Top of the screen',
            onTap: () {
              const snacky = Snacky(
                title: 'Info (Top)',
                type: SnackyType.info,
              );
              controller.showMessage((context) => snacky);
            },
          ),
          ImpaktfullButton.accent(
            label: 'show branded at the Top of the screen',
            onTap: () {
              const snacky = Snacky(
                title: 'Branded (Top)',
                type: SnackyType.branded,
              );
              controller.showMessage((context) => snacky);
            },
          ),
          ImpaktfullButton.accent(
            label: 'show success at the bottom of the screen',
            onTap: () {
              const snacky = Snacky(
                title: 'Success (bottom)',
                type: SnackyType.success,
                location: SnackyLocation.bottom,
              );
              controller.showMessage((context) => snacky);
            },
          ),
          ImpaktfullButton.accent(
            label: 'show success that can be canceled',
            onTap: () {
              const snacky = Snacky(
                title: 'Success (Top - cancelable)',
                type: SnackyType.success,
                canBeClosed: true,
              );
              controller.showMessage((context) => snacky);
            },
          ),
          ImpaktfullButton.accent(
            label: 'show success that can be canceled by tap',
            onTap: () {
              final snacky = Snacky(
                title: 'Success (Top - tap to cancel)',
                type: SnackyType.success,
                onTap: () => controller.cancelAll(),
              );
              controller.showMessage((context) => snacky);
            },
          ),
          ImpaktfullButton.accent(
            label: 'show successs that will stay open untill closed',
            onTap: () {
              const snacky = Snacky(
                title: 'Success (Top - open untill closed/cancelled)',
                canBeClosed: true,
                type: SnackyType.success,
                openUntillClosed: true,
              );
              controller.showMessage((context) => snacky);
            },
          ),
          ImpaktfullButton.accent(
            label: 'show successs at the top end of the screen',
            onTap: () {
              const snacky = Snacky(
                title: 'Success (TopEnd)',
                type: SnackyType.success,
                location: SnackyLocation.topEnd,
              );
              controller.showMessage((context) => snacky);
            },
          ),
          ImpaktfullButton.accent(
            label: 'show custom widget',
            onTap: () {
              final snacky = Snacky.widget(
                builder: (context, cancelabelSnacky) => Container(
                  color: const Color(0xFF7D64F2),
                  padding: const EdgeInsets.all(16),
                  child: const Text(
                    'This is a custom widget',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                location: SnackyLocation.topEnd,
              );
              controller.showMessage((context) => snacky);
            },
          ),
          ImpaktfullButton.primary(
            label: 'cancel all snackies',
            onTap: () => controller.cancelAll(),
          ),
          ImpaktfullButton.primary(
            label: 'cancel active snacky',
            onTap: () => controller.cancelActiveSnacky(),
          ),
        ],
      ),
    );
  }
}
