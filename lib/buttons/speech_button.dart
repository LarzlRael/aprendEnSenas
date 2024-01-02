part of '../widgets/widgets.dart';

class SpeechButton extends StatefulWidget {
  final void Function(String result) onSpeechResult;
  const SpeechButton({super.key, required this.onSpeechResult});

  @override
  State<SpeechButton> createState() => _SpeechButtonState();
}

class _SpeechButtonState extends State<SpeechButton> {
  SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _lastWords = '';
  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _lastWords = result.recognizedWords;
      widget.onSpeechResult(_lastWords);
    });
  }

  /// Each time to start a speech recognition session
  void _startListening() async {
    await _speechToText.listen(
      onResult: _onSpeechResult,
      localeId: 'es_ES',
    );
    setState(() {});
  }

  /// Manually stop the active speech recognition session
  /// Note that there are also timeouts that each platform enforces
  /// and the SpeechToText plugin supports setting timeouts on the
  /// listen method.
  void _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  @override
  initState() {
    super.initState();
    _initSpeech();
  }

  @override
  void dispose() {
    _speechToText.cancel();

    super.dispose();
  }

  bool _isPressed = false;
  @override
  Widget build(BuildContext context) {
    return /* IconButton(
      onPressed: () async {
        await _speechToText.isNotListening
            ? _startListening()
            : _stopListening();
      }, */
        /* icon: Icon(
        _speechToText.isNotListening ? Icons.mic_off : Icons.mic,
      ), */
        InkWell(
      onTapUp: (_) async {
        _isPressed = false;
        setState(() {});

        _stopListening();
      },
      onTapDown: (_) {
        _isPressed = true;
        _startListening();
        setState(() {});
      },
      onTapCancel: () {
        _isPressed = false;
        setState(() {});
      },
      customBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
      child: AnimatedContainer(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: Colors.green,
        ),
        duration: Duration(milliseconds: 200),
        width: _isPressed ? 75.0 : 50.0, // Change these values as needed
        height: _isPressed ? 75.0 : 50.0,
        child: Icon(
          _speechToText.isNotListening ? Icons.mic_off : Icons.mic,
          color: Colors.white,
          size: _isPressed ? 35.0 : 25.0,
        ),
      ),
    );
  }
}
