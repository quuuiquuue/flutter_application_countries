import 'dart:convert';

// Función para parsear la lista de países desde el JSON
List<Country> countryFromJson(String str) =>
    List<Country>.from(json.decode(str).map((x) => Country.fromJson(x)));

// Función para convertir la lista de países a JSON
String countryToJson(List<Country> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

// Clase que representa el país
class Country {
  final Name name;
  final Flags flags;
  final List<String> capital;

  Country({
    required this.name,
    required this.flags,
    required this.capital,
  });

  // Método para crear un objeto Country a partir de un JSON
  factory Country.fromJson(Map<String, dynamic> json) => Country(
        name: Name.fromJson(json["name"]),
        flags: Flags.fromJson(json["flags"]),
        capital:
            json['capital'] != null ? List<String>.from(json['capital']) : [],
      );

  // Método para convertir un objeto Country a JSON
  Map<String, dynamic> toJson() => {
        "name": name.toJson(),
        "flags": flags.toJson(),
        "capital": capital,
      };
}

// Clase que representa el nombre de un país
class Name {
  final String common;
  final String official;

  Name({
    required this.common,
    required this.official,
  });

  // Método para crear un objeto Name a partir de un JSON
  factory Name.fromJson(Map<String, dynamic> json) => Name(
        common: json["common"],
        official: json["official"],
      );

  // Método para convertir un objeto Name a JSON
  Map<String, dynamic> toJson() => {
        "common": common,
        "official": official,
      };
}

// Clase que representa las banderas de un país
class Flags {
  final String png;
  final String svg;

  Flags({
    required this.png,
    required this.svg,
  });

  // Método para crear un objeto Flags a partir de un JSON
  factory Flags.fromJson(Map<String, dynamic> json) => Flags(
        png: json["png"],
        svg: json["svg"],
      );

  // Método para convertir un objeto Flags a JSON
  Map<String, dynamic> toJson() => {
        "png": png,
        "svg": svg,
      };
}
