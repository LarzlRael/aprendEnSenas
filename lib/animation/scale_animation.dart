part of '../widgets/widgets.dart';

class ScaleAnimation extends StatefulWidget {
  final Widget children;
  final Duration duration;
  const ScaleAnimation({
    super.key,
    required this.children,
    this.duration = const Duration(milliseconds: 500),
  });

  @override
  State<ScaleAnimation> createState() => _ScaleAnimationState();
}

class _ScaleAnimationState extends State<ScaleAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  @override
  initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    _animation = Tween<double>(begin: 1, end: 2).animate(_controller);

    // Agrega un listener para detectar cuando la animación ha completado
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // Cuando la animación se completa, invertir la animación
        _controller.reverse();
      }
    });

    // Inicia la animación
    _controller.forward();
  }

  @override
  dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      key: widget.key,
      animation: _animation,
      builder: (_, __) {
        return Transform.scale(
          scale: _animation.value,
          child: widget.children,
          key: widget.key,
        );
      },
    );
  }
}
