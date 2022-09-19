import 'package:flutter/material.dart';

import '../../widgets/custom_text_field.dart';


class SellerSignUpScreen extends StatefulWidget {
  const SellerSignUpScreen({Key? key}) : super(key: key);

  @override
  SellerSignUpScreenState createState() => SellerSignUpScreenState();
}

class SellerSignUpScreenState extends State<SellerSignUpScreen> {
  bool _secureText = true;

  final _formKey = GlobalKey<FormState>();
  late String mobile, password, policeBatchId, nidValue;

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
                          CustomTextField(                            controller: TextEditingController(),

                            labelName: 'Shop Name',
                            hintTextName: 'Enter Your Shop Name',
                            textInputType: TextInputType.text,
                            onChangedFunction: (value) {},
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          CustomTextField(                            controller: TextEditingController(),

                            labelName: 'Email',
                            hintTextName: 'Enter Your Email Address',
                            textInputType: TextInputType.number,
                            onChangedFunction: (value) {
                              //print(value);
                              mobile = value;
                            },
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          CustomTextField(                            controller: TextEditingController(),

                            labelName: 'Password',
                            hintTextName: 'Enter your password',
                            textInputType: TextInputType.visiblePassword,
                            obscureTextTy: _secureText,
                            onChangedFunction: (value) {
                              // print(value);
                              password = value;
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
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(primary: Colors.green),
                            child: const Text('SIGN UP'),
                            onPressed: () {
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
