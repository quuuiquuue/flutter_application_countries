
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

  factory Country.fromJson(Map<String, dynamic> json) => Country(
        name: Name.fromJson(json["name"]),
        flags: Flags.fromJson(json["flags"]),
        capital:
            json['capital'] != null ? List<String>.from(json['capital']) : [],
      );

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

  factory Name.fromJson(Map<String, dynamic> json) => Name(
        common: json["common"],
        official: json["official"],
      );

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

  factory Flags.fromJson(Map<String, dynamic> json) => Flags(
        png: json["png"],
        svg: json["svg"],
      );

  Map<String, dynamic> toJson() => {
        "png": png,
        "svg": svg,
      };
}
