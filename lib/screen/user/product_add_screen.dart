// import 'dart:io';
//
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../../widgets/custom_text_field.dart';
//
// class SellerProductAddScreen extends StatefulWidget {
//   const SellerProductAddScreen({Key? key}) : super(key: key);
//
//   @override
//   State<SellerProductAddScreen> createState() => _SellerProductAddScreenState();
// }
//
// enum ProductType { product, service , initial}
//
// class _SellerProductAddScreenState extends State<SellerProductAddScreen> {
//   File? imageFile;
//
//   bool isLoading = false;
//   TextEditingController name = TextEditingController();
//   TextEditingController description = TextEditingController();
//
//   TextEditingController price = TextEditingController();
//   TextEditingController offerPrice = TextEditingController();
//
//   ProductType productType = ProductType.initial;
//
//   @override
//   void initState() {
//     super.initState();
//     check();
//   }  final _formKey = GlobalKey<FormState>();
//
//
//   void check() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//
//     print(prefs.get("sellerToken"));
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // check();
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           centerTitle: true,
//           title: const Text("Product Add Screen"),
//         ),
//         body: Container(
//           margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//           child: Column(
//             children: [
//
//
//               Form(
//                 key: _formKey,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//
//                     const SizedBox(
//                       height: 40,
//                     ),
//                     CustomTextField(
//                       controller: name,
//                       labelName: 'Product Name',
//                       hintTextName: 'Enter Product Name',
//                       textInputType: TextInputType.number,
//
//                       validateFunction: (value) {},
//                     ),
//                     const SizedBox(
//                       height: 40,
//                     ),
//                     CustomTextField(
//                       controller: description,
//                       labelName: 'Product Description',
//                       hintTextName: 'Enter Product Description',
//                       textInputType: TextInputType.visiblePassword,
//
//                     ),
//                     const SizedBox(
//                       height: 40,
//                     ),
//                     CustomTextField(
//                       controller: price,
//                       labelName: 'Price',
//                       hintTextName: 'Enter price amount',
//                       textInputType: TextInputType.visiblePassword,
//
//                     ),
//
//
//                     const SizedBox(
//                       height: 40,
//                     ),
//                     CustomTextField(
//                       controller: offerPrice,
//                       labelName: 'Discount Price',
//                       hintTextName: 'Enter discount price',
//                       textInputType: TextInputType.visiblePassword,
//
//                     ),
//                     const SizedBox(
//                       height: 40,
//                     ),
//                     const Text(
//                       "Type",
//                       style: TextStyle(
//                           color: Colors.black,
//                           fontWeight: FontWeight.w700,
//                           fontSize: 16),
//                     ),
//                     FittedBox(
//                       child: Row(
//                         children: [
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             // crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               Radio(
//                                 value: ProductType.product,
//                                 groupValue:productType,
//                                 activeColor: Colors.green,
//                                 onChanged: (ProductType? value) {
//                                   setState(() {
//                                     productType = value!;
//                                     // _radioVal = 'isEmail';
//                                     //   print(_radioVal);
//                                   });
//                                 },
//                               ),
//                               const Text(
//                                 "Product",
//                                 style: TextStyle(
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.w500),
//                               ),
//                             ],
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             // crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               Radio(
//                                 value: ProductType.service,
//                                 groupValue: productType,
//                                 activeColor: Colors.green,
//                                 onChanged: (ProductType? value) {
//                                   setState(() {
//                                     productType = value!;
//                                   });
//                                 },
//                               ),
//                               Text(
//                                 "Service",
//                                 style: TextStyle(
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.w500),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//
//
//
//
//
//                     const SizedBox(
//                       height: 40,
//                     ),
//                     isLoading
//                         ? const Center(
//                       child: CircularProgressIndicator(),
//                     )
//                         :   ElevatedButton(
//                       style:
//                       ElevatedButton.styleFrom(primary: Colors.green),
//                       child: const Text('LOG IN'),
//                       onPressed: () async {
//                         setState(() {
//                           isLoading = true;
//                         });SystemChannels.textInput.invokeMethod('TextInput.hide');
//
//                         SharedPreferences prefs =
//                         await SharedPreferences.getInstance();
//
//                         // await UserServices.userLogin(
//                         //
//                         //     mobile: mobile.text,
//                         //     password: password.text)
//                         //     .then((value) {
//                         //   setState(() {
//                         //     isLoading = false;
//                         //   });
//                         //   if (value.statusCode == 200) {
//                         //     prefs.setString(
//                         //         "userToken", value.data['token']);
//                         //
//                         //     ScaffoldMessenger.of(context).showSnackBar(
//                         //       const SnackBar(
//                         //         backgroundColor: Colors.green,
//                         //         content: Text(
//                         //             "User Registration Successfully"),
//                         //       ),
//                         //     );
//                         //
//                         //     Navigator.push(
//                         //       context,
//                         //       MaterialPageRoute(
//                         //         builder: (context) =>
//                         //         const UserHomeScreen(),
//                         //       ),
//                         //     );
//                         //   }
//                         // }, onError: (e, stackTrace) {
//                         //   print(e.toString());
//                         //   setState(() {
//                         //     isLoading = false;
//                         //   });
//                         //
//                         //   ScaffoldMessenger.of(context).showSnackBar(
//                         //     SnackBar(
//                         //       backgroundColor: Colors.red,
//                         //       content: Text(e.toString()),
//                         //     ),
//                         //   );
//                         // });
//
//                         // Navigator.pushNamed(
//                         //   context,
//                         //   RouteConstants.homeScreen,
//                         // ); //  if (_formKey.currentState!.validate()) {}
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   // void updateOrder() async {
//   //   FormData formData =
//   //
//   //   imageFile == null
//   //       ? FormData.fromMap({
//   //     "bill_to": billTo.text,
//   //     "bill_date": issueDate.text,
//   //     "project_name": projectName.text,
//   //     "requisitioned_by": requisitionedBy.text,
//   //     "company_name": companyName.text,
//   //     "other_subs": otherSubs.text,
//   //     "order_type": typesWorkOrder.name.toString(),
//   //     "shift": shift.name.toString(),
//   //     "general_description": generalDescription.text,
//   //     "labor_description": laborDescription.text,
//   //     "materials_description": materialDescription.text,
//   //     "mechanics": totalMechanics.text,
//   //     "mechanics_hours": totalMechanicsHour.text,
//   //     "supervision": totalSupervision.text,
//   //     "supervision_hours": supervisionHour.text,
//   //     "labor": totalLabor.text,
//   //     "labor_hours": laborHour.text,
//   //     "completed_date": completeDate.text,
//   //     "details": "{{10,mechanics,300},{2,labors,300},{1,supervisor,300}}",
//   //
//   //   }):
//   //
//   //   FormData.fromMap({
//   //     "bill_to": billTo.text,
//   //     "bill_date": issueDate.text,
//   //     "project_name": projectName.text,
//   //     "requisitioned_by": requisitionedBy.text,
//   //     "company_name": companyName.text,
//   //     "other_subs": otherSubs.text,
//   //     "order_type": typesWorkOrder.name.toString(),
//   //     "shift": shift.name.toString(),
//   //     "general_description": generalDescription.text,
//   //     "labor_description": laborDescription.text,
//   //     "materials_description": materialDescription.text,
//   //     "mechanics": totalMechanics.text,
//   //     "mechanics_hours": totalMechanicsHour.text,
//   //     "supervision": totalSupervision.text,
//   //     "supervision_hours": supervisionHour.text,
//   //     "labor": totalLabor.text,
//   //     "labor_hours": laborHour.text,
//   //     "completed_date": completeDate.text,
//   //     "details": "{{10,mechanics,300},{2,labors,300},{1,supervisor,300}}",
//   //     "file":  await MultipartFile.fromFile(imageFile!.path,
//   //         filename: imageFile!.path.split('/').last),
//   //   });
//   //
//   //   SystemChannels.textInput.invokeMethod('TextInput.hide');
//   //
//   //   setState(() {
//   //     isLoading = true;
//   //   });
//   //   await ApiServices()
//   //       .updateOrder(data: formData, id: widget.order!.id.toString())
//   //       .then((value) {
//   //     print(value.body);
//   //     if (value.statusCode == 200) {
//   //       setState(() {
//   //         isLoading = false;
//   //       });
//   //
//   //       ref.refresh(allOrderProvider);
//   //       ScaffoldMessenger.of(context).showSnackBar(
//   //         const SnackBar(
//   //           backgroundColor: Colors.green,
//   //           content: Text("Order Created Successfully"),
//   //         ),
//   //       );
//   //
//   //       Navigator.pop(context);
//   //     } else {
//   //       setState(() {
//   //         isLoading = false;
//   //       });
//   //       ScaffoldMessenger.of(context).showSnackBar(
//   //         const SnackBar(
//   //           backgroundColor: Colors.red,
//   //           content: Text("Credential not Match"),
//   //         ),
//   //       );
//   //     }
//   //   }, onError: (er, e) {
//   //     setState(() {
//   //       isLoading = false;
//   //     });
//   //     print(e);
//   //
//   //     ScaffoldMessenger.of(context).showSnackBar(
//   //       SnackBar(
//   //         backgroundColor: Colors.red,
//   //         content: Text(er.toString()),
//   //       ),
//   //     );
//   //   });
//   // }
//
//   _openGallery(BuildContext context) async {
//     final _picker = ImagePicker();
//     final pickedFile = await _picker.pickImage(
//       source: ImageSource.gallery,
//       imageQuality: 40,
//       maxHeight: 200,
//       maxWidth: 200,
//     );
//     final File file = File(pickedFile!.path);
//
//     setState(() {
//       imageFile = file;
//     });
//   }
//
//   _openCamera(BuildContext context) async {
//     final _picker = ImagePicker();
//     final pickedFile = await _picker.pickImage(
//         source: ImageSource.camera,
//         imageQuality: 40,
//         maxHeight: 200,
//         maxWidth: 200,
//         preferredCameraDevice: CameraDevice.rear);
//     final File file = File(pickedFile!.path);
//     setState(() {
//       imageFile = file;
//     });
//     // Navigator.of(context).pop();
//   }
//
//   selectedItem(BuildContext context, int index) {
//     // Navigator.of(context).pop();
//     switch (index) {
//       case 0:
//         _openCamera(context);
//         Navigator.of(context).pop();
//         break;
//       case 1:
//         _openGallery(context);
//         Navigator.of(context).pop();
//         break;
//     }
//   }
// }
//
// Widget _bottomSheetOptions({
//   required String? label,
//   required String icon,
//   VoidCallback? onClicked,
// }) {
//   return SizedBox(
//     width: 120,
//     height: 120,
//     child: GestureDetector(
//       onTap: onClicked,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Image.asset(
//             icon,
//             width: 50,
//             height: 50,
//           ),
//           Text(
//             label!,
//             style: const TextStyle(color: Colors.black),
//           ),
//         ],
//       ),
//     ),
//   );
// }
