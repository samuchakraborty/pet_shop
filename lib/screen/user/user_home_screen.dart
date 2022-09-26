import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet_shop/screen/user/shop_wise_product.dart';

import '../../model/all_product_model.dart';
import '../../model/all_seller_model.dart';
import '../../model/seller_model.dart';
import '../../services/user_services.dart';
import '../../widgets/slivergrid.dart';

class UserHomeScreen extends StatefulWidget {
  const UserHomeScreen({Key? key}) : super(key: key);

  @override
  State<UserHomeScreen> createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  int _current = 0;
  final CarouselController _controller = CarouselController();

  List<Widget> imageSliders = imgList
      .map((item) => Container(
            margin: const EdgeInsets.all(5.0),
            height: 100,
            child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                child: Stack(
                  children: <Widget>[
                    Image.network(item, fit: BoxFit.cover, width: 1000.0),
                  ],
                )),
          ))
      .toList();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text("Pet Shop"),
          centerTitle: true,
        ),
        body: ListView(
          padding: const EdgeInsets.all(20),
          shrinkWrap: true,
          physics: const AlwaysScrollableScrollPhysics(),
          children: [
            Stack(children: [
              CarouselSlider(
                options: CarouselOptions(
                  height: 150,
                  viewportFraction: 1.0,
                  enlargeCenterPage: false,
                  autoPlay: true,
                ),
                items: imgList
                    .map((item) => Center(
                            child: Image.asset(
                          item,
                          fit: BoxFit.contain,
                          height: 150,
                          width: MediaQuery.of(context).size.width,
                        )))
                    .toList(),
              ),
              Positioned(
                bottom: 1,
                // height: w,
                right: 20,
                left: 20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: imgList.asMap().entries.map((entry) {
                    return GestureDetector(
                      onTap: () => _controller.animateToPage(entry.key),
                      child: Container(
                        width: 12.0,
                        height: 12.0,
                        margin: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 4.0),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color:
                                (Theme.of(context).brightness == Brightness.dark
                                        ? Colors.white
                                        : Colors.black)
                                    .withOpacity(
                                        _current == entry.key ? 0.9 : 0.4)),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ]),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Shop',
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
            SizedBox(
              height: 120,
              width: MediaQuery.of(context).size.width,
              child: Consumer(builder: (context, ref, child) {
                final getAllProductUrl = ref.watch(allSellerProvider);

                return getAllProductUrl.when(
                  data: (data) {
                    SellerModel allSeller = SellerModel.fromJson(data);

                    return ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: allSeller.data!.length,
                      itemBuilder: (context, i) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SingleProductScreen(
                                  shopSlug: allSeller.data![i].slug.toString(),
                                  shopName:
                                      allSeller.data![i].shopName.toString(),
                                ),
                              ),
                            );
                          },
                          child: Card(
                            elevation: 4,
                            margin: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 5),
                            child: Stack(
                              children: [
                                Image.network(
                                  "http://petshop.itbros.xyz/${allSeller.data![i].profilePicture}",
                                  width: 150,
                                  height: 100,
                                ),
                                Positioned(
                                  bottom: 40,
                                  // top: 10,
                                  left: 20,
                                  right: 20,
                                  child: Container(
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5, vertical: 5),
                                    decoration: const BoxDecoration(
                                        color: Colors.black),
                                    width: 134,
                                    child: Text(
                                      allSeller.data![i].shopName.toString(),
                                      style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
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
                            ref.refresh(allSellerProvider);
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
              }),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Pet Services',
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
            SizedBox(
              height: 120,
              width: MediaQuery.of(context).size.width,
              child: Consumer(builder: (context, ref, child) {
                final getAllProductUrl = ref.watch(allSellerProvider);

                return getAllProductUrl.when(
                  data: (data) {
                    print(data);
                    SellerModel allSeller = SellerModel.fromJson(data);

                    return ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: allSeller.data!.length,
                      itemBuilder: (context, i) {
                        return Card(
                          elevation: 4,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 5),
                          child: Stack(
                            children: [
                              Image.network(
                                "http://petshop.itbros.xyz/${allSeller.data![i].logo}",
                                width: 150,
                                height: 100,
                              ),
                              Positioned(
                                bottom: 40,
                                // top: 10,
                                left: 20,
                                right: 20,
                                child: Container(
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 5),
                                  decoration:
                                      const BoxDecoration(color: Colors.black),
                                  width: 134,
                                  child: Text(
                                    allSeller.data![i].shopName.toString(),
                                    style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            ],
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
                            ref.refresh(allSellerProvider);
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
              }),
            ),
            const SizedBox(
              height: 10,
            ),
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
              final getAllProductUrl = ref.watch(userAllProductProvider);

              return getAllProductUrl.when(
                data: (jsonResponse) {
                  List<dynamic> usersList = jsonResponse
                      .map((data) => AllProductHome.fromJson(data))
                      .toList();

                  return GridView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: usersList.length - 1,
                    // controller: _scrollController,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
                      height: 320,
                      crossAxisCount: 2,
                    ),
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {},
                        child: Card(
                          elevation: 3,
                          semanticContainer: true,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    alignment: Alignment.topLeft,
                                    padding: const EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                      color: const Color(0XFF0b894),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: const Text(
                                      "Sale",
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
                                  Container(
                                    alignment: Alignment.bottomRight,
                                    margin: const EdgeInsets.only(right: 10),
                                    child: IconButton(
                                        padding: const EdgeInsets.all(0),
                                        icon: const Icon(Icons.heart_broken),
                                        onPressed: () {
                                          //});
                                        }),
                                  ),
                                ],
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
                                        "৳ ${usersList[index].variants.isNotEmpty ? usersList[index].variants[0].price.toString() : 200}",
                                        maxLines: 1,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      alignment: Alignment.topLeft,
                                      child: const Text(
                                        "৳200",
                                        maxLines: 2,
                                        style: TextStyle(
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
                                        onPressed: () {}),
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
