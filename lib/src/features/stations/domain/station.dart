class Station {
  final String id;
  final String name;
  final String imageUrl;
  final String streamUrl;

  Station({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.streamUrl,
  });

  factory Station.fromJson(Map<String, dynamic> json) => Station(
        id: json['stationuuid'],
        name: json['name'],
        imageUrl: json['favicon'],
        streamUrl: json['url_resolved'],
      );
}
