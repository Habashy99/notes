import 'package:hive/hive.dart';

part 'hive_user_model.g.dart';

@HiveType(typeId: 0)
class HiveUserModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String phone;

  @HiveField(3)
  final String password;

  @HiveField(4)
  final String token;

  HiveUserModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.password,
    required this.token,
  });

  factory HiveUserModel.fromJson(Map<String, dynamic> json) {
    return HiveUserModel(
      id: json['_id'],
      name: json['name'],
      phone: json['phone'],
      password: json['password'],
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "phone": phone,
    "password": password,
    "token": token,
  };
}
