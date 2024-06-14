import 'dart:typed_data';

import 'package:flutter_audio_capture/flutter_audio_capture.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pitch_detector_dart/pitch_detector.dart';
import 'package:wakelock/wakelock.dart';

class TunerController extends GetxController {
  final _audioRecorder = FlutterAudioCapture();
  final pitchDetectorDart = PitchDetector(44100, 2000);

  final maxRange = 25;
  final maxToTune = 3;

  var hasAudioPermission = false.obs;
  var currentPitch = 0.0.obs;
  var pitchToCompare = 0.0.obs;
  var isInRange = false.obs;
  var isTuned = false.obs;
  var selectedTune = "".obs;

  RxDouble markerPositionX = 0.0.obs;

  //Empezando de la mas aguda a la mas grave
  var chordsFrecuency = [
    329.63, //E4
    246.94, //B3
    196.00, //G3
    146.83, //D3
    110.00, //A2
    82.41 //E2
  ];

  @override
  void onInit() {
    super.onInit();
    Wakelock.enable();
    recordPerm();
  }

  void selectChord(chordIndex, tuneChord) {
    pitchToCompare.value = chordsFrecuency[chordIndex];
    selectedTune.value = tuneChord;
  }

  void compareWithPitch() {
    //Si esta entre un rango establecido cerca del tono
    if (currentPitch.value >= (pitchToCompare.value - maxRange) &&
        currentPitch.value <= (pitchToCompare.value + maxRange)) {
      isInRange.value = true;

      //Calcular la posicion del marcador
      //150 es la mitad, si esta afinado es 150
      markerPositionX.value =
          (((currentPitch.value - pitchToCompare.value) * 3) + 100).toDouble();
    } else {
      isInRange.value = false;

      //Si esta fuera de rango, ver si es muy bajo o muy algo
      if (currentPitch.value > (pitchToCompare.value + maxRange)) {
        //Muy alto
        markerPositionX.value = 180.0 - 24;
      } else if (currentPitch.value < (pitchToCompare.value - maxRange)) {
        //Muy bajo
        markerPositionX.value = 24;
      }
    }

    //Si esta mucho mas cerca del rango, esta afinada
    if (currentPitch.value > (pitchToCompare.value - maxToTune) &&
        currentPitch.value < (pitchToCompare.value + maxToTune)) {
      isTuned.value = true;
    } else {
      isTuned.value = false;
    }
  }

  recordPerm() async {
    if (await Permission.microphone.request().isGranted) {
      hasAudioPermission.value = true;
      startCapture();
    } else {
      //No hay permiso
    }
  }

  Future<void> startCapture() async {
    await _audioRecorder.start(listener, error,
        sampleRate: 44100, bufferSize: 3000);
  }

  void listener(dynamic obj) {
    var buffer = Float64List.fromList(obj.cast<double>());
    final List<double> audioSample = buffer.toList();

    final result = pitchDetectorDart.getPitch(audioSample);

    if (result.pitched) {
      currentPitch.value = result.pitch;
      compareWithPitch();
    }
  }

  void error(Object e) {
    //Nada que hacer de momento
    //Tal vez reportar en algun log de errores
  }
}
