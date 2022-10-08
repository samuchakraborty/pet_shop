import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'model/all_product_model.dart';

final cartNotifier = ChangeNotifierProvider<MyStore>((_) => MyStore());

class MyStore extends ChangeNotifier {
  List<AllProductHome> productItem = [];
  List<AllProductHome> basketItem = [];

  late double totalCartValue;

 MyStore() {
  //   //set up data
  productItem = products;
  //   // //send notification to provider
notifyListeners();
  }



  List<AllProductHome> get products => productItem;

  double get totalCartCount => getBasketTotalPrice();

  List<AllProductHome> get basket => basketItem;

  addOneItemIntoBasket(AllProductHome p) {
    print('jj');
    AllProductHome? found =
        basketItem.firstWhereOrNull((element) => element.id == p.id);

    if (found != null) {
      found.qty += 1;
    } else {

      basketItem.add(p);
      print("item Added");
    }
    notifyListeners();

  } //ef


  decrementItem(AllProductHome p) {
    AllProductHome? found =
    basketItem.firstWhereOrNull((element) => element.id == p.id);

    if (found != null && found.qty == 1) {
      found.qty = 1;
    } else {
      found!.qty -= 1;
      //
      // // basketItem.add(p);
      // print("item dec");
    }
    notifyListeners();

  } //ef


  removeCart(){
    basketItem = [];

    notifyListeners();


  }

//add ot remove any object in basket
  removeOneItemIntoBasket(AllProductHome p) {
    AllProductHome? found =
        basketItem.firstWhereOrNull((element) => element.id == p.id);

    if (found != null && found.qty == 1) {
      basketItem.remove(p);
      print('item removeded');
    } else {
      basketItem.remove(p);
    }

   notifyListeners();
  } //ef

  getBasketQty() {
    int total = 0;
    for (int i = 0; i < basketItem.length; i++) {
      total += basketItem[i].qty;
    }
    notifyListeners();
    return total;
  }

  double getBasketTotalPrice() {
    double total = 0;
    for (int i = 0; i < basketItem.length; i++) {
      total += double.parse(basketItem[i].price.toString()) *
          double.parse(basketItem[i].qty.toString());
    }
    notifyListeners();
    return total;
  }
}
