import 'package:flutter/widgets.dart';

class GenericSlideTransition extends StatefulWidget {
  final WidgetBuilder builder;
  final Offset initialOffset;
  final Offset endOffset;
  final Curve curve;
  final Duration duration;

  const GenericSlideTransition({
    Key? key,
    required this.builder,
    required this.initialOffset,
    this.endOffset = Offset.zero,
    this.curve = Curves.decelerate,
    this.duration = const Duration(seconds: 1),
  }) : super(key: key);

  @override
  _GenericSlideTransitionState createState() => _GenericSlideTransitionState();
}

class _GenericSlideTransitionState extends State<GenericSlideTransition>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetFloat;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    _offsetFloat =
        Tween<Offset>(begin: widget.initialOffset, end: widget.endOffset)
            .animate(
      CurvedAnimation(parent: _controller, curve: widget.curve),
    );

    super.initState();
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      child: widget.builder(context),
      position: _offsetFloat,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
