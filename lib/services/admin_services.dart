import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:pet_shop/constants/urls.dart';
import 'package:shared_preferences/shared_preferences.dart';

final adminAllUserProvider = FutureProvider(
  (ref) => AdminServices.getAllUser(),
);

final adminAllSellerProvider = FutureProvider(
  (ref) => AdminServices.getAllSeller(),
);

class AdminServices {
  static Future<String> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.get("adminToken");
    return token.toString();
  }

  static Future<dynamic> adminLogin(
      {required String mobile, required String password}) async {
    try {
      // final response =await http.post(
      //   Uri.parse(ConstantUrls.adminLogin),
      //   body: jsonEncode(data),
      // );

      // var uri = Uri.parse(ConstantUrls.adminLogin);
      // var request = http.MultipartRequest('POST', uri);
      // request.fields.addAll(
      //     {"user_type": "super_admin", "mobile": mobile, "password": password});
      // // print(emailApiUrl);
      // // var headers = {
      // //   'Accept': 'application/json'
      // // };
      // // request.headers.addAll(headers);
      //
      // http.StreamedResponse response = await request.send().timeout(
      //       const Duration(seconds: 30),
      //     );
      // // print(await response.stream.bytesToString());
      // return response;

      FormData data = FormData.fromMap({
        "mobile": mobile,
        "password": password,
        "user_type": "super_admin",
      });

      final response = await Dio()
          .post(ConstantUrls.adminLogin,
              data: data,
              options: Options(
                  // followRedirects: false,
                  followRedirects: false,
                  validateStatus: (status) {
                    return status! < 500;
                  },
                  headers: {
                    "Accept": "application/json",
                    'Authorization': 'Bearer ${await getToken()}'
                  }))
          .timeout(const Duration(seconds: 20));

      return response;
    } on SocketException {
      throw "no Internet";
    }
  }

  static Future<dynamic> getAllUser() async {
    try {
      print({'Authorization': 'Bearer ${getToken().toString()}'});
      final response = await http.get(
        Uri.parse(ConstantUrls.adminAllUser),
        headers: {'Authorization': 'Bearer ${await getToken()}'},
      );

      return jsonDecode(response.body);
    } on SocketException {
      throw "no Internet";
    }
  }

  static Future<dynamic> getAllSeller() async {
    try {
      final response = await http.get(
        Uri.parse(ConstantUrls.adminAllSeller),
        headers: {'Authorization': 'Bearer ${await getToken()}'}
      );

      print({'Authorization': 'Bearer ${getToken()}'});

      return jsonDecode(response.body);
    } on SocketException {
      throw "no Internet";
    }
  }
}
