import 'package:flutter/material.dart';
import 'package:flutter_application_countries/infrastructure/models/country.dart';
import 'package:dio/dio.dart';


/// Clase CountryProvider, su funcionalidad es crear una solicitud HTTP en base a la libreria Dio,
/// en la cual alojaremos en un response la informacion del pais para posteriormente guaradalo en un List  
/// para su procesamiento de extraccion de datos
class CountryProvider extends ChangeNotifier {
  Country? country;
  bool isLoading = false;
  String? errorMessage;

  final Dio _dio = Dio();

  Future<void> fetchCountry(String countryName) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();  

    final url = 'https://restcountries.com/v3.1/name/$countryName';

    try {
      final response = await _dio.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;

        if (data.isNotEmpty) {
          country = Country.fromJson(data[0]);  // Asignamos el primer país encontrado.
        } else {
          errorMessage = 'País no encontrado';
        }
      } else {
        errorMessage = 'Error al cargar los datos del país';
      }
    } catch (error) {
      errorMessage = 'Error: Bad Request 404';
    }

    isLoading = false;
    notifyListeners();  // Notificamos que la carga ha terminado.
  }
}
