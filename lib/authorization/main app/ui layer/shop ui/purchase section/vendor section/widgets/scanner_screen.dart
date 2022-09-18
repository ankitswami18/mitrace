// import 'package:flutter/material.dart';
// import 'package:mitrace/authorization/create%20account/create%20account%20vendor/data%20layer/vendor_account_repository.dart';
// import 'package:mitrace/authorization/create%20account/create%20account%20vendor/data%20layer/vendor_profile_model.dart';
// import 'package:mitrace/authorization/main%20app/ui%20layer/shop%20ui/shop_main_screen.dart';
// import 'package:provider/provider.dart';

// class ScannerScreen extends StatefulWidget {
//   const ScannerScreen({Key? key}) : super(key: key);

//   @override
//   State<ScannerScreen> createState() => _ScannerScreenState();
// }

// class _ScannerScreenState extends State<ScannerScreen> {
//   @override
//   Widget build(BuildContext context) {
//     final repObj = Provider.of<VendorAccountRepository>(context, listen: false);
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text('Scan and Pay'),
//         ),
//         body: StreamBuilder<VendorProfileModel>(
//           stream:
//               repObj.streamVendorProfileModel(userId: vendorProfileModel!.id),
//           builder: ((context, AsyncSnapshot<VendorProfileModel> snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return const Center(
//                 child: CircularProgressIndicator(),
//               );
//             }
//             return snapshot.data!.qrcodePhoto != null
//                 ? Column(
//                     crossAxisAlignment: CrossAxisAlignment.stretch,
//                     children: [
//                       Card(
//                         child: Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Column(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               Image.network(
//                                   snapshot.data!.qrcodePhoto as String),
//                               Text(
//                                 'Make a payment to: ${snapshot.data!.name}',
//                                 style: const TextStyle(
//                                   fontSize: 18,
//                                 ),
//                               ),
//                               const Padding(
//                                 padding: EdgeInsets.all(8.0),
//                                 child: Text('Scan To Pay'),
//                               )
//                             ],
//                           ),
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: ElevatedButton(
//                           onPressed: () {
//                             Navigator.pop(context);
//                           },
//                           child: const Text('Done'),
//                         ),
//                       )
//                     ],
//                   )
//                 : const Card(
//                     child: Padding(
//                       padding: EdgeInsets.all(8.0),
//                       child: Padding(
//                         padding: EdgeInsets.all(8.0),
//                         child:
//                             Text('Upload Scaner Image In The Profile Screen'),
//                       ),
//                     ),
//                   );
//           }),
//         ),
//       ),
//     );
//   }
// }
