import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet_shop/cart_provider.dart';
import 'package:pet_shop/services/user_services.dart';

import '../../model/all_product_model.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  // List<AllProductHome> product = [];
  //
  // void check() async {
  //   product = ref.watch(cartNotifier).basketItem;
  //   print(product.length);
  // }

  bool isLoading = false;

  @override
  void initState() {
    // check();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Cart"),
        ),
        body: Consumer(builder: (context, ref, child) {
          final cart = ref.watch(cartNotifier);

          List<AllProductHome> product = cart.basketItem;
          return product.isEmpty
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Center(
                      child: Text("No Item Added"),
                    )
                  ],
                )
              : ListView(
                  shrinkWrap: true,
                  physics: const AlwaysScrollableScrollPhysics(),
                  children: [
                    ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: product.length,
                        itemBuilder: (context, i) {
                          return Card(
                            elevation: 4,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.only(left: 5),
                                      child: Image.network(
                                        "http://petshop.itbros.xyz/${product[i].image}",
                                        height: 150,
                                        width: 150,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    const SizedBox(width: 13),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2,
                                          height: 30,
                                          child: Text(
                                            product[i].name.toString(),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                            style: const TextStyle(fontSize: 16),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        FittedBox(
                                          child: Row(
                                            children: [
                                              const SizedBox(width: 10,),
                                              Text(
                                                "${product[i].price} ৳",
                                                style: TextStyle(
                                                  color: product[i].offerPrice !=
                                                      null
                                                      ? Colors.black
                                                      : Colors.redAccent,
                                                  fontSize: 16,
                                                  decoration:
                                                  product[i].offerPrice ==
                                                      null
                                                      ? TextDecoration.none
                                                      : TextDecoration.lineThrough,
                                                ),
                                              ),
                                            const  SizedBox(width: 10,),

                                              if (product[i].offerPrice != null)
                                              Text(
                                                "${product[i].offerPrice} ৳",
                                                style: const TextStyle(
                                                  color: Colors.redAccent,
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 25),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              width: 30,
                                              height: 30,
                                              decoration: BoxDecoration(
                                                color: Colors.blue[300],
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: IconButton(
                                                padding:
                                                    const EdgeInsets.all(3),
                                                icon: const Icon(Icons.remove),
                                                color: Colors.white,
                                                onPressed: () {
                                                  cart.decrementItem(
                                                      product[i]);
                                                  //decrement(cartItems[i]['id'].toString());
                                                },
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              product[i].qty.toString(),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Container(
                                              width: 30,
                                              height: 30,
                                              decoration: BoxDecoration(
                                                color: Colors.blue[300],
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: IconButton(
                                                  padding:
                                                      const EdgeInsets.all(3),
                                                  icon: const Icon(Icons.add),
                                                  color: Colors.white,
                                                  onPressed: () {
                                                    cart.addOneItemIntoBasket(
                                                        product[i]);
                                                    //  increment(cartItems[i]['id'].toString());
                                                  }),
                                            ),
                                            SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    5),
                                            IconButton(
                                              icon: const Icon(Icons.delete),
                                              color: Colors.grey[400],
                                              onPressed: () {
                                                cart.removeOneItemIntoBasket(
                                                    product[i]);

                                                //  delete(cartItems[i]['id'].toString());
                                              },
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        }),
                    const SizedBox(
                      height: 20,
                    ),
                    Column(
                      //physics: NeverScrollableScrollPhysics(),
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ///
                        //SizedBox(height: 50),
                        Card(
                          elevation: 4,
                          margin: const EdgeInsets.all(10),
                          child: Container(
                            // height: MediaQuery.of(context).size.height / 2,
                            height: 320,
                            decoration: BoxDecoration(
                              // border: Border.all(color: Colors.red),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: ListView(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              // mainAxisAlignment: MainAxisAlignment.start,
                              // mainAxisSize: MainAxisSize.min,
                              children: [
                                const SizedBox(height: 11),
                                Container(
                                  // margin: EdgeInsets.only(left: 5),
                                  alignment: Alignment.topLeft,
                                  padding: const EdgeInsets.all(15),
                                  child: const Text("Summary",
                                      style: TextStyle(
                                        fontSize: 26,
                                        fontWeight: FontWeight.bold,
                                      )),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                // Divider(
                                //   height: 1.1,
                                //   color: Colors.grey,
                                // ),
                                Row(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(left: 20),
                                      child: Text(
                                        "SubTotal (${product.length})item",
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    const Spacer(
                                      flex: 1,
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(right: 20),
                                      child: Text(
                                        "${ref.read(cartNotifier).getBasketTotalPrice()} ৳",
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                const Divider(
                                  height: 1.1,
                                  color: Colors.grey,
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                // Divider(
                                //   height: 1.1,
                                //   color: Colors.grey,
                                // ),
                                Row(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(left: 20),
                                      child: const Text(
                                        "Total",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    const Spacer(
                                      flex: 1,
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(right: 20),
                                      child: Text(
                                        // snapshot.data.data.total.toString()
                                        "${ref.read(cartNotifier).getBasketTotalPrice()} ৳",

                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                const Divider(
                                  height: 1.1,
                                  color: Colors.grey,
                                ),
                                // Row(
                                //   mainAxisAlignment: MainAxisAlignment.end,
                                //   children: [
                                //     Container(
                                //       margin: EdgeInsets.only(right: 10),
                                //       child: Text(
                                //         "*Vat Included",
                                //         style: TextStyle(fontSize: 12, color: Colors.grey),
                                //       ),
                                //     ),
                                //   ],
                                // ),
                                const SizedBox(
                                  height: 40,
                                ),
                                isLoading
                                    ? const Center(
                                        child: CircularProgressIndicator(),
                                      )
                                    : Container(
                                        margin: const EdgeInsets.only(
                                            left: 30, right: 30),
                                        decoration: BoxDecoration(
                                          color: Colors.red[500],
                                          // border: Border.all(color: Colors.red),
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                        child: TextButton(
                                          onPressed: () async {
                                            List items = [];
                                            List qty = [];

                                            for (var element in product) {
                                              qty.add(element.qty);
                                            }
                                            for (var element in product) {
                                              items.add(element.id);
                                            }
                                            //
                                            setState(() {
                                              isLoading = true;
                                            });

                                            FormData data = FormData.fromMap({
                                              "items[0]": items.toList(),
                                              "quantity[0]": qty.toList(),
                                              "note": "abc"
                                            });
                                            print(data.fields);

                                            await UserServices()
                                                .placeOrder(data: data)
                                                .then((value) {
                                              if (value.statusCode == 200) {
                                                setState(() {
                                                  isLoading = false;
                                                });

                                                cart.removeCart();

                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  const SnackBar(
                                                    backgroundColor:
                                                        Colors.green,
                                                    content: Text(
                                                        "Order Placed Successfully"),
                                                  ),
                                                );


                                                Navigator.pop(context);
                                              }
                                            }, onError: (error, stackTrac) {
                                              setState(() {
                                                isLoading = false;
                                              });
                                            });
                                          },
                                          child: const Text(
                                            "Proceed To Checkout",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16),
                                          ),
                                        ),
                                      ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                );
        }),

        // body: product.isEmpty
        //     ? Column(
        //         mainAxisAlignment: MainAxisAlignment.center,
        //         children: const [
        //           Center(
        //             child: Text("No Item Added"),
        //           )
        //         ],
        //       )
        //     : Consumer(
        //       builder: (context, ref, child) {
        //         return ListView(
        //             shrinkWrap: true,
        //             physics: const AlwaysScrollableScrollPhysics(),
        //             children: [
        //               ListView.builder(
        //                   shrinkWrap: true,
        //                   physics: const NeverScrollableScrollPhysics(),
        //                   itemCount: product.length,
        //                   itemBuilder: (context, i) {
        //                     return Card(
        //                       elevation: 4,
        //                       child: Column(
        //                         mainAxisAlignment: MainAxisAlignment.start,
        //                         crossAxisAlignment: CrossAxisAlignment.start,
        //                         children: [
        //                           const SizedBox(
        //                             height: 15,
        //                           ),
        //                           Row(
        //                             mainAxisAlignment: MainAxisAlignment.start,
        //                             crossAxisAlignment: CrossAxisAlignment.start,
        //                             children: [
        //                               Container(
        //                                 padding: const EdgeInsets.only(left: 5),
        //                                 child: Image.asset(
        //                                   "assets/dog.jpg",
        //                                   height: 150,
        //                                   width: 150,
        //                                   fit: BoxFit.fill,
        //                                 ),
        //                               ),
        //                               const SizedBox(width: 3),
        //                               Column(
        //                                 mainAxisAlignment: MainAxisAlignment.start,
        //                                 crossAxisAlignment:
        //                                     CrossAxisAlignment.start,
        //                                 children: [
        //                                   SizedBox(
        //                                     width:
        //                                         MediaQuery.of(context).size.width /
        //                                             2,
        //                                     height: 30,
        //                                     child: Text(
        //                                       product[i].name.toString(),
        //                                       overflow: TextOverflow.ellipsis,
        //                                       maxLines: 2,
        //                                     ),
        //                                   ),
        //                                   const SizedBox(
        //                                     height: 15,
        //                                   ),
        //                                   Text(
        //                                     "${product[i].price} ৳",
        //                                     style: const TextStyle(
        //                                         color: Colors.lightBlueAccent),
        //                                   ),
        //                                   const SizedBox(height: 25),
        //                                   Row(
        //                                     mainAxisAlignment:
        //                                         MainAxisAlignment.spaceBetween,
        //                                     children: [
        //                                       Container(
        //                                         width: 30,
        //                                         height: 30,
        //                                         decoration: BoxDecoration(
        //                                           color: Colors.blue[300],
        //                                           borderRadius:
        //                                               BorderRadius.circular(10),
        //                                         ),
        //                                         child: IconButton(
        //                                           padding: const EdgeInsets.all(3),
        //                                           icon: const Icon(Icons.remove),
        //                                           color: Colors.white,
        //                                           onPressed: () {
        //                                             ref.watch(cartNotifier)
        //                                                 .decrementItem(product[i]);
        //                                             //decrement(cartItems[i]['id'].toString());
        //                                           },
        //                                         ),
        //                                       ),
        //                                       const SizedBox(
        //                                         width: 10,
        //                                       ),
        //                                       Text(
        //                                         product[i].qty.toString(),
        //                                       ),
        //                                       const SizedBox(
        //                                         width: 10,
        //                                       ),
        //                                       Container(
        //                                         width: 30,
        //                                         height: 30,
        //                                         decoration: BoxDecoration(
        //                                           color: Colors.blue[300],
        //                                           borderRadius:
        //                                               BorderRadius.circular(10),
        //                                         ),
        //                                         child: IconButton(
        //                                             padding:
        //                                                 const EdgeInsets.all(3),
        //                                             icon: const Icon(Icons.add),
        //                                             color: Colors.white,
        //                                             onPressed: () {
        //                                               ref
        //                                                   .watch(cartNotifier)
        //                                                   .addOneItemIntoBasket(
        //                                                       product[i]);
        //                                               //  increment(cartItems[i]['id'].toString());
        //                                             }),
        //                                       ),
        //                                       SizedBox(
        //                                           width: MediaQuery.of(context)
        //                                                   .size
        //                                                   .width /
        //                                               5),
        //                                       IconButton(
        //                                         icon: const Icon(Icons.delete),
        //                                         color: Colors.grey[400],
        //                                         onPressed: () {
        //                                           ref
        //                                               .watch(cartNotifier)
        //                                               .removeOneItemIntoBasket(
        //                                                   product[i]);
        //
        //                                           //  delete(cartItems[i]['id'].toString());
        //                                         },
        //                                       ),
        //                                     ],
        //                                   ),
        //                                 ],
        //                               ),
        //                             ],
        //                           ),
        //                         ],
        //                       ),
        //                     );
        //                   }),
        //               const SizedBox(
        //                 height: 20,
        //               ),
        //               Column(
        //                 //physics: NeverScrollableScrollPhysics(),
        //                 mainAxisAlignment: MainAxisAlignment.start,
        //                 mainAxisSize: MainAxisSize.min,
        //                 children: [
        //                   ///
        //                   //SizedBox(height: 50),
        //                   Card(
        //                     elevation: 4,
        //                     margin: const EdgeInsets.all(10),
        //                     child: Container(
        //                       // height: MediaQuery.of(context).size.height / 2,
        //                       height: 320,
        //                       decoration: BoxDecoration(
        //                         // border: Border.all(color: Colors.red),
        //                         borderRadius: BorderRadius.circular(12),
        //                       ),
        //                       child: ListView(
        //                         shrinkWrap: true,
        //                         physics: const NeverScrollableScrollPhysics(),
        //                         // mainAxisAlignment: MainAxisAlignment.start,
        //                         // mainAxisSize: MainAxisSize.min,
        //                         children: [
        //                           const SizedBox(height: 11),
        //                           Container(
        //                             // margin: EdgeInsets.only(left: 5),
        //                             alignment: Alignment.topLeft,
        //                             padding: const EdgeInsets.all(15),
        //                             child: const Text("Summary",
        //                                 style: TextStyle(
        //                                   fontSize: 26,
        //                                   fontWeight: FontWeight.bold,
        //                                 )),
        //                           ),
        //                           const SizedBox(
        //                             height: 5,
        //                           ),
        //                           // Divider(
        //                           //   height: 1.1,
        //                           //   color: Colors.grey,
        //                           // ),
        //                           Row(
        //                             children: [
        //                               Container(
        //                                 margin: const EdgeInsets.only(left: 20),
        //                                 child: Text(
        //                                   "SubTotal (${product.length})item",
        //                                   style: const TextStyle(
        //                                       fontSize: 16,
        //                                       fontWeight: FontWeight.w500),
        //                                 ),
        //                               ),
        //                               const Spacer(
        //                                 flex: 1,
        //                               ),
        //                               Container(
        //                                 margin: const EdgeInsets.only(right: 20),
        //                                 child: Text(
        //                                   "${ref.read(cartNotifier).getBasketTotalPrice()} ৳",
        //                                   style: const TextStyle(
        //                                       fontSize: 16,
        //                                       fontWeight: FontWeight.w500),
        //                                 ),
        //                               ),
        //                             ],
        //                           ),
        //                           const SizedBox(
        //                             height: 5,
        //                           ),
        //                           const Divider(
        //                             height: 1.1,
        //                             color: Colors.grey,
        //                           ),
        //                           const SizedBox(
        //                             height: 15,
        //                           ),
        //                           // Divider(
        //                           //   height: 1.1,
        //                           //   color: Colors.grey,
        //                           // ),
        //                           Row(
        //                             children: [
        //                               Container(
        //                                 margin: const EdgeInsets.only(left: 20),
        //                                 child: const Text(
        //                                   "Total",
        //                                   style: TextStyle(
        //                                       fontSize: 16,
        //                                       fontWeight: FontWeight.w500),
        //                                 ),
        //                               ),
        //                               const Spacer(
        //                                 flex: 1,
        //                               ),
        //                               Container(
        //                                 margin: const EdgeInsets.only(right: 20),
        //                                 child: Text(
        //                                   // snapshot.data.data.total.toString()
        //                                   "${ref.read(cartNotifier).getBasketTotalPrice()} ৳",
        //
        //                                   style: const TextStyle(
        //                                       fontSize: 16,
        //                                       fontWeight: FontWeight.w500),
        //                                 ),
        //                               ),
        //                             ],
        //                           ),
        //                           const SizedBox(
        //                             height: 5,
        //                           ),
        //                           const Divider(
        //                             height: 1.1,
        //                             color: Colors.grey,
        //                           ),
        //                           // Row(
        //                           //   mainAxisAlignment: MainAxisAlignment.end,
        //                           //   children: [
        //                           //     Container(
        //                           //       margin: EdgeInsets.only(right: 10),
        //                           //       child: Text(
        //                           //         "*Vat Included",
        //                           //         style: TextStyle(fontSize: 12, color: Colors.grey),
        //                           //       ),
        //                           //     ),
        //                           //   ],
        //                           // ),
        //                           const SizedBox(
        //                             height: 40,
        //                           ),
        //                           Container(
        //                             margin:
        //                                 const EdgeInsets.only(left: 30, right: 30),
        //                             decoration: BoxDecoration(
        //                               color: Colors.red[500],
        //                               // border: Border.all(color: Colors.red),
        //                               borderRadius: BorderRadius.circular(30),
        //                             ),
        //                             child: TextButton(
        //                               onPressed: () async {
        //                                 List items = [];
        //                                 List qty = [];
        //
        //                                 for (var element in product) {
        //                                   qty.add(element.qty);
        //                                 }
        //                                 for (var element in product) {
        //                                   items.add(element.id);
        //                                 }
        //                                 //
        //
        //                                 FormData data = FormData.fromMap({
        //                                   "items[0]": items.toList(),
        //                                   "quantity[0]": qty.toList(),
        //                                   "note": "abc"
        //                                 });
        //                                 print(data.fields);
        //
        //                                await UserServices().placeOrder(data: data).then((value){},);
        //                               },
        //                               child: const Text(
        //                                 "Proceed To Checkout",
        //                                 style: TextStyle(
        //                                     color: Colors.white, fontSize: 16),
        //                               ),
        //                             ),
        //                           ),
        //                         ],
        //                       ),
        //                     ),
        //                   ),
        //                 ],
        //               )
        //             ],
        //           );
        //       }
        //     ),
      ),
    );
  }
}
