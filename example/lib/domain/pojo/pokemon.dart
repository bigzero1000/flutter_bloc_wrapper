import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(nullable: true)
class Pokemon {
  @JsonKey(name: 'name')
  String name;
  @JsonKey(name: 'url')
  String url;

  Pokemon({this.name, this.url});

  factory Pokemon.fromJson(Map<String, dynamic> json) => _pokemonFromJson(json);
}

Pokemon _pokemonFromJson(Map<String, dynamic> json) {
  return Pokemon()
    ..name = (json['name'] as String) ?? ''
    ..url = (json['url'] as String) ?? '';
}
