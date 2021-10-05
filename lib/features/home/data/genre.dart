class Genre {
  int? id;
  String? name;

  Genre({required this.id, required this.name});

  Genre.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  @override
  String toString() => name!;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}
