import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductAddScreen extends StatelessWidget {
  const ProductAddScreen({Key? key}) : super(key: key);

  void check() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    print(prefs.get("userToken"));
  }

  @override
  Widget build(BuildContext context) {
    check();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(" Pet Care"),
        ),
        body: Column(
          children: [


          ],
        ),
      ),
    );
  }
}
