import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet_shop/screen/seller/seller_product_add_screen.dart';
import 'package:pet_shop/screen/user/user_order_screen.dart';
import '../../landing_screen.dart';
import '../../model/seller_product_model.dart';
import '../../services/seller_services.dart';
import '../../services/user_services.dart';
import '../../widgets/slivergrid.dart';

class SellerHomeScreen extends StatefulWidget {
  const SellerHomeScreen({Key? key}) : super(key: key);

  @override
  State<SellerHomeScreen> createState() => _SellerHomeScreenState();
}

class _SellerHomeScreenState extends State<SellerHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const UserOrderScreen(),
                  ));
            },
            child: const Icon(
              Icons.list_alt_outlined,
            ),
          ),
          // automaticallyImplyLeading: false,
          title: const Text("Pet Shop Seller Panel"),
          centerTitle: true,
          actions: [
            // GestureDetector(
            //   onTap: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //         builder: (context) => const CartScreen(),
            //       ),
            //     );
            //   },
            //   child: const Icon(
            //     Icons.shopping_cart,
            //     size: 24,
            //     color: Colors.white,
            //   ),
            // ),
            const SizedBox(
              width: 20,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const UserOrSellerOrAdmin(),
                  ),
                );
              },
              child: const Icon(
                Icons.logout,
                size: 24,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              width: 10,
            )
          ],
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          shrinkWrap: true,
          physics: const AlwaysScrollableScrollPhysics(),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Item',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 19,
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: const Text(
                    'View All',
                    textAlign: TextAlign.end,
                    style: TextStyle(fontSize: 12),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Consumer(builder: (context, ref, child) {
              final getAllProductUrl = ref.watch(sellerProductProvider);

              return getAllProductUrl.when(
                data: (jsonResponse) {
                  SellerProduct usersList =
                      SellerProduct.fromJson(jsonResponse);

                  return

                    usersList.data!.isEmpty
                        ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Center(
                          child: Text("No Product Added"),
                        )
                      ],
                    )
                        :

                    GridView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: usersList.data!.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
                            height: 300,
                            crossAxisCount: 2,
                            crossAxisSpacing: 4,
                            mainAxisSpacing: 2),
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {},
                        child: Card(
                          elevation: 3,
                          margin: const EdgeInsets.all(5),
                          // semanticContainer: true,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    alignment: Alignment.topLeft,
                                    decoration: BoxDecoration(
                                      color: const Color(0XFF0b894),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: const Text(
                                      " Sale",
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                  // Container(
                                  //   width: 20,
                                  //   child:const Text(""),
                                  // ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                height: 150,
                                //  2.5,
                                width: MediaQuery.of(context).size.width / 2,
                                child: Image.network(
                                    "http://petshop.itbros.xyz/${usersList.data![index].image}"),
                              ),
                              Container(
                                alignment: Alignment.center,
                                height: 50,
                                padding: const EdgeInsets.all(5.0),
                                child: Text(
                                  usersList.data![index].name.toString(),
                                  maxLines: 2,
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                // crossAxisAlignment:
                                //     CrossAxisAlignment.end,
                                children: [
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Container(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        "৳ ${usersList.data![index].price.toString()}",
                                        maxLines: 1,
                                        style: TextStyle(
                                          color: usersList.data![index]
                                                      .offerPrice !=
                                                  null
                                              ? Colors.black
                                              : Colors.redAccent,
                                          fontSize: 14,
                                          decoration: usersList.data![index]
                                                      .offerPrice ==
                                                  null
                                              ? TextDecoration.none
                                              : TextDecoration.lineThrough,
                                        ),
                                      ),
                                    ),
                                  ),
                                  if (usersList.data![index].offerPrice != null)
                                    Expanded(
                                      child: Container(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          "৳ ${usersList.data![index].offerPrice.toString()}",
                                          maxLines: 2,
                                          style: const TextStyle(
                                            color: Colors.redAccent,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ),
                                  Expanded(
                                    child: IconButton(
                                      padding: const EdgeInsets.all(0),
                                      iconSize: 30,
                                      icon: const Icon(
                                        Icons.edit,
                                        color: Colors.orange,
                                      ),
                                      onPressed: () {},
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                error: (error, stackTrace) {
                  return Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          ref.refresh(userAllProductProvider);
                        },
                        child: const Text("Load Data"),
                      )
                    ],
                  );
                },
                loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            })
          ],
        ),
        floatingActionButton: FloatingActionButton.small(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SellerProductAddScreen(),
              ),
            );
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

List<String> imgList = [
  "assets/seller-logo.png",
  "assets/seller-logo.png",
  "assets/seller-logo.png",
  "assets/seller-logo.png",
  "assets/seller-logo.png",
  "assets/seller-logo.png",
  "assets/seller-logo.png",
];
