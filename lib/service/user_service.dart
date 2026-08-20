import 'package:nexoft/helper/dio_helper.dart';
import 'package:nexoft/model/user_model.dart';

class UserService {
  final api = DioHelper(
    baseUrl: 'https://dummyjson.com/',
    headers: {
      'Content-Type': 'application/json',
    },
  );

  Future<List<UserModel>> getData() async {
    final response = await api.get("users");

    final List usersJson = response.data['users'];

    return usersJson.map((item) => UserModel.fromJson(item)).toList();
  }
}