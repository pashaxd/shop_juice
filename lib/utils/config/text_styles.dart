import 'package:flutter/material.dart';
import 'package:shop_juice/utils/config/palette.dart';

//Стили текста в приложении
class TextStyles {
  static const TextStyle smallTitle = TextStyle(
    fontSize: 15,
    color: Palette.black,
    fontWeight: FontWeight.bold,
  );
  static const TextStyle title = TextStyle(
    fontSize: 25,
    color: Palette.black,
    fontWeight: FontWeight.bold,
  );
  static const TextStyle description = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: Palette.grey,
  );
  static const TextStyle button = TextStyle(
    fontSize: 20,
    color: Palette.white,
    fontWeight: FontWeight.w500,
  );
}