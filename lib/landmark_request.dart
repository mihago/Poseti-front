class LandmarkRequest {
  final String name;
  final String description;
  final double latitude;
  final double longitude;
  final String image;

  const LandmarkRequest({required this.name, required this.description,required this.latitude,required this.longitude, required this.image});
  factory LandmarkRequest.fromJson(Map<String, dynamic> json) {
    return LandmarkRequest(
      name: json['name'],
      description: json['description'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      image: json['image'],
    );
  }
  String toString() {
    return '{ $name, $description }';
  }
}

