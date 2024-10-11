import 'package:dio/dio.dart';
import '../../infrastructure/models/country.dart';

class CountryService {
  final Dio _dio = Dio();

  Future<Country> fetchCountry(String countryName) async {
    try {
      final response =
          await _dio.get('https://restcountries.com/v3.1/name/$countryName');
      if (response.statusCode == 200) {
        List data = response.data;
        return Country.fromJson(data[0]);
      } else {
        throw Exception('Error al cargar los países');
      }
    } catch (e) {
      throw Exception('Error de conexión: $e');
    }
  }
}
