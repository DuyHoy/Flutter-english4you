class Brew {
  String id;
  final String name;
  final String sugars;
  final int strength;
  Brew({this.id = '', this.name = '', this.sugars = '', this.strength = 0});

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'strength': strength,
        'sugars': sugars,
      };

  static Brew fromJson(Map<String, dynamic> json) => Brew(
        id: json['id'] == null ? '' : json['id'],
        name: json['name'],
        strength: json['strength'],
        sugars: json['sugars'],
      );
}
