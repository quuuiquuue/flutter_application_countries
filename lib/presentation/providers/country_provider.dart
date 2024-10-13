import 'package:flutter/material.dart';
import 'package:flutter_application_countries/infrastructure/models/country.dart';
import 'package:dio/dio.dart';

class CountryProvider extends ChangeNotifier {
  Country? country;
  bool isLoading = false;
  String? errorMessage;

  final Dio _dio = Dio();

  Future<void> fetchCountry(String countryName) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();  // Notifica a los widgets que se ha iniciado una carga.

    final url = 'https://restcountries.com/v3.1/name/$countryName';

    try {
      final response = await _dio.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;

        if (data.isNotEmpty) {
          country = Country.fromJson(data[0]);  // Asigna el primer país encontrado.
        } else {
          errorMessage = 'País no encontrado';
        }
      } else {
        errorMessage = 'Error al cargar los datos del país';
      }
    } catch (error) {
      errorMessage = 'Error: $error';
    }

    isLoading = false;
    notifyListeners();  // Notifica que la carga ha terminado.
  }
}
