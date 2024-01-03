part of '../widgets/widgets.dart';

class AnimatedPlayButton extends StatefulWidget {
  const AnimatedPlayButton(
      {super.key, required this.isPlaying, required this.onTap});
  final bool isPlaying;
  final Function(AnimationController animationController) onTap;

  @override
  State<AnimatedPlayButton> createState() => _AnimatedPlayButtonState();
}

class _AnimatedPlayButtonState extends State<AnimatedPlayButton>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..forward();
    /* ..repeat(reverse: true); */
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(controller);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => widget.onTap(controller),
      child: Container(
        width: 50.0,
        height: 50.0,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.green,
        ),
        child: Center(
          child: AnimatedIcon(
            icon: AnimatedIcons.pause_play,
            progress: animation,
            size: 35.0,
            color: Colors.white,
            semanticLabel: 'Show menu',
          ),
        ),
        /*  onPressed: () {
          /* if (widget.isPlaying) {
            controller.reverse();
            /* widget.isPlaying = false; */
          } else {
            controller.forward();
            /* widget.isPlaying = true; */
          } */
          widget.onTap(controller);
        }, */
      ),
    );
  }
}
