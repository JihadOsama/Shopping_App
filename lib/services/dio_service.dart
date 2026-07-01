import 'package:dio/dio.dart';
import 'package:shop_app/consts.dart';
import 'package:shop_app/models/auth_model.dart';
import 'package:shop_app/models/product_model.dart';

class DioService {
  final _dio = Dio();

  Future<AuthResponse?> loginUser(AuthRequest user) async {
    try {
      final result = await _dio.post(
        Consts.loginEndPoint,
        data: {"email": user.email, "password": user.password},
      );
      if (result.statusCode == 200) {
        return AuthResponse.fromJson(result.data);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<AuthResponse?> registerUser(AuthRequest user) async {
    try {
      final result = await _dio.post(
        Consts.registerEndPoint,
        data: {
          "email": user.email,
          "password": user.password,
          "phoneNumber": user.phone,
          "name": user.name,
        },
      );
      if (result.statusCode == 200) {
        return AuthResponse.fromJson(result.data);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<List<ProductModel>?> getProducts() async {
    try {
      final result = await _dio.get(Consts.getProductsEndPoint);
      if (result.statusCode == 200) {
        final res = ProductResponse.fromJson(result.data);
        return res.response;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}