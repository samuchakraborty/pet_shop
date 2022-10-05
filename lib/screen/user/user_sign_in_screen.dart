import 'package:flutter/material.dart';
import 'package:pet_shop/screen/user/user_home_screen.dart';
import 'package:pet_shop/screen/user/user_sign_up_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../services/user_services.dart';
import '../../widgets/custom_text_field.dart';

class UserSignInScreen extends StatefulWidget {
  const UserSignInScreen({Key? key}) : super(key: key);

  @override
  UserSignInScreenState createState() => UserSignInScreenState();
}

class UserSignInScreenState extends State<UserSignInScreen> {
  bool _secureText = true;
  final _formKey = GlobalKey<FormState>();
  TextEditingController mobile = TextEditingController();
  TextEditingController password = TextEditingController();
  bool isLoading = false;



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('User Login'),
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
                          // const Center(
                          //   child: Text(
                          //     "Log In",
                          //     maxLines: 2,
                          //     style: TextStyle(
                          //       color: Colors.blue,
                          //       fontWeight: FontWeight.w700,
                          //       fontSize: 20,
                          //     ),
                          //   ),
                          // ),
                          const SizedBox(
                            height: 40,
                          ),
                          CustomTextField(
                            controller: mobile,
                            labelName: 'Mobile',
                            hintTextName: 'Enter Your Mobile Number',
                            textInputType: TextInputType.number,

                            validateFunction: (value) {},
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
                          isLoading
                              ? const Center(
                            child: CircularProgressIndicator(),
                          )
                              :   ElevatedButton(
                            style:
                                ElevatedButton.styleFrom(primary: Colors.green),
                            child: const Text('LOG IN'),
                            onPressed: () async {
                              setState(() {
                                isLoading = true;
                              });

                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();

                              await UserServices.userLogin(

                                      mobile: mobile.text,
                                      password: password.text)
                                  .then((value) {
                                setState(() {
                                  isLoading = false;
                                });
                                if (value.statusCode == 200) {
                                  // prefs.setString(
                                  //     "userToken", value.data['token']);

                                  ScaffoldMessenger.of(context).showSnackBar(
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
                                          const UserHomeScreen(),
                                    ),
                                  );
                                }
                              }, onError: (e, stackTrace) {
                                    print(e.toString());
                                setState(() {
                                  isLoading = false;
                                });

                                ScaffoldMessenger.of(context).showSnackBar(
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const UserSignUpScreen(),
                          ),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            "Don't have an account? ",
                            style: TextStyle(
                              fontSize: 17,
                            ),
                          ),
                          Text(
                            "Sign up ",
                            style: TextStyle(
                              fontSize: 17,
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
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
