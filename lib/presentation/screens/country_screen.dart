import 'package:flutter/material.dart';
import 'package:flutter_application_countries/infrastructure/models/country.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_countries/presentation/providers/country_provider.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CountryScreen extends StatelessWidget {
  const CountryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Buscador de países')),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            _CountrySearchField(),
            SizedBox(height: 30),
            _CountryView(),
          ],
        ),
      ),
    );
  }
}

/// Clase CountrySearchField que almacena la instacia de la clase TextEditingController
/// el cual nos va a proporcionar la forma de controlar lo que introducimos en el TextField
/// y lo enviara al CountryProvider para su lectura en la API Countries.
class _CountrySearchField extends StatelessWidget {
  const _CountrySearchField();

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = TextEditingController();

    return Column(
      children: [
        TextField(
          controller: searchController,
          decoration: const InputDecoration(
            labelText: 'Introduce un país',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            if (searchController.text.isNotEmpty) {
              context
                  .read<CountryProvider>()
                  .fetchCountry(searchController.text.trim());
            }
          },
          child: const Text('Buscar'),
        ),
      ],
    );
  }
}

/// Clase CountryView en la cual hacemos una instancia del Provider,
/// para poder traer la informacion del pais y mostrarla posteriormente 
/// en la clase CountryDetails con toda la informacion requerida.
class _CountryView extends StatelessWidget {
  const _CountryView();

  @override
  Widget build(BuildContext context) {
    final countryProvider = context.watch<CountryProvider>();
    
    if (countryProvider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (countryProvider.errorMessage != null) {
      return Center(child: Text(countryProvider.errorMessage!));
    }

    //Nos aseguramos que el contenido del pais no viene a nulo
    if (countryProvider.country == null) {
      return const Center(child: Text('Por favor, introduce un país'));
    }

  /**
   * Una vez que analizamos que no viene a nulo, aseguramos al compilador con el caracter '!'
   * que recibimos informacion del Provider.
   */
    final country = countryProvider.country!;  
    return _CountryDetails(country: country);
  }
}

/// Clase CountryDetails la cual muestra la informacion de cada pais,
/// en una distribucion en columna lo que la hace mas legible
class _CountryDetails extends StatelessWidget {
  final Country country;

  const _CountryDetails({required this.country});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.network(
          country.flags.svg,
          width: 150,
          height: 100,
          placeholderBuilder: (context) =>
              const CircularProgressIndicator(),
        ),
        const SizedBox(height: 20),
        Text(
          country.name.common,
          style: const TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Text(
          country.name.official,
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
  }
}
