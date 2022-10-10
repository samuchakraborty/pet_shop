import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pet_shop/screen/user/user_sign_up_screen.dart';
import 'package:pet_shop/services/admin_services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../widgets/custom_text_field.dart';
import 'admin_home_screen.dart';

class AdminSignInScreen extends StatefulWidget {
  const AdminSignInScreen({Key? key}) : super(key: key);

  @override
  AdminSignInScreenState createState() => AdminSignInScreenState();
}

class AdminSignInScreenState extends State<AdminSignInScreen> {
  bool _secureText = true;
  final _formKey = GlobalKey<FormState>();
  TextEditingController mobileController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Admin Login'),
          centerTitle: true,
        ),
        body: ListView(
          shrinkWrap: true,
          children: [
            SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Container(
                margin: const EdgeInsets.only(top: 50, left: 40, right: 30),
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Column(
                  children: [
                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 40,
                          ),
                          CustomTextField(
                            controller: mobileController,
                            labelName: 'Mobile',
                            hintTextName: 'Enter Your Mobile Number',
                            textInputType: TextInputType.number,
                            validateFunction: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please Enter Your Email Address';
                              }
                            },
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          CustomTextField(
                            controller: passwordController,
                            labelName: 'Password',
                            hintTextName: 'Enter your password',
                            textInputType: TextInputType.visiblePassword,
                            obscureTextTy: _secureText,
                            validateFunction: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please Enter Your Password';
                              }
                            },
                            icon: _secureText
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            onPressed: () {
                              setState(() {
                                _secureText = !_secureText;
                              });
                            },
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          isLoading == true
                              ? const SizedBox(
                                  // height: 20,
                                  // width: 40,
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      color: Colors.green,
                                    ),
                                  ),
                                )
                              : ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.green),
                                  child: const Text('LOG IN'),
                                  onPressed: () async {
                                    setState(() {
                                      isLoading = true;
                                    });
                                    SharedPreferences prefs = await SharedPreferences.getInstance();

                                    await AdminServices.adminLogin(
                                            mobile: mobileController.text,
                                            password: passwordController.text)
                                        .then((value) async {
                                      if (value.statusCode == 200) {
                                        setState(() {
                                          isLoading = false;
                                        });
                                        // print(value.data);
                                       prefs.setString("adminToken", (value.data)['token']);

                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const AdminHomePage(),
                                          ),
                                        );
                                      } else {
                                        setState(() {
                                          isLoading = false;
                                        });
                                      }
                                    }, onError: (err, e) {
                                      setState(() {
                                        isLoading = false;
                                      });
                                    });
                                    // if (kDebugMode) {
                                    //   print(response.statusCode);
                                    // }
                                    // if (response.statusCode == 200) {
                                    //   setState(() {
                                    //     isLoading == false;
                                    //   });
                                    //   Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //       builder: (context) =>
                                    //           const AdminHomePage(),
                                    //     ),
                                    //   );
                                    // } else {}

                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (context) =>
                                    //             const AdminHomePage()));
                                    //if (_formKey.currentState!.validate()) {}
                                  },
                                ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
