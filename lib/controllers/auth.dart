import 'package:dio/dio.dart';
import 'package:notes/controllers/hive.dart';
import 'package:notes/models/hive_user_model.dart';

abstract interface class IAuth {
  signup(String name, String phone, String password);
  login(String phone, String password);
}

class AuthController implements IAuth {
  @override
  signup(String name, String phone, String password) async {
    final dio = Dio();
    final response = await dio.post(
      'http://192.168.1.12:8050/users/signup',
      data: {"name": name, "phone": phone, "password": password},
    );
    final data = response.data["user"];
    if (data == null) throw Exception("User not found in response");
    final user = HiveUserModel.fromJson(data);
    final userBox = HiveService.getUserBox();
    await userBox.put('user', user);
    return user;
  }

  @override
  login(String phone, String password) async {
    final dio = Dio();
    final response = await dio.post(
      'http://192.168.1.12:8050/users/login',
      data: {"phone": phone, "password": password},
    );
    final data = response.data["user"];
    if (data == null) throw Exception("User not found in response");
    final user = HiveUserModel.fromJson(data);
    return user;
  }
}
