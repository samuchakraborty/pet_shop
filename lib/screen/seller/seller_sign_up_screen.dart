import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pet_shop/screen/seller/seller_home_screen.dart';
import 'package:pet_shop/services/seller_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../widgets/custom_text_field.dart';

class SellerSignUpScreen extends StatefulWidget {
  const SellerSignUpScreen({Key? key}) : super(key: key);

  @override
  SellerSignUpScreenState createState() => SellerSignUpScreenState();
}

class SellerSignUpScreenState extends State<SellerSignUpScreen> {
  bool _secureText = true;

  TextEditingController name = TextEditingController();
  TextEditingController shopName = TextEditingController();

  TextEditingController mobile = TextEditingController();
  TextEditingController password = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Seller Sign Up'),
          centerTitle: true,
        ),
        body: ListView(
          shrinkWrap: true,
          children: [
            SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Container(
                margin: const EdgeInsets.only(top: 40, left: 40, right: 30),
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.topCenter,
                      //  margin: const EdgeInsets.only(right: 120),
                      child: const Center(
                        child: Text(
                          "Create Shop",
                          // style: h1TextStyle,
                          style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                          ),
                          maxLines: 2,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          CustomTextField(
                            controller: name,
                            labelName: 'Name',
                            hintTextName: 'Enter Your Name',
                            textInputType: TextInputType.text,
                            onChangedFunction: (value) {},
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          CustomTextField(
                            controller: shopName,
                            labelName: 'Shop Name',
                            hintTextName: 'Enter Your Shop Name',
                            textInputType: TextInputType.text,
                            onChangedFunction: (value) {},
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          CustomTextField(
                            controller: mobile,
                            labelName: 'Mobile',
                            hintTextName: 'Enter Your Mobile Number',
                            textInputType: TextInputType.number,
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          CustomTextField(
                            controller: password,
                            labelName: 'Password',
                            hintTextName: 'Enter your password',
                            textInputType: TextInputType.visiblePassword,
                            obscureTextTy: _secureText,
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
                          isLoading
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.green),
                                  child: const Text('SIGN UP'),
                                  onPressed: () async {
                                    setState(() {
                                      isLoading = true;
                                    });
                                    SystemChannels.textInput.invokeMethod('TextInput.hide');
                                    SharedPreferences prefs =
                                        await SharedPreferences.getInstance();

                                    await SellerServices.userRegistration(
                                      name: name.text,
                                      mobile: mobile.text,
                                      password: password.text,
                                      shopName: shopName.text,
                                    ).then((value) {
                                      setState(() {
                                        isLoading = false;
                                      });
                                      if (value.statusCode == 200) {
                                        prefs.setString(
                                            "sellerToken", value.data['token']);

                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            backgroundColor: Colors.green,
                                            content: Text(
                                                "User Registration Successfully"),
                                          ),
                                        );

                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const SellerHomeScreen(),
                                          ),
                                        );
                                      }
                                    }, onError: (e, stackTrace) {
                                      setState(() {
                                        isLoading = false;
                                      });

                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          backgroundColor: Colors.red,
                                          content: Text(e.toString()),
                                        ),
                                      );
                                    });

                                    // Navigator.pushNamed(
                                    //   context,
                                    //   RouteConstants.homeScreen,
                                    // ); //  if (_formKey.currentState!.validate()) {}
                                  },
                                ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            "Already have an account? ",
                            style: TextStyle(fontSize: 17),
                          ),
                          Text(
                            "Log In ",
                            style: TextStyle(
                              fontSize: 17,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                    )
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
