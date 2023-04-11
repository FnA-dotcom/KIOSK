class PriInsurance{
  final int id;
  final String payerName;
  final String payerID;


  PriInsurance({
    required this.id,
    required this.payerName,
    required this.payerID,
  });

  factory PriInsurance.fromJson(Map<String, dynamic> json) {
    return PriInsurance(
      id: json['id'],
      payerName: json['payerName'],
      payerID: json['payerID'],
    );
  }



}