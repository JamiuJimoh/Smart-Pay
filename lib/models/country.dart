import 'dart:convert';

class Country {
  final String iso2;
  final String name;
  Country({
    required this.iso2,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return {
      'iso2': iso2,
      'name': name,
    };
  }

  factory Country.fromMap(Map<String, dynamic> map) {
    return Country(
      iso2: map['ISO']['alpha2'] ?? '',
      name: map['name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Country.fromJson(String source) =>
      Country.fromMap(json.decode(source));

  @override
  String toString() => 'Country(iso2: $iso2, name: $name)';
}
