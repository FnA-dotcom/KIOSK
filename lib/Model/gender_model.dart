class Gender {
  int id;
  String gender;

  Gender({required this.id, required this.gender});

  factory Gender.fromJson(Map<String, dynamic> json) {
    return Gender(
      id: json['id'],
      gender: json['gender'],
    );
  }

  // Map<String, dynamic> toJson() => {
  //   'gender': gender,
  //   'id': id,
  // };
  //
  // @override
  // String toString() => gender;

}