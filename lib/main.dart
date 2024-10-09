import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'services/country_service.dart';
import 'models/country.dart';

void main() => runApp(CountriesApp());

class CountriesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Country Search App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: CountryScreen(
          countryName:
              'spain'), // Puedes cambiar 'spain' por cualquier otro país
    );
  }
}

class CountryScreen extends StatelessWidget {
  final String countryName;

  CountryScreen({required this.countryName});

  // Método para obtener los datos del país usando el servicio CountryService
  Future<Country> _fetchCountry() => CountryService().fetchCountry(countryName);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Center(child: Text('Country Info'))),
      body: FutureBuilder<Country>(
        future: _fetchCountry(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('Country not found'));
          }

          final country = snapshot.data!;
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.network(
                  country.flags.svg, // Mostrar la bandera en formato SVG
                  width: 150,
                  height: 100,
                  placeholderBuilder: (context) => CircularProgressIndicator(),
                ),
                const SizedBox(height: 20),
                Text(
                  country.name.common, // Mostrar el nombre común del país
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text(
                  country.name.official, // Mostrar el nombre oficial del país
                  style: const TextStyle(
                      fontSize: 18, fontStyle: FontStyle.italic),
                ),
                const SizedBox(height: 10),
                Text(
                  country.capital.isNotEmpty
                      ? 'Capital: ${country.capital.first}'
                      : 'Capital: N/A',
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
