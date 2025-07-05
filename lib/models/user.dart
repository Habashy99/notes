class UserModel {
  final String id;
  final String name;
  final String phone;
  final String password;
  final String? token;

  UserModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.password,
    this.token,
  });
  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json["_id"],
    name: json["name"],
    phone: json["phone"],
    password: json["password"],
    token: json["token"],
  );
}
