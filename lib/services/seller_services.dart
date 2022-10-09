import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet_shop/constants/urls.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sellerProductProvider = FutureProvider(
  (ref) => SellerServices.sellerProduct(),
);

class SellerServices {
  static Future<dynamic> userRegistration({
    required String name,
    required String mobile,
    required String password,
    required String shopName,
  }) async {
    FormData data = FormData.fromMap({
      "mobile": mobile,
      "password": password,
      "name": name,
      "shop_name": shopName,
      "user_type": "seller",
    });

    print(ConstantUrls.userRegisterUrl);

    try {
      final response = await Dio()
          .post(ConstantUrls.userRegisterUrl,
              data: data,
              options: Options(
                  followRedirects: false,
                  validateStatus: (status) {
                    return status! < 500;
                  },
                  headers: {"Accept": "application/json"}

                  // contentType: ("application/json")
                  ))
          .timeout(const Duration(seconds: 20));
      print(response.data);

      print(response.statusCode);
      return response;
    } on SocketException {
      throw "no Internet";
    }
  }

  static Future<dynamic> userLogin(
      {required String mobile, required String password}) async {
    FormData data = FormData.fromMap({
      "mobile": mobile,
      "password": password,
      "user_type": "seller",
    });
    print(data.fields);

    print(ConstantUrls.adminLogin);

    try {
      final response = await Dio()
          .post(ConstantUrls.adminLogin,
              data: data,
              options: Options(
                  // followRedirects: false,
                  followRedirects: false,
                  validateStatus: (status) {
                    return status! < 500;
                  },
                  headers: {"Accept": "application/json"}))
          .timeout(const Duration(seconds: 20));
      print(response.data);
      return response;
    } on SocketException {
      throw "no Internet";
    }
  }

  static Future<dynamic> sellerProduct() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.get("sellerToken").toString();
    try {
      print(ConstantUrls.sellerProduct);

      print({"Authorization": "Bearer $token"});

      final response = await Dio()
          .get(
            ConstantUrls.sellerProduct,
            options: Options(
              followRedirects: false,
              validateStatus: (status) {
                return status! < 500;
              },
              headers: {"Authorization": "Bearer $token"},
            ),
          )
          .timeout(
            const Duration(
              seconds: 30,
            ),
          );
      print(response.statusCode);
      print(response.data);

      return response.data;
    } on SocketException {
      print("No internet");
      throw "No internet";
    }
  }

  static Future<dynamic> sellerAddProduct({required data}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.get("sellerToken").toString();

    try {
      final response = await Dio()
          .post(ConstantUrls.sellerProductAdd,
              data: data,
              options: Options(
                  // followRedirects: false,
                  followRedirects: false,
                  validateStatus: (status) {
                    return status! < 500;
                  },
                  headers: {
                    "Accept": "application/json",
                    "Authorization": "Bearer $token"
                  }))
          .timeout(const Duration(seconds: 20));
      print(response.data);
      return response;
    } on SocketException {
      throw "no Internet";
    }
  }
}
