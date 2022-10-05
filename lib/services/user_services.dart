import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:pet_shop/constants/urls.dart';

final userAllProductProvider = FutureProvider(
  (ref) => UserServices.getAllProduct(),
);

final allSellerProvider = FutureProvider(
  (ref) => UserServices.getSeller(),
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
              ))
          .timeout(const Duration(seconds: 20));
      print(response.data);
      return response;
    } on SocketException {
      throw "no Internet";
    }
  }


  static Future<dynamic> userLogin(
      {
        required String mobile,
        required String password}) async {
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
            validateStatus: (status) {
              return status! < 500;
            },
          ))
          .timeout(const Duration(seconds: 20));
      print(response.data);
      return response;
    } on SocketException {
      throw "no Internet";
    }
  }
}
