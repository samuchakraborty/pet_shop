import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../cart_provider.dart';
import '../../model/all_product_model.dart';
import '../../model/shop_wise_product_model.dart';
import '../../services/user_services.dart';
import '../../widgets/slivergrid.dart';

class SingleProductScreen extends StatelessWidget {
  const SingleProductScreen(
      {Key? key, required this.shopName, required this.shopSlug})
      : super(key: key);

  final String shopName, shopSlug;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text(shopName),
            centerTitle: true,
          ),
          body: Consumer(builder: (context, ref, child) {
            final getAllProductUrl = ref.watch(userAllProductProvider);

            return getAllProductUrl.when(
              data: (jsonResponse) {
                List<dynamic> usersList = jsonResponse
                    .map((data) => AllProductHome.fromJson(data))
                    .toList();

                return GridView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: usersList.length,
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
                    height: 300,
                    crossAxisCount: 2,
                    crossAxisSpacing: 4,
                    mainAxisSpacing: 2,
                  ),
                  //physics: const NeverScrollableScrollPhysics(),
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              height: 150,
                              //  2.5,
                              width: MediaQuery.of(context).size.width / 2,
                              child: Image.network(
                                  "http://petshop.itbros.xyz/${usersList[index].image}"),
                            ),
                            Container(
                              alignment: Alignment.center,
                              height: 50,
                              padding: const EdgeInsets.all(5.0),
                              child: Text(
                                usersList[index].name,
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
                                      "৳ ${usersList[index].price.toString()}",
                                      maxLines: 1,
                                      style: TextStyle(
                                        color:
                                            usersList[index].offerPrice != null
                                                ? Colors.black
                                                : Colors.redAccent,
                                        fontSize: 14,
                                        decoration:
                                            usersList[index].offerPrice == null
                                                ? TextDecoration.none
                                                : TextDecoration.lineThrough,
                                      ),
                                    ),
                                  ),
                                ),
                                if (usersList[index].offerPrice != null)
                                  Expanded(
                                    child: Container(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        "৳ ${usersList[index].offerPrice.toString()}",
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
                                        Icons.shopping_cart,
                                        color: Colors.orange,
                                      ),
                                      onPressed: () {
                                        ref
                                            .watch(cartNotifier)
                                            .addOneItemIntoBasket(
                                                usersList[index]);
                                      }),
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
          })),
    );
  }
}
