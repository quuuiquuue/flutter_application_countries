import 'package:flutter/material.dart';

//Paleta de colores de nuestra aplicacion
const List<Color> colorThemes = [
  Colors.blue,
  Colors.teal,
  Colors.green,
  Colors.yellow,
  Colors.orange,
  Colors.pink,
];

class AppTheme {

  final int selectedColor;

  AppTheme({this.selectedColor = 0}) : assert(selectedColor >= 0 && selectedColor < colorThemes.length, 'color index must be between 0 and ${colorThemes.length - 1}');

  ThemeData theme() {
    return ThemeData(
      colorSchemeSeed: colorThemes[0],
    );
  }
}