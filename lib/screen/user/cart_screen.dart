import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet_shop/cart_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/all_product_model.dart';

class CartScreen extends ConsumerStatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends ConsumerState<CartScreen> {
  List<AllProductHome> product = [];

  void check() async {
    product = ref.read(cartNotifier).basketItem;
    print(product.length);
  }

  @override
  Widget build(BuildContext context) {
    check();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Cart"),
        ),
        body: product.isEmpty
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
                    // padding: EdgeInsets.all(),
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
                                    child: Image.asset(
                                      "assets/dog.jpg",
                                      height: 150,
                                      width: 150,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  const SizedBox(width: 3),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2,
                                        height: 30,
                                        child: Text(
                                          product[i].name.toString(),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Text(
                                        "${product[i].price} ৳",
                                        style: const TextStyle(
                                            color: Colors.lightBlueAccent),
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
                                              padding: const EdgeInsets.all(3),
                                              icon: const Icon(Icons.remove),
                                              color: Colors.white,
                                              onPressed: () {
                                                ref
                                                    .watch(cartNotifier)
                                                    .decrementItem(product[i]);
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
                                                  ref
                                                      .watch(cartNotifier)
                                                      .addOneItemIntoBasket(
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
                                              ref
                                                  .watch(cartNotifier)
                                                  .removeOneItemIntoBasket(
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

                  const SizedBox(height: 20,),
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
                              Container(
                                margin: const EdgeInsets.only(left: 30, right: 30),
                                decoration: BoxDecoration(
                                  color: Colors.red[500],
                                  // border: Border.all(color: Colors.red),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: TextButton(
                                  onPressed: () {
                                    //  print(address);
                                    // if (address == 'null' || address == null) {
                                    //   Navigator.push(
                                    //       context,
                                    //       MaterialPageRoute(
                                    //           builder: (context) => Address(
                                    //                 address: null,
                                    //               )));
                                    // } else {
                                    //   Navigator.push(
                                    //       context,
                                    //       MaterialPageRoute(
                                    //           builder: (context) =>
                                    //               CheckOutPage()));
                                    // }
                                  },
                                  child: const Text(
                                    "Proceed To Checkout",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16),
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
              ),
      ),
    );
  }
}
