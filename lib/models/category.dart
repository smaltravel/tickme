class Category {
  String id;
  String name;

  Category({
    required this.id,
    required this.name,
  });

  //For JSON serialization / deserialization
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json['id'],
        name: json['name'],
      );
}
