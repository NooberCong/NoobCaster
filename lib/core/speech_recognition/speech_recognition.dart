import 'dart:async';

import 'package:noobcaster/core/settings/app_settings.dart';
import 'package:noobcaster/injection_container.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

abstract class VoiceRecognition {
  Stream get stream;
  void startListening();
}

class VoiceRecognitionImpl implements VoiceRecognition {
  StreamController _controller;
  @override
  Stream get stream {
    _controller = StreamController();
    return _controller.stream;
  }

  bool _available;
  stt.SpeechToText _speech;
  Future<void> init() async {
    _speech = stt.SpeechToText();
    _available =
        await _speech.initialize(onError: _onError, onStatus: _onStatus);
  }

  @override
  Future<void> startListening() async {
    String result;
    final String settingsLocaleId = sl<AppSettings>().getLocale();
    if (_available) {
      _speech.listen(
          listenFor: const Duration(minutes: 1),
          onResult: (results) {
            final alternates = results.alternates;
            result = alternates
                .reduce((x, y) => x.confidence > y.confidence ? x : y)
                .recognizedWords;
            _controller.add(result);
          },
          localeId: settingsLocaleId);
    } else {
      throw UnimplementedError();
    }
  }

  void _onError(SpeechRecognitionError _) {
    _timeOutEndSpeech();
  }

  void _onStatus(String status) {
    if (status == "notListening") {
      _timeOutEndSpeech();
    }
  }

  void _timeOutEndSpeech() {
    Future.delayed(const Duration(seconds: 1), () {
      _speech.stop();
      _controller.close();
    });
  }
}
