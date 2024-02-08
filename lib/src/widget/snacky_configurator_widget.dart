import 'package:flutter/material.dart';
import 'package:snacky/src/builder/simple_snacky_builder.dart';
import 'package:snacky/src/builder/snacky_builder.dart';
import 'package:snacky/src/controller/snacky_controller.dart';
import 'package:snacky/src/controller/snacky_controller_listener.dart';

class SnackyConfiguratorWidget extends StatefulWidget {
  final Widget app;
  final SnackyController? snackyController;
  final SnackyBuilder snackyBuilder;
  final TextDirection textDirection;

  const SnackyConfiguratorWidget({
    required this.app,
    this.snackyController,
    this.snackyBuilder = const SimpleSnackyBuilder(),
    this.textDirection = TextDirection.ltr,
    super.key,
  });

  @override
  State<SnackyConfiguratorWidget> createState() =>
      _SnackyConfiguratorWidgetState();
}

class _SnackyConfiguratorWidgetState extends State<SnackyConfiguratorWidget>
    implements SnackyListener {
  SnackyController get snackyController =>
      widget.snackyController ?? SnackyController.instance;

  @override
  void initState() {
    snackyController.attach(this);
    super.initState();
  }

  @override
  void dispose() {
    snackyController.detach(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Positioned.fill(child: widget.app),
        Positioned.fill(
          child: Directionality(
            textDirection: widget.textDirection,
            child: ValueListenableBuilder(
              valueListenable: snackyController.activeSnacky,
              builder: (context, activeSnacky, child) {
                if (activeSnacky == null) return const SizedBox();
                return Stack(
                  key: ValueKey(activeSnacky.hashCode),
                  alignment: activeSnacky.snacky.location.alignment,
                  children: [
                    widget.snackyBuilder
                        .build(context, activeSnacky, snackyController),
                  ],
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  @override
  void notifyListeners() {
    if (!mounted) return;
    setState(() {});
  }
}
