part of '../widgets/widgets.dart';

class ShakingXAnimation extends StatefulWidget {
  final Widget child;
  final bool shouldAnimate;

  const ShakingXAnimation(
      {super.key, required this.shouldAnimate, required this.child});
  @override
  _ShakingXAnimationState createState() => _ShakingXAnimationState();
}

class _ShakingXAnimationState extends State<ShakingXAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    _animation = Tween<double>(begin: -10, end: 10).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // Si la animación se completa, restablecer shouldAnimate a false
        _controller.stop();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _animation.value),
          child: widget.child,
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
