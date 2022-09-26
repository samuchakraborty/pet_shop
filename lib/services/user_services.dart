import 'dart:convert';
import 'dart:io';

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

}
