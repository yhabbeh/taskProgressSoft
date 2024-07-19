class UserModel {
  final String fullName;
  final String mobileNumber;
  final String age;
  final String gender;

  UserModel(
      {required this.fullName,
      required this.mobileNumber,
      required this.age,
      required this.gender});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      fullName: json['fullName'],
      mobileNumber: json['mobileNumber'],
      age: json['age'],
      gender: json['gender'],
    );
  }
}
