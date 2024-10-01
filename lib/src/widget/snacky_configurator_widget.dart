import 'package:flutter/material.dart';
import 'package:snacky/src/builder/simple_snacky_builder.dart';
import 'package:snacky/src/builder/snacky_builder.dart';
import 'package:snacky/src/config/snacky_layout_config.dart';
import 'package:snacky/src/controller/snacky_controller.dart';
import 'package:snacky/src/controller/snacky_controller_listener.dart';
import 'package:snacky/src/model/cancelable_snacky.dart';

class SnackyConfiguratorWidget extends StatefulWidget {
  final Widget app;
  final SnackyController? snackyController;
  final SnackyBuilder snackyBuilder;
  final TextDirection textDirection;
  final SnackyLayoutConfig? layoutConfig;

  const SnackyConfiguratorWidget({
    required this.app,
    this.snackyController,
    this.snackyBuilder = const SimpleSnackyBuilder(),
    this.textDirection = TextDirection.ltr,
    this.layoutConfig,
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
  SnackyLayoutConfig get layoutConfig =>
      widget.layoutConfig ?? const SnackyLayoutConfig();

  @override
  void initState() {
    layoutConfig.validate();
    snackyController.attach(this);
    super.initState();
  }

  @override
  void dispose() {
    snackyController.detach(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.app;

  @override
  Widget buildSnacky(BuildContext context, CancelableSnacky activeSnacky) {
    final snackyLocation =
        layoutConfig.getSnackyLocation(context, activeSnacky.snacky);
    return Builder(
      builder: (context) => Stack(
        key: ValueKey(activeSnacky.hashCode),
        alignment: snackyLocation.alignment,
        children: [
          widget.snackyBuilder.build(
            context,
            layoutConfig,
            activeSnacky,
            snackyController,
          ),
        ],
      ),
    );
  }

  @override
  OverlayState? getOverlayState() {
    NavigatorState? navigator;
    void visitor(Element element) {
      if (navigator != null) return;
      if (element.widget is Navigator) {
        navigator = (element as StatefulElement).state as NavigatorState?;
      } else {
        element.visitChildElements(visitor);
      }
    }

    context.visitChildElements(visitor);

    assert(navigator != null,
        '''It looks like you are not using Navigator in your app.
         Do you wrapped you app widget like this?
         SnackyConfiguratorWidget(
           app: MaterialApp(
             title: 'Snacky Example',
             home: HomeScren(),
           ),
         )
      ''');
    return navigator?.overlay;
  }

  @override
  void notifyListeners() {
    if (!mounted) return;
    setState(() {});
  }
}
