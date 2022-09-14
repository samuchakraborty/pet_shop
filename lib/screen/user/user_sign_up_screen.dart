import 'package:flutter/material.dart';
import 'package:pet_shop/screen/user/user_sign_in_screen.dart';

import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';


class UserSignUpScreen extends StatefulWidget {
  const UserSignUpScreen({Key? key}) : super(key: key);

  @override
  UserSignUpScreenState createState() => UserSignUpScreenState();
}

class UserSignUpScreenState extends State<UserSignUpScreen> {
  bool _secureText = true;

  final _formKey = GlobalKey<FormState>();
  late String mobile, password, policeBatchId, nidValue;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('User Sign Up'),
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

                    const SizedBox(
                      height: 40,
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          CustomTextField(
                            labelName: 'Name',
                            hintTextName: 'Enter Your Name',
                            textInputType: TextInputType.text,
                            onChangedFunction: (value) {},
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          CustomTextField(
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
                          CustomTextField(
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
