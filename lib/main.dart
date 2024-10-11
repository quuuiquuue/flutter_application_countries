import 'package:flutter/material.dart';
import 'package:flutter_application_countries/presentation/screens/country_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'presentation/services/country_service.dart';
import 'infrastructure/models/country.dart';

void main() => runApp(const CountriesApp());

class CountriesApp extends StatelessWidget {
  const CountriesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Country Search App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const CountryScreen(
          countryName:
              'spain'), // Puedes cambiar 'spain' por cualquier otro país
    );
  }
}
