import 'package:flutter/material.dart';
import 'package:flutter_application_countries/config/theme/app_theme.dart';
import 'package:flutter_application_countries/presentation/providers/country_provider.dart';
import 'package:flutter_application_countries/presentation/screens/country_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
 const MyApp(),
    )
  ;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CountryProvider()),
      ],
      child: MaterialApp(
        title: 'Buscador de paises',
        debugShowCheckedModeBanner: false,
        theme: AppTheme(selectedColor: 1).theme(),
        home: const CountryScreen(),
      ),
    );
  }
}
