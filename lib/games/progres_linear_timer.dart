part of '../widgets/widgets.dart';

class ProgresLinearTimer extends StatefulWidget {
  final int durationMiliseconds;
  final Function onTimerFinish;
  final EdgeInsetsGeometry? margin;
  const ProgresLinearTimer({
    super.key,
    required this.durationMiliseconds,
    required this.onTimerFinish,
    this.margin,
  });

  @override
  _ProgresLinearTimerState createState() => _ProgresLinearTimerState();
}

class _ProgresLinearTimerState extends State<ProgresLinearTimer> {
  late int _milisecondsRemaining;
  late double _barWidth;
  int durationMiliseconds = 17;
  late Timer timer;
  @override
  void initState() {
    super.initState();
    _milisecondsRemaining = widget.durationMiliseconds;
    _barWidth = 1.0;
    startTimer();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  void startTimer() {
    timer =
        Timer.periodic(Duration(milliseconds: durationMiliseconds), (timer) {
      if (mounted) {
        setState(() {
          if (_milisecondsRemaining > 0) {
            _milisecondsRemaining -= durationMiliseconds;
            _barWidth = _milisecondsRemaining <= 0
                ? 0
                : _milisecondsRemaining / widget.durationMiliseconds;
          } else {
            widget.onTimerFinish();
            timer.cancel();
          }
        });
      } else {
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: widget.margin,
          height: 30.0,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            color: Colors.green,
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: _barWidth,
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 30,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Text(
                      _milisecondsRemaining <= 0
                          ? "finished"
                          : ("${(_milisecondsRemaining / 1000).toStringAsFixed(0)}s left"),
                      style: TextStyle(
                        color: _milisecondsRemaining <= 0
                            ? Colors.white
                            : Colors.black,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  const Icon(
                    Icons.timer_sharp,
                    color: Colors.white,
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
