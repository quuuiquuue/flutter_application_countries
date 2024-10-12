import 'package:flutter/material.dart';
import 'package:flutter_application_countries/infrastructure/models/country.dart';
import 'package:flutter_application_countries/presentation/services/country_service.dart';
import 'package:flutter_svg/svg.dart';

class CountryScreen extends StatefulWidget {
  final String countryName;

  const CountryScreen({super.key, required this.countryName});

  @override
  State<CountryScreen> createState() => _CountryScreenState();
}

class _CountryScreenState extends State<CountryScreen> {
  final TextEditingController _searchController = TextEditingController();
  Future<Country>? _countryFuture; // Variable para almacenar el Future

  // Método para obtener los datos del país usando el servicio CountryService
  Future<Country> _fetchCountry(String countryName) =>
      CountryService().fetchCountry(countryName);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Center(child: Text('Buscador de paises'))),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Campo de búsqueda
            TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                labelText: 'Introduce un pais',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                if (_searchController.text.isNotEmpty) {
                  // Aquí se usa setState para notificar al FutureBuilder que ha habido un cambio
                  setState(() {
                    _countryFuture =
                        _fetchCountry(_searchController.text.trim());
                  });
                }
              },
              child: const Text('Buscar'),
            ),
            const SizedBox(height: 30),

            // FutureBuilder que mostrará la información del país
            _countryFuture != null
                ? FutureBuilder<Country>(
                    future: _countryFuture,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Center(
                            child: Text('Error: ${snapshot.error}'));
                      }

                      if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(
                            child: CircularProgressIndicator());
                      }

                      if (!snapshot.hasData) {
                        return const Center(
                            child: Text('Pais no encontrado'));
                      }

                      // Si se obtuvo el país correctamente
                      final country = snapshot.data!;
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.network(
                            country.flags.svg, // Mostrar la bandera en formato SVG
                            width: 150,
                            height: 100,
                            placeholderBuilder: (context) =>
                                const CircularProgressIndicator(),
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
                      );
                    },
                  )
                : const Center(child: Text('Por favor introduzca un pais')),
          ],
        ),
      ),
    );
  }
}
