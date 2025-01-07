class PaginationScreenDl {
  PaginationScreenDl({
    this.id,
    this.name,
    this.image,
    this.location,
  });

  final int? id;
  final String? name;
  final String? image;
  final String? location;

  PaginationScreenDl fromJson(Map<String, dynamic> json) {
    return PaginationScreenDl(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      location: json['location'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'location': location,
    };
  }
}
