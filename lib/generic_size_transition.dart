import 'package:flutter/material.dart';

class GenericSizeTransition extends StatefulWidget {
  final WidgetBuilder builder;
  final Curve curve;
  final Duration duration;

  const GenericSizeTransition({
    Key? key,
    required this.builder,
    this.curve = Curves.decelerate,
    this.duration = const Duration(seconds: 1),
  });
  @override
  _GenericSizeTransitionState createState() => _GenericSizeTransitionState();
}

class _GenericSizeTransitionState extends State<GenericSizeTransition>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    this.controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    super.initState();
    this.controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      child: widget.builder(context),
      sizeFactor: CurvedAnimation(
        parent: this.controller,
        curve: widget.curve,
      ),
    );
  }

  @override
  void dispose() {
    this.controller.dispose();
    super.dispose();
  }
}
