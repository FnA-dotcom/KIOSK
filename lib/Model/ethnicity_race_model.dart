class Ethnicity {
  final int id;
  final String name;
  final int status;


  Ethnicity({
    required this.id,
    required this.name,
    required this.status
  });

  factory Ethnicity.fromJson(Map<String, dynamic> json) {
    return Ethnicity(
      id: json['id'],
      name: json['name'],
      status: json['status']
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['status'] = this.status;
    return data;
  }

  @override
  String toString() {
    // @override
    // String toString() => gender;
    return name;
  }
}


class Race {
  final int id;
  final String conceptName;
  final int status;


  Race({
    required this.id,
    required this.conceptName,
    required this.status
  });

  factory Race.fromJson(Map<String, dynamic> json) {
    return Race(
        id: json['id'],
        conceptName: json['conceptName'],
        status: json['status']
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.conceptName;
    data['status'] = this.status;
    return data;
  }

  @override
  String toString() {
    // @override
    // String toString() => gender;
    return conceptName;
  }
}
