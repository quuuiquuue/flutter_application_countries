import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'services/country_service.dart';
import 'models/country.dart';

void main() {
  runApp(CountriesApp());
}

class CountriesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Country Search App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CountryScreen(countryName: 'spain'), // Pasamos "Spain" como parámetro
    );
  }
}

class CountryScreen extends StatefulWidget {
  final String countryName;

  CountryScreen({required this.countryName});

  @override
  _CountryScreenState createState() => _CountryScreenState();
}

class _CountryScreenState extends State<CountryScreen> {
  late Future<Country> _country;

  @override
  void initState() {
    super.initState();
    // Busca el país basado en el nombre pasado
    _country = CountryService().fetchCountry(widget.countryName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Country Info'),
      ),
      body: FutureBuilder<Country>(
        future: _country,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('Country not found'));
          }

          final country = snapshot.data!;

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.network(
                  country.flagUrl,
                  width: 150,
                  height: 100,
                  placeholderBuilder: (context) => CircularProgressIndicator(),
                ),
                SizedBox(height: 20),
                Text(
                  country.name,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Text(
                  country.official,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
