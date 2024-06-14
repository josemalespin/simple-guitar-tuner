import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_guitar_tuner/shared/colors.dart';
import 'package:simple_guitar_tuner/shared/textstyles.dart';
import 'package:simple_guitar_tuner/app/components/guitarbuton.dart';
import 'package:simple_guitar_tuner/app/components/tunermarker.dart';
import 'package:simple_guitar_tuner/app/components/verticallinepainter.dart';
import 'package:simple_guitar_tuner/app/controllers/tuner.controller.dart';

class TunerScreen extends StatelessWidget {
  const TunerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tunerController = Get.put(TunerController());

    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Simple afinador de guitarra',
            style: styleWhiteMedium,
            textAlign: TextAlign.center,
          ),
          backgroundColor: midGreyColor // Set the background color
          ),
      body: Column(
        children: [
          Obx(
            () => Expanded(
              flex: 1,
              child: tunerController.hasAudioPermission.value
                  ? Container(
                      width: double.infinity,
                      color: blackGreyColor,
                      child: Stack(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            height: double.infinity,
                            child: CustomPaint(
                              painter: VerticalLinePainter(),
                            ),
                          ),
                          Center(
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Text(
                                    tunerController.selectedTune.value == ""
                                        ? "Seleccione cuerda..."
                                        : tunerController.selectedTune.value,
                                    style: styleWhiteBig,
                                  ),
                                ),
                                Text(
                                    tunerController.pitchToCompare.value
                                        .toString(),
                                    style: styleWhiteSmall),
                                tunerController.selectedTune.value == ""
                                    ? Container()
                                    : const TunerMarker(),
                                tunerController.isTuned.value
                                    ? const Text(
                                        "Afinada",
                                        style: styleGreenSmall,
                                      )
                                    : Container()
                              ],
                            ),
                          ),
                        ],
                      ))
                  : Container(
                      width: double.infinity,
                      color: blackGreyColor,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/mute.png',
                              width: double.infinity,
                              height: 100,
                            ),
                            const Text("No se ha brindado permiso de audio",
                                style: styleWhiteMedium)
                          ],
                        ),
                      ),
                    ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              height: 50,
              color: midGreyColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GuitarButton(
                            chordColor: Colors.yellow,
                            chordIndex: 3,
                            chordText: "D3"),
                        GuitarButton(
                            chordColor: Colors.yellow,
                            chordIndex: 4,
                            chordText: "A2"),
                        GuitarButton(
                            chordColor: Colors.yellow,
                            chordIndex: 5,
                            chordText: "E2")
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Image.asset(
                          'assets/images/guitar.png',
                          width: double.infinity,
                          height: 350,
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GuitarButton(
                            chordColor: Colors.white,
                            chordIndex: 2,
                            chordText: "G3"),
                        GuitarButton(
                            chordColor: Colors.white,
                            chordIndex: 1,
                            chordText: "B3"),
                        GuitarButton(
                            chordColor: Colors.white,
                            chordIndex: 0,
                            chordText: "E4"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
