import 'package:flutter/material.dart';
import 'package:flutter_application_countries/infrastructure/models/country.dart';
import 'package:flutter_application_countries/presentation/services/country_service.dart';
import 'package:flutter_svg/svg.dart';

class CountryScreen extends StatelessWidget {
  final String countryName;

  const CountryScreen({super.key, required this.countryName});

  // Método para obtener los datos del país usando el servicio CountryService
  Future<Country> _fetchCountry() => CountryService().fetchCountry(countryName);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Center(child: Text('Country Information'))),
      body: FutureBuilder<Country>(
        future: _fetchCountry(),
        builder: (context, snapshot) {
          // Comprobamos si hay un error en la carga
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          // Si no hay datos aún, podríamos mostrar un mensaje de "Cargando..." o "Esperando datos..."
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: Text('Esperando datos...'));
          }

          // Si no se encontró el país
          if (!snapshot.hasData) {
            return const Center(child: Text('Country not found'));
          }

          // Si se obtuvo el país correctamente
          final country = snapshot.data!;
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.network(
                  country.flags.svg, // Mostrar la bandera en formato SVG
                  width: 150,
                  height: 100,
                  placeholderBuilder: (context) => const SizedBox(
                    width: 150,
                    height: 100,
                    child: Center(
                        child:
                            CircularProgressIndicator()), // Este es el placeholder para la imagen
                  ),
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
