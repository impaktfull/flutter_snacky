import 'package:flutter/material.dart';
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
    return ImpaktfullUiScreen(
      title: '$title Snacky Example',
      onBackTapped: () => Navigator.of(context).pop(),
      child: ImpaktfullUiListView(
        spacing: 8,
        padding: const EdgeInsets.all(16),
        children: [
          ImpaktfullUiButton(
            type: ImpaktfullUiButtonType.primary,
            title: 'show success at the Top of the screen',
            onTap: () {
              const snacky = Snacky(
                title: 'Success (Top)',
                type: SnackyType.success,
              );
              controller.showMessage((context) => snacky);
            },
          ),
          ImpaktfullUiButton(
            type: ImpaktfullUiButtonType.primary,
            title: 'show error at the Top of the screen',
            onTap: () {
              const snacky = Snacky(
                title: 'Error (Top)',
                type: SnackyType.error,
              );
              controller.showMessage((context) => snacky);
            },
          ),
          ImpaktfullUiButton(
            type: ImpaktfullUiButtonType.primary,
            title: 'show warning at the Top of the screen',
            onTap: () {
              const snacky = Snacky(
                title: 'Warning (Top)',
                type: SnackyType.warning,
              );
              controller.showMessage((context) => snacky);
            },
          ),
          ImpaktfullUiButton(
            type: ImpaktfullUiButtonType.primary,
            title: 'show info at the Top of the screen',
            onTap: () {
              const snacky = Snacky(
                title: 'Info (Top)',
                type: SnackyType.info,
              );
              controller.showMessage((context) => snacky);
            },
          ),
          ImpaktfullUiButton(
            type: ImpaktfullUiButtonType.primary,
            title: 'show branded at the Top of the screen',
            onTap: () {
              const snacky = Snacky(
                title: 'Branded (Top)',
                type: SnackyType.branded,
              );
              controller.showMessage((context) => snacky);
            },
          ),
          ImpaktfullUiButton(
            type: ImpaktfullUiButtonType.primary,
            title: 'show success at the bottom of the screen',
            onTap: () {
              const snacky = Snacky(
                title: 'Success (bottom)',
                type: SnackyType.success,
                location: SnackyLocation.bottom,
              );
              controller.showMessage((context) => snacky);
            },
          ),
          ImpaktfullUiButton(
            type: ImpaktfullUiButtonType.primary,
            title: 'show success that can be canceled',
            onTap: () {
              const snacky = Snacky(
                title: 'Success (Top - cancelable)',
                type: SnackyType.success,
                canBeClosed: true,
              );
              controller.showMessage((context) => snacky);
            },
          ),
          ImpaktfullUiButton(
            type: ImpaktfullUiButtonType.primary,
            title: 'show success that can be canceled by tap',
            onTap: () {
              final snacky = Snacky(
                title: 'Success (Top - tap to cancel)',
                type: SnackyType.success,
                onTap: () => controller.cancelAll(),
              );
              controller.showMessage((context) => snacky);
            },
          ),
          ImpaktfullUiButton(
            type: ImpaktfullUiButtonType.primary,
            title: 'show success that will stay open untill closed',
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
          ImpaktfullUiButton(
            type: ImpaktfullUiButtonType.primary,
            title: 'show success at the top end of the screen',
            onTap: () {
              const snacky = Snacky(
                title: 'Success (TopEnd)',
                type: SnackyType.success,
                location: SnackyLocation.topEnd,
              );
              controller.showMessage((context) => snacky);
            },
          ),
          ImpaktfullUiButton(
            type: ImpaktfullUiButtonType.primary,
            title: 'show custom widget',
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
          ImpaktfullUiButton(
            type: ImpaktfullUiButtonType.primary,
            title: 'show custom widget that will still open until closed',
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
                location: SnackyLocation.bottom,
                canBeClosed: true,
                openUntillClosed: true,
                padding:
                    const EdgeInsets.only(bottom: kBottomNavigationBarHeight),
              );
              controller.showMessage((context) => snacky);
            },
          ),
          ImpaktfullUiButton(
            type: ImpaktfullUiButtonType.secondary,
            title: 'cancel all snackies',
            onTap: () => controller.cancelAll(),
          ),
          ImpaktfullUiButton(
            type: ImpaktfullUiButtonType.secondary,
            title: 'cancel active snacky',
            onTap: () => controller.cancelActiveSnacky(),
          ),
        ],
      ),
    );
  }
}
