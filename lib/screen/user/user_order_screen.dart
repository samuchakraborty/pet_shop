import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../model/UserOrderModel.dart';
import '../../services/user_services.dart';

class UserOrderScreen extends StatelessWidget {
  const UserOrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Order"),
          centerTitle: true,
        ),
        body: Consumer(
          builder: (context, ref, child) {
            final data2 = ref.watch(userAllOrderProvider);

            return data2.when(
                data: (data) {
                  UserOrderModel userOrderModel = UserOrderModel.fromJson(data);

                  return ListView.builder(
                    itemCount: userOrderModel.data!.reversed.length,
                    itemBuilder: (context, i) {
                      var orders = userOrderModel.data![i];
                      return GestureDetector(
                        onTap: () {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => Timeline(
                          //               orderNo: orders.no.toString(),
                          //             )));
                        },
                        child: Container(
                          margin: const EdgeInsets.only(left: 15, right: 15, top: 8),
                          child: Card(
                              elevation: 6,
                              child: Container(
                                padding: const EdgeInsets.all(15),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      // alignment: Alignment.topRight,
                                      margin:
                                          EdgeInsets.only(left: 10, bottom: 10),
                                      child: Row(
                                        children: [
                                          Column(
                                            children: [
                                              // RichText(
                                              //   text: TextSpan(children: [
                                              //     TextSpan(
                                              //         text: "Order  ",
                                              //         style: TextStyle(
                                              //             color: Colors.black45,
                                              //             fontSize: 18,
                                              //             fontWeight:
                                              //                 FontWeight.bold)),
                                              //     TextSpan(
                                              //         text: "#" + orders.no,
                                              //         style: TextStyle(
                                              //             color: Colors.black,
                                              //             fontSize: 20,
                                              //             fontWeight:
                                              //                 FontWeight.bold)),
                                              //   ]),
                                              // ),

                                              Row(children: [
                                                Text(
                                                  "Order  ",
                                                  style: TextStyle(
                                                      color: Colors.black45,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Container(
                                                  width: 100,
                                                  child: Text(
                                                    "#" + orders.orderNo.toString(),
                                                    // maxLines: 3,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ]),

                                              Text(
                                                  DateFormat.yMMMd()
                                                      .format(DateTime.parse(
                                                          orders.updatedAt.toString()))
                                                      .toString(),
                                                  style: TextStyle(
                                                      color: Colors.red,
                                                      fontWeight:
                                                          FontWeight.w300)),
                                              // Text(DateFormat(''))
                                            ],
                                          ),
                                          SizedBox(
                                            width: 25,
                                          ),
                                          Row(
                                            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Column(
                                                children: [
                                                  Container(
                                                    height: 20,
                                                    child: Icon(
                                                      getStatusIcon(
                                                          orders.status.toString()),
                                                      color: getStatusColor(
                                                          orders.status.toString()),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Container(
                                                    height: 20,
                                                    child: Icon(
                                                      Icons.payments_outlined,
                                                      color:
                                                          orders.status !=
                                                                  'pending'
                                                              ? Colors.green
                                                              : Colors.red,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Container(
                                                    height: 20,
                                                    child: Icon(
                                                      Icons
                                                          .monetization_on_sharp,
                                                      // color: Colors.green,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Column(
                                                children: [
                                                  Container(
                                                    height: 20,
                                                    child: Text(
                                                      orders.status.toString(),
                                                      style: TextStyle(
                                                          color: getStatusColor(
                                                              orders.status.toString())),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 6,
                                                  ),
                                                  Container(
                                                    height: 20,
                                                    child: Text(
                                                      orders.status.toString(),
                                                      style: TextStyle(
                                                        color:
                                                            orders.status !=
                                                                    'pending'
                                                                ? Colors.green
                                                                : Colors.red,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 6,
                                                  ),
                                                  Container(
                                                      height: 20,
                                                      child: Text(orders.total
                                                          .toString())),
                                                ],
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    // Row(
                                    //   mainAxisAlignment:
                                    //       MainAxisAlignment.spaceBetween,
                                    //   children: [
                                    //     GestureDetector(
                                    //       onTap: () {
                                    //         Navigator.push(
                                    //             context,
                                    //             MaterialPageRoute(
                                    //                 builder: (context) => Timeline(orderNo: orders.no.toString(),)
                                    //             )
                                    //         );
                                    //       },
                                    //       child: Text("View",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w600),),
                                    //     ),
                                    //     GestureDetector(
                                    //       onTap: () {
                                    //         Navigator.push(
                                    //             context,
                                    //             MaterialPageRoute(
                                    //             builder: (context) => OrderDetailsPage(orderNo: orders.no.toString(),)));
                                    //
                                    //       },
                                    //       child: Text("Details",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w600)),
                                    //     ),
                                    //   ],
                                    // )
                                  ],
                                ),
                              )),
                        ),
                      );
                    },
                  );
                },
                error: (error, e) {
                  return GestureDetector(
                    onTap: () {
                      ref.refresh(userAllOrderProvider);
                    },
                    child: Text(error.toString()),
                  );
                },
                loading: () => const Center(
                      child: CircularProgressIndicator(),
                    ));
          },
        ),
      ),
    );
  }

  Color? getStatusColor(String status) {
    switch (status) {
      case 'Pending':
        return Colors.orangeAccent;
      case 'Accepted':
        return Colors.green[500];
      case 'On Delivery':
        return Colors.yellow;
      case 'Delivered':
        return Colors.green[700];
      case 'Cancelled':
        return Colors.red;
      default:
        return Colors.lightBlue;
    }
  }

  IconData getStatusIcon(String status) {
    switch (status) {
      case 'Pending':
        return Icons.timelapse_rounded;
      case 'Accepted':
        return Icons.thumb_up;
      case 'On Delivery':
        return Icons.delivery_dining;
      case 'Delivered':
        return Icons.inventory;
      case 'Cancelled':
        return Icons.clear;
      default:
        return Icons.timer;
    }
  }
}
