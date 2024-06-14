/*Este widget muestra el marcador que indica el nivel de afinacion*/

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_guitar_tuner/shared/textstyles.dart';
import 'package:simple_guitar_tuner/app/controllers/tuner.controller.dart';

class TunerMarker extends StatelessWidget {
  const TunerMarker({super.key});

  @override
  Widget build(BuildContext context) {
    var tunerController = Get.find<TunerController>();

    return SizedBox(
      width: 200,
      height: 130,
      child: Stack(
        children: [
          Obx(
            () => AnimatedPositioned(
                curve: Curves.ease,
                duration: const Duration(milliseconds: 500),
                left: tunerController.markerPositionX.value - (48 / 2),
                top: 50.0,
                child: Column(
                  children: [
                    Icon(
                      Icons.location_on,
                      color: tunerController.isTuned.value
                          ? Colors.green
                          : Colors.grey,
                      size: 48.0,
                      semanticLabel: 'Afinador de guitarra',
                    ),
                    Text(
                      tunerController.currentPitch.value.toStringAsFixed(2),
                      style: styleWhiteSmall,
                    )
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
