import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:pet_shop/constants/urls.dart';
import 'package:shared_preferences/shared_preferences.dart';

final userAllProductProvider = FutureProvider(
  (ref) => UserServices.getAllProduct(),
);

final allSellerProvider = FutureProvider(
  (ref) => UserServices.getSeller(),
);

final userAllOrderProvider = FutureProvider(
      (ref) => UserServices.getOrder(),
);


final allSellerWiseProductProvider = FutureProvider.family<dynamic, String>(
  (ref, id) => UserServices.shopWiseProduct(shopSlug: id),
);

class UserServices {
  static Future<dynamic> getAllProduct() async {
    try {
      final response = await http.get(
        Uri.parse(ConstantUrls.userHomeUrl),
      );
      return jsonDecode(response.body);
    } on SocketException {
      throw "no Internet";
    }
  }

  static Future<dynamic> getSeller() async {
    try {
      final response = await http.get(
        Uri.parse(ConstantUrls.allSellerUrl),
      );
      return jsonDecode(response.body);
    } on SocketException {
      throw "no Internet";
    }
  }

  static Future<dynamic> shopWiseProduct({required String shopSlug}) async {
    try {
      final response = await http.get(
        Uri.parse("${ConstantUrls.shopWiseProductUrl}$shopSlug/products"),
      );
      return jsonDecode(response.body);
    } on SocketException {
      throw "no Internet";
    }
  }

  static Future<dynamic> userRegistration(
      {required String name,
      required String mobile,
      required String password}) async {
    FormData data = FormData.fromMap({
      "mobile": mobile,
      "password": password,
      "name": name,
      "user_type": "user",
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
      "user_type": "user",
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

  Future<dynamic> placeOrder({required data}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.get("userToken").toString();
    try {
      print(ConstantUrls.placeOrder);

      print({"Authorization": "Bearer $token"});

      final response = await Dio()
          .post(
            ConstantUrls.placeOrder,
            data: (data),
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

      return response;
    } on SocketException {
      print("No internet");
      throw "No internet";
    }
  }

  static Future<dynamic> getOrder() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.get("userToken").toString();
    try {
      print(ConstantUrls.getOrder);

      print({"Authorization": "Bearer $token"});

      final response = await Dio()
          .get(
            ConstantUrls.getOrder,
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
}
