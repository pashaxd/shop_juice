import 'package:flutter/material.dart';
import 'dart:ui';

//Константы в приложении

class Constants {
  static const String apiLink = 'https://dummyjson.com';
  static double get phoneHeight => PlatformDispatcher.instance.views.first.physicalSize.height / PlatformDispatcher.instance.views.first.devicePixelRatio;
  static double get phoneWidth => PlatformDispatcher.instance.views.first.physicalSize.width / PlatformDispatcher.instance.views.first.devicePixelRatio;
}