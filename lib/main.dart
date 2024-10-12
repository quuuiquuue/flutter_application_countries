import 'package:flutter/material.dart';
import 'package:flutter_application_countries/config/theme/app_theme.dart';
import 'package:flutter_application_countries/presentation/screens/country_screen.dart';


void main() => runApp(const CountriesApp());

class CountriesApp extends StatelessWidget {
  const CountriesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Buscador de paises',
      debugShowCheckedModeBanner: false,
      theme: AppTheme(selectedColor: 1).theme(),
      home: const CountryScreen(
          countryName:
              'spain'), // Puedes cambiar 'spain' por cualquier otro país
    );
  }
}
