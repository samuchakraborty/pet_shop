import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../services/seller_services.dart';
import '../../widgets/custom_text_field.dart';

class SellerProductAddScreen extends ConsumerStatefulWidget {
  const SellerProductAddScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<SellerProductAddScreen> createState() => _SellerProductAddScreenState();
}

class _SellerProductAddScreenState extends ConsumerState<SellerProductAddScreen> {
  File? imageFile;

  bool isLoading = false;
  TextEditingController name = TextEditingController();
  TextEditingController description = TextEditingController();

  TextEditingController price = TextEditingController();
  TextEditingController offerPrice = TextEditingController();

  @override
  void initState() {
    super.initState();
    check();
  }

  final _formKey = GlobalKey<FormState>();

  void check() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    print(prefs.get("sellerToken"));
  }

  @override
  Widget build(BuildContext context) {
    // check();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Product Add Screen"),
        ),
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: ListView(
            shrinkWrap: true,
            children: [
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 40,
                    ),
                    CustomTextField(
                      controller: name,
                      labelName: 'Product Name',
                      hintTextName: 'Enter Product Name',
                      textInputType: TextInputType.emailAddress,
                      validateFunction: (value) {},
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    CustomTextField(
                      controller: description,
                      labelName: 'Product Description',
                      hintTextName: 'Enter Product Description',
                      textInputType: TextInputType.visiblePassword,
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    CustomTextField(
                      controller: price,
                      labelName: 'Price',
                      hintTextName: 'Enter price amount',
                      textInputType: TextInputType.visiblePassword,
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    CustomTextField(
                      controller: offerPrice,
                      labelName: 'Discount Price',
                      hintTextName: 'Enter discount price',
                      textInputType: TextInputType.visiblePassword,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Product Image",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 16),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Stack(
                          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 200,
                              height: 150,
                              child: imageFile != null
                                  ? Image.file(
                                      imageFile!,
                                      width: MediaQuery.of(context).size.width,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.asset(
                                      "assets/preview.png",
                                      width: 200,
                                      height: 150,
                                      fit: BoxFit.contain,
                                    ),
                            ),
                            Positioned(
                              bottom: 20,
                              right: 10,
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: IconButton(
                                  color: Colors.black,
                                  iconSize: 36,
                                  icon: const Icon(Icons.camera_alt_outlined),
                                  onPressed: () {
                                    showModalBottomSheet(
                                      context: context,
                                      builder: (context) => SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                3,
                                        child: Column(
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.only(
                                                  top: 20),
                                              child: const Text(
                                                'Select Source',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 18),
                                              ),
                                            ),
                                            SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  4,
                                              child: GridView(
                                                gridDelegate:
                                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount: 3,
                                                  crossAxisSpacing: 5.0,
                                                  mainAxisSpacing: 5.0,
                                                ),
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                children: [
                                                  _bottomSheetOptions(
                                                      label: 'Camera',
                                                      icon:
                                                          'assets/camera_colored.png',
                                                      onClicked: () =>
                                                          selectedItem(
                                                              context, 0)),
                                                  _bottomSheetOptions(
                                                      label: 'Gallery',
                                                      icon:
                                                          'assets/gallery.png',
                                                      onClicked: () =>
                                                          selectedItem(
                                                              context, 1)),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    isLoading
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : Center(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.green),
                              child: const Text('Add Product'),
                              onPressed: () async {
                                SystemChannels.textInput
                                    .invokeMethod('TextInput.hide');

                                SharedPreferences prefs =
                                    await SharedPreferences.getInstance();

                                createOrder();
                              },
                            ),
                          ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void createOrder() async {
    FormData formData = FormData.fromMap({
      "name": name.text,
      "description": description.text,
      "price": price.text,
      "offer_price": offerPrice.text,
      "type": "product",
      "image": await MultipartFile.fromFile(imageFile!.path,
          filename: imageFile!.path.split('/').last),
    });

    SystemChannels.textInput.invokeMethod('TextInput.hide');

    setState(() {
      isLoading = true;
    });
    await SellerServices.sellerAddProduct(
      data: formData,
    ).then((value) {
      // print(value.data);
      if (value.statusCode == 200) {
        setState(() {
          isLoading = false;
        });

        ref.refresh(sellerProductProvider);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.green,
            content: Text("Order Created Successfully"),
          ),
        );

        Navigator.pop(context);
      } else {
        setState(() {
          isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.red,
            content: Text("Credential not Match"),
          ),
        );
      }
    }, onError: (er, e) {
      setState(() {
        isLoading = false;
      });
      print(e);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text(er.toString()),
        ),
      );
    });
  }

  _openGallery(BuildContext context) async {
    final _picker = ImagePicker();
    final pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 40,
      maxHeight: 200,
      maxWidth: 200,
    );
    final File file = File(pickedFile!.path);

    setState(() {
      imageFile = file;
    });
  }

  _openCamera(BuildContext context) async {
    final _picker = ImagePicker();
    final pickedFile = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 40,
        maxHeight: 200,
        maxWidth: 200,
        preferredCameraDevice: CameraDevice.rear);
    final File file = File(pickedFile!.path);
    setState(() {
      imageFile = file;
    });
    // Navigator.of(context).pop();
  }

  selectedItem(BuildContext context, int index) {
    // Navigator.of(context).pop();
    switch (index) {
      case 0:
        _openCamera(context);
        Navigator.of(context).pop();
        break;
      case 1:
        _openGallery(context);
        Navigator.of(context).pop();
        break;
    }
  }
}

Widget _bottomSheetOptions({
  required String? label,
  required String icon,
  VoidCallback? onClicked,
}) {
  return SizedBox(
    width: 120,
    height: 120,
    child: GestureDetector(
      onTap: onClicked,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            icon,
            width: 50,
            height: 50,
          ),
          Text(
            label!,
            style: const TextStyle(color: Colors.black),
          ),
        ],
      ),
    ),
  );
}
