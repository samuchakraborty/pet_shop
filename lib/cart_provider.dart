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
    //set up data
    productItem = products;
    //send notification to provider
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



//add ot remove any object in basket
  removeOneItemIntoBasket(AllProductHome p) {
    AllProductHome? found =
        basketItem.firstWhereOrNull((element) => element.id == p.id);

    if (found != null && found.qty == 1) {
      basketItem.remove(p);
      print('item removeded');
    } else {
      found!.qty -= 1;
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

//add multiple qty at a time any object in basket
//   addMultipleItemIntoBasket(AllProductHome p, int initialQty) {
//     Product? found = basketItem.firstWhereOrNull((element) => element.slug == p.slug);
//
//     if (found != null) {
//       // if(found.qty >= initialQty){
//       //   found.qty = found.maxOrderableQty;
//       // }
//       // else {
//       found.qty += initialQty;
//       // }
//
//     } else {
//       p.qty = initialQty;
//       basketItem.add(p);
//     }
//
//     notifyListeners();
//   }
//   // void toggleDone() {
//   //   activeProductItem.qty++;
//   // }
//
//   // void decreaseDown() {
//   //   activeProductItem.qty == 0 ? 0 : activeProductItem.qty--;
//   // }
//
//   // void updateTask(Product task) {
//   //   task.toggleDone();
//   //   notifyListeners();
//   // }
//
//   void removeCard(AllProductHome task) {
//     _addNewData.remove(task);
//     notifyListeners();
//   }
// //
//   void decrease(AllProductHome task) {
//     if (task.qty == 1) {
//       // removeCard(task);
//       basketItem.remove(task);
//     }
//
//     notifyListeners();
//   }

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
