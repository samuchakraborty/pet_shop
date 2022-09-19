import 'dart:convert';
import 'dart:io';

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

  static Future<http.StreamedResponse> adminLogin(
      {required String mobile, required String password}) async {
    try {
      // final response =await http.post(
      //   Uri.parse(ConstantUrls.adminLogin),
      //   body: jsonEncode(data),
      // );

      var uri = Uri.parse(ConstantUrls.adminLogin);
      var request = http.MultipartRequest('POST', uri);
      request.fields.addAll(
          {"user_type": "super_admin", "mobile": mobile, "password": password});
      // print(emailApiUrl);
      // var headers = {
      //   'Accept': 'application/json'
      // };
      // request.headers.addAll(headers);

      http.StreamedResponse response = await request.send().timeout(
            const Duration(seconds: 30),
          );
      // print(await response.stream.bytesToString());
      return response;
    } on SocketException {
      throw "no Internet";
    }
  }

  static Future<dynamic> getAllUser() async {
    try {
      final response = await http.get(
        Uri.parse(ConstantUrls.adminAllUser),
        headers: {
          'Authorization':
              'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiODcyODU1YjgyZmQ5Njg3ZDgzOTE4ZTYyZWJiZTBiOTJhMzdmYjUzZDk1ZDlkNThiZWZlYmRhMDczMGVjNDI4ZjJmZjFjYWJkY2U2NDRkNTgiLCJpYXQiOjE2NjM1ODI1ODEuODg4Mjc2MTAwMTU4NjkxNDA2MjUsIm5iZiI6MTY2MzU4MjU4MS44ODgyNzg5NjExODE2NDA2MjUsImV4cCI6MTY5NTExODU4MS44ODUzNjE5MDk4NjYzMzMwMDc4MTI1LCJzdWIiOiIxIiwic2NvcGVzIjpbXX0.TAK1DFxKamxw2LdVxBnF1iZ3GXiROQdi_qS8y5X54X69kLuQfXK-ozXt1aTBFm5LNWfsZGfIDMMaLcx_egVUJgkM64qr0IoNn0k435a7iWjNrb9wk_ne5H-FgOaj_4Gv-K1CNPN6NBstlMa-cao4T_iGdaqW9mMtlFFr-MzPt4snP9BHGz0o4znEjl67-4a1S-MYx1svI9TQf6HslbMCxjrcqMWZ-KFWNVsp-4JM7Q17mjAZa1vV6cZAfEx9noxLe1XTsgEKJQjcSqDuuDg0ZEEs7Fof-z2_lcfdXpi9EJ_UnEeXdGRAcLkRFHH32MpdXi2L-dT3VKN7LxFgpv1215LeoZdLVzNG2FRR6GnVPHhgHrFZegjwqZW3TKJPMe-AJwif5D0N2i8wH0kREHHyJ-iYpRhinEAkpauuIRsoN198aPXDpTCfGP6LTsjVyAUbfiT_IVXEevtsByLqpKwu8PtFQtlGoHv0qHBPCrn8nVvMUNnUsWzhXpK4_r0aNTLAYsmO7dUgaZSRgUWw_hEMhjwMlg9mWGpiYMBqdXGRnMHgos5YqrjZ4hfeR89RzdaQWHr7bgV9TWSrTSaTZm9MFP_bthwp-zA2nt1XMtNoErHIfvvk3mkrH6acRMc2I9sKksrluBjeahq6q2eN1-ebb9GDFJG-VVoKMR2qgLEmbzA'
        },
      );

      print({'Authorization': 'Bearer ${getToken()}'});

      return jsonDecode(response.body);
    } on SocketException {
      throw "no Internet";
    }
  }

  static Future<dynamic> getAllSeller() async {
    try {
      final response = await http.get(
        Uri.parse(ConstantUrls.adminAllSeller),
        headers: {
          'Authorization':
              'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiODcyODU1YjgyZmQ5Njg3ZDgzOTE4ZTYyZWJiZTBiOTJhMzdmYjUzZDk1ZDlkNThiZWZlYmRhMDczMGVjNDI4ZjJmZjFjYWJkY2U2NDRkNTgiLCJpYXQiOjE2NjM1ODI1ODEuODg4Mjc2MTAwMTU4NjkxNDA2MjUsIm5iZiI6MTY2MzU4MjU4MS44ODgyNzg5NjExODE2NDA2MjUsImV4cCI6MTY5NTExODU4MS44ODUzNjE5MDk4NjYzMzMwMDc4MTI1LCJzdWIiOiIxIiwic2NvcGVzIjpbXX0.TAK1DFxKamxw2LdVxBnF1iZ3GXiROQdi_qS8y5X54X69kLuQfXK-ozXt1aTBFm5LNWfsZGfIDMMaLcx_egVUJgkM64qr0IoNn0k435a7iWjNrb9wk_ne5H-FgOaj_4Gv-K1CNPN6NBstlMa-cao4T_iGdaqW9mMtlFFr-MzPt4snP9BHGz0o4znEjl67-4a1S-MYx1svI9TQf6HslbMCxjrcqMWZ-KFWNVsp-4JM7Q17mjAZa1vV6cZAfEx9noxLe1XTsgEKJQjcSqDuuDg0ZEEs7Fof-z2_lcfdXpi9EJ_UnEeXdGRAcLkRFHH32MpdXi2L-dT3VKN7LxFgpv1215LeoZdLVzNG2FRR6GnVPHhgHrFZegjwqZW3TKJPMe-AJwif5D0N2i8wH0kREHHyJ-iYpRhinEAkpauuIRsoN198aPXDpTCfGP6LTsjVyAUbfiT_IVXEevtsByLqpKwu8PtFQtlGoHv0qHBPCrn8nVvMUNnUsWzhXpK4_r0aNTLAYsmO7dUgaZSRgUWw_hEMhjwMlg9mWGpiYMBqdXGRnMHgos5YqrjZ4hfeR89RzdaQWHr7bgV9TWSrTSaTZm9MFP_bthwp-zA2nt1XMtNoErHIfvvk3mkrH6acRMc2I9sKksrluBjeahq6q2eN1-ebb9GDFJG-VVoKMR2qgLEmbzA'
        },
      );

      print({'Authorization': 'Bearer ${getToken()}'});

      return jsonDecode(response.body);
    } on SocketException {
      throw "no Internet";
    }
  }
}
