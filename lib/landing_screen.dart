import 'package:flutter/material.dart';
import 'package:pet_shop/screen/admin/admin_sign_in_screen.dart';
import 'package:pet_shop/screen/seller/seller_sign_in_screen.dart';
import 'package:pet_shop/screen/user/user_sign_in_screen.dart';

import 'constant.dart';
import 'widgets/customer_seller_admin.dart';

class UserOrSellerOrAdmin extends StatefulWidget {
  const UserOrSellerOrAdmin({Key? key}) : super(key: key);

  @override
  UserOrSellerOrAdminState createState() => UserOrSellerOrAdminState();
}

enum PROFILE { initial, user, buyer, admin }

class UserOrSellerOrAdminState extends State<UserOrSellerOrAdmin> {
  PROFILE selectedProfile = PROFILE.initial;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(top: 10, left: 20, right: 20),
        height: MediaQuery.of(context).size.height,
        child: ListView(
          children: [
            Container(
              alignment: Alignment.topCenter,
              margin: const EdgeInsets.only(right: 100, top: 100),
              child: const Center(
                child: Text(
                  "Account Type Selection",
                  style: h1TextStyle,
                  maxLines: 2,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            FittedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedProfile = PROFILE.user;
                      });
                    },
                    child: CustomSellerBuyer(
                      containerHeight: 200,
                      containerWidth: MediaQuery.of(context).size.width / 3,
                      textColor: selectedProfile == PROFILE.user
                          ? Colors.white
                          : Colors.black,
                      borderColor: Colors.grey,
                      icon: Icons.person_outline_outlined,
                      backgroundColor: selectedProfile == PROFILE.user
                          ? Colors.green
                          : Colors.white,
                      textName: 'USER',
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedProfile = PROFILE.buyer;
                      });
                    },
                    child: CustomSellerBuyer(
                      containerHeight: 200,
                      containerWidth: MediaQuery.of(context).size.width / 3,
                      textColor: selectedProfile == PROFILE.buyer
                          ? Colors.white
                          : Colors.black,
                      borderColor: Colors.grey,
                      icon: Icons.local_police_outlined,
                      backgroundColor: selectedProfile == PROFILE.buyer
                          ? Colors.green
                          : Colors.white,
                      textName: 'SELLER',
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedProfile = PROFILE.admin;
                      });
                    },
                    child: CustomSellerBuyer(
                      containerHeight: 200,
                      containerWidth: MediaQuery.of(context).size.width / 3,
                      textColor: selectedProfile == PROFILE.admin
                          ? Colors.white
                          : Colors.black,
                      borderColor: Colors.grey,
                      icon: Icons.admin_panel_settings_outlined,
                      backgroundColor: selectedProfile == PROFILE.admin
                          ? Colors.green
                          : Colors.white,
                      textName: 'ADMIN',
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 60,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                selectedProfile == PROFILE.initial
                    ? Container()
                    : ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: Colors.green),
                        onPressed: () {
                          switch (selectedProfile) {
                            case PROFILE.user:
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const UserSignInScreen(),
                                ),
                              );
                              break;
                            case PROFILE.buyer:
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SellerSignInScreen(),
                                ),
                              );
                              break;

                            case PROFILE.admin:
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const AdminSignInScreen(),
                                ),
                              );
                              break;
                            case PROFILE.initial:
                              break;
                          }

                          // Navigator.push(
                          //     context, MaterialPageRoute(builder: (context) => SignUp()));
                        },
                        child: const Text('CONTINUE'),
                      ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
