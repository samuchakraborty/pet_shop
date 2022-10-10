import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet_shop/model/all_seller_model.dart';
import 'package:pet_shop/services/admin_services.dart';

import '../../model/all_userModel.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({Key? key}) : super(key: key);

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage>
    with TickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      initialIndex: 0,
      length: 2,
      vsync: this,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _tabController!.dispose();
  }

  // bool isSwitched = false;
  // var textValue = 'Switch is OFF';
  //
  // void toggleSwitch(bool value) {
  //   if (isSwitched == false) {
  //     setState(() {
  //       isSwitched = true;
  //       textValue = 'Switch Button is ON';
  //     });
  //     print('Switch Button is ON');
  //   } else {
  //     setState(() {
  //       isSwitched = false;
  //       textValue = 'Switch Button is OFF';
  //     });
  //     print('Switch Button is OFF');
  //   }
  // }
  final List<int> _selectedUserIds = [];

  void onUserSelected(bool selected, pid) {
    if (selected == true) {
      setState(() {
        _selectedUserIds.add(pid);
      });
    } else {
      setState(() {
        _selectedUserIds.remove(pid);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text("Admin DashBoard"),
          centerTitle: true,
        ),
        body: ListView(
          shrinkWrap: true,
          physics: const AlwaysScrollableScrollPhysics(),
          children: [
            const SizedBox(
              height: 20,
            ),
            Card(
              margin: const EdgeInsets.only(left: 10, right: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: TabBar(
                  labelPadding: const EdgeInsets.symmetric(vertical: 5),
                  controller: _tabController,
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.black54,
                  //  indicatorColor: iconColor,
                  indicatorSize: TabBarIndicatorSize.tab,
                  physics: const AlwaysScrollableScrollPhysics(),
                  indicator: const ShapeDecoration(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    color: Colors.green,
                  ),
                  tabs: const [
                    Tab(
                      text: 'User',
                    ),
                    Tab(
                      text: 'Seller',
                    ),
                  ]),
            ),
            Container(
              padding: const EdgeInsets.all(20),
              height: MediaQuery.of(context).size.height,
              child: TabBarView(controller: _tabController, children: [
                Consumer(builder: (context, ref, child) {
                  final adminAllUser = ref.watch(adminAllUserProvider);
                  return adminAllUser.when(data: (data) {
                    print(data);
                    AlluserModel usrModel = AlluserModel.fromJson(data);

                    return ListView.builder(
                        itemCount: usrModel.data!.length,
                        itemBuilder: (context, i) {
                          return Card(
                            child: Container(
                              padding: const EdgeInsets.all(20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Name: ${usrModel.data![i].name}"),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                          "Mobile: ${usrModel.data![i].mobile}"),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                          "Status: ${_selectedUserIds.contains(int.parse(usrModel.data![i].id.toString())) == true ? " Active" : " InActive"}"),
                                    ],
                                  ),
                                  Switch(
                                    value: _selectedUserIds.contains(int.parse(
                                        usrModel.data![i].id.toString())),
                                    onChanged: (bool? selected) {
                                      onUserSelected(
                                        selected!,
                                        int.parse(
                                            usrModel.data![i].id.toString()),
                                      );
                                    },
                                    activeColor: Colors.green,
                                    activeTrackColor: Colors.greenAccent,
                                    inactiveThumbColor: Colors.redAccent,
                                    inactiveTrackColor: Colors.red,
                                  )
                                ],
                              ),
                            ),
                          );
                        });
                  }, error: (err, e) {
                    return Text(e.toString());
                  }, loading: () {
                    return const Center(child: CircularProgressIndicator());
                  });
                }),
                Consumer(builder: (context, ref, child) {
                  final adminAllUser = ref.watch(adminAllSellerProvider);
                  return adminAllUser.when(data: (data) {
                    AllSellerModel usrModel = AllSellerModel.fromJson(data);

                    return ListView.builder(
                        itemCount: usrModel.data!.length,
                        // padding: EdgeInsets.symmetric(vertical: 20),
                        itemBuilder: (context, i) {
                          return Card(
                            margin:  EdgeInsets.symmetric(vertical: 10),
                            child: Container(
                              padding: const EdgeInsets.all(20),
                              child: FittedBox(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    usrModel.data![i].logo == null
                                        ? SizedBox(
                                            width: 40,
                                            height: 60,
                                            child: Image.asset("assets/seller-logo.png"),
                                          )
                                        : SizedBox(
                                            width: 40,
                                            height: 40,
                                            child: Image.network(
                                                "http://petshop.itbros.xyz/${usrModel.data![i].logo}")),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            "Owner Name: ${usrModel.data![i].owner!.name}"),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                            "Owner Mobile: ${usrModel.data![i].owner!.mobile}"),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                            "Store Name: ${usrModel.data![i].shopName}"),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                            "Status: ${_selectedUserIds.contains(int.parse(usrModel.data![i].id.toString())) == true ? " Active" : " InActive"}"),
                                      ],
                                    ),
                                    Switch(
                                      value: _selectedUserIds.contains(
                                          int.parse(
                                              usrModel.data![i].id.toString())),
                                      onChanged: (bool? selected) {
                                        onUserSelected(
                                          selected!,
                                          int.parse(
                                              usrModel.data![i].id.toString()),
                                        );
                                      },
                                      activeColor: Colors.green,
                                      activeTrackColor: Colors.greenAccent,
                                      inactiveThumbColor: Colors.redAccent,
                                      inactiveTrackColor: Colors.red,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        });
                  }, error: (err, e) {
                    return Text(e.toString());
                  }, loading: () {
                    return const Center(child: CircularProgressIndicator());
                  });
                }),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
