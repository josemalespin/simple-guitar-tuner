/*Este widget pinta el boton redondo para cada cuerda*/

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_guitar_tuner/shared/colors.dart';
import 'package:simple_guitar_tuner/shared/textstyles.dart';
import 'package:simple_guitar_tuner/app/controllers/tuner.controller.dart';

class GuitarButton extends StatelessWidget {
  final Color chordColor;
  final int chordIndex;
  final String chordText;

  const GuitarButton(
      {super.key,
      required this.chordColor,
      required this.chordIndex,
      required this.chordText});

  @override
  Widget build(BuildContext context) {
    var tunerController = Get.find<TunerController>();

    return Obx(() => OutlinedButton(
          style: ButtonStyle(
              fixedSize: const MaterialStatePropertyAll(
                Size(70, 70),
              ),
              side: MaterialStateProperty.all(
                BorderSide(
                    color: chordColor, width: 2 // Specify the border color here
                    ),
              ),
              backgroundColor: tunerController.selectedTune.value == chordText
                  ? MaterialStateProperty.all<Color>(Colors.white)
                  : MaterialStateProperty.all<Color>(
                      midGreyColor,
                    )),
          onPressed: () => tunerController.selectChord(chordIndex, chordText),
          child: Text(
            chordText,
            style: tunerController.selectedTune.value == chordText
                ? styleBlackMedium
                : styleWhiteMedium,
          ),
        ));
  }
}
