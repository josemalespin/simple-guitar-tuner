import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:simple_guitar_tuner/app/controllers/tuner.controller.dart';

void main() {
  group('Tuner Controller Test', () {
    //Afinal la primera cuerda
    test('Testing first chord', () {
      final controller = TunerController();
      controller.selectChord(0, "E4");
      expect(controller.pitchToCompare.value, 329.63);
    });

    //Comparar el pitch actual con el capturado
    //para ver si esta en el rango
    test('Test compare pitch in range', () {
      final controller = TunerController();
      controller.currentPitch.value = 60;
      controller.pitchToCompare.value = 50;
      controller.compareWithPitch();
      expect(controller.isInRange.value, true);
    });

    //Comparar el pitch actual con el capturado
    //para ver si esta afinada
    test('Test compare pitch tuned', () {
      final controller = TunerController();
      controller.currentPitch.value = 51;
      controller.pitchToCompare.value = 50;
      controller.compareWithPitch();
      expect(controller.isTuned.value, true);
    });
  });
}
