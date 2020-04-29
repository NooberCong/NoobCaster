import 'dart:async';

import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

abstract class VoiceRecognition {
  Stream get stream;
  void startListening();
}

class VoiceRecognitionImpl implements VoiceRecognition {
  StreamController _controller;
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
  void startListening() {
    String result;
    if (_available) {
      _speech.listen(
          listenFor: Duration(days: 1),
          onResult: (results) {
            final alternates = results.alternates;
            result = alternates
                .reduce((x, y) => x.confidence > y.confidence ? x : y)
                .recognizedWords;
            _controller.add(result);
          },
          localeId: "en_US");
    } else {
      throw UnimplementedError();
    }
  }

  void _onError(SpeechRecognitionError errorNotification) {
    print(errorNotification.errorMsg);
  }

  void _onStatus(String status) {
    if (status == "notListening") {
      Future.delayed(Duration(seconds: 1), () {
        _speech.stop();
        _controller.close();
      });
    }
  }
}
