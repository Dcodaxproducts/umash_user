class TrackModel {
  double? lat;
  double? lng;
  String? eta;

  TrackModel({
    this.lat,
    this.lng,
    this.eta,
  });

  TrackModel.fromJson(Map<String, dynamic> json) {
    lat = double.parse(json["last_lat"].toString());
    lng = double.parse(json["last_long"].toString());
    eta = json["eta"];
  }
}
