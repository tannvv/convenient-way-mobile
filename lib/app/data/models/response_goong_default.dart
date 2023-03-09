class ResponseGoongDefault {
  String? name;
  String? placeId;

  ResponseGoongDefault({this.name, this.placeId});

  ResponseGoongDefault.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    placeId = json['placeId'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['placeId'] = placeId;
    return data;
  }
}
