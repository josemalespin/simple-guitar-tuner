import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_guitar_tuner/app/screens/tuner.dart';
import 'package:flutter/services.dart';

void main() {
  //Modo oscuro para los botones inferiores
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.black,
    systemNavigationBarIconBrightness: Brightness.light,
  ));

  runApp(const GetMaterialApp(
    home: TunerScreen(),
    debugShowCheckedModeBanner: false,
  ));
}
