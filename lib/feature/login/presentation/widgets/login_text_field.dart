import 'package:flutter/material.dart';

class AnimatedClipRect extends StatefulWidget {
  @override
  State<AnimatedClipRect> createState() => _AnimatedClipRectState();

  final Widget child;
  final bool open;
  final bool horizontalAnimation;
  final bool verticalAnimation;
  final Alignment alignment;
  final Duration duration;
  final Duration? reverseDuration;
  final Curve curve;
  final Curve? reverseCurve;

  final AnimationBehavior animationBehavior;

  const AnimatedClipRect({
    super.key,
    required this.child,
    required this.open,
    this.horizontalAnimation = true,
    this.verticalAnimation = true,
    this.alignment = Alignment.center,
    this.duration = const Duration(milliseconds: 500),
    this.reverseDuration,
    this.curve = Curves.linear,
    this.reverseCurve,
    this.animationBehavior = AnimationBehavior.normal,
  });
}

class _AnimatedClipRectState extends State<AnimatedClipRect>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation _animation;

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _animationController = AnimationController(
        duration: widget.duration,
        reverseDuration: widget.reverseDuration ?? widget.duration,
        vsync: this,
        value: widget.open ? 1.0 : 0.0,
        animationBehavior: widget.animationBehavior);
    _animation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _animationController,
      curve: widget.curve,
      reverseCurve: widget.reverseCurve ?? widget.curve,
    ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    widget.open
        ? _animationController.forward()
        : _animationController.reverse();

    return ClipRect(
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (_, child) {
          return Align(
            alignment: widget.alignment,
            heightFactor: widget.verticalAnimation ? _animation.value : 1.0,
            widthFactor: widget.horizontalAnimation ? _animation.value : 1.0,
            child: child,
          );
        },
        child: widget.child,
      ),
    );
  }
}

class LoginTextField extends StatefulWidget {
  final FocusNode focusNode;
  final TextEditingController controller;
  final String label;
  final Widget leadingIcon;

  LoginTextField(
      {super.key,
      FocusNode? focusNode,
      required this.controller,
      required this.label,
      required this.leadingIcon})
      : focusNode = focusNode ?? FocusNode();

  @override
  State<LoginTextField> createState() => _LoginTextFieldState();
}

class _LoginTextFieldState extends State<LoginTextField> {
  bool target = true;

  void focusListener() {
    if (widget.focusNode.hasFocus || widget.controller.text.isNotEmpty) {
      setState(() {
        target = false;
      });
    } else {
      setState(() {
        target = true;
      });
    }
  }

  @override
  void initState() {
    widget.focusNode.addListener(focusListener);
    super.initState();
  }

  @override
  void dispose() {
    widget.focusNode.dispose();
    widget.controller.dispose();
    widget.focusNode.removeListener(focusListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      focusNode: widget.focusNode,
      decoration: InputDecoration(
          label: Text(widget.label),
          prefixIcon: Padding(
            padding: const EdgeInsets.all(8),
            child: AnimatedClipRect(
              open: target,
              horizontalAnimation: true,
              verticalAnimation: false,
              alignment: Alignment.center,
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOut,
              reverseCurve: Curves.easeIn,
              child: widget.leadingIcon,
            ),
          ),
          prefixIconConstraints: const BoxConstraints(maxWidth: 40, maxHeight: 40),
          isDense: true,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
    );
  }
}
