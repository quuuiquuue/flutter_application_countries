class Country {
  final String name;
  final String official;
  final String flagUrl;

  Country({required this.name, required this.official, required this.flagUrl});

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      name: json['name']['common'],
      flagUrl: json['flags']['svg'],
      official: json['name']['official'], 
    );
  }
}
