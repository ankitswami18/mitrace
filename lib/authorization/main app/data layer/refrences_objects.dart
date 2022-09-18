import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

final storageRef = FirebaseStorage.instance.ref();
final vendorProfileRef = FirebaseFirestore.instance.collection('VendorProfile');
final customerProfileRef =
    FirebaseFirestore.instance.collection('CustomerProfile');
final paymentRef = FirebaseFirestore.instance.collection('PaymentDetails');
final userTypeRef = FirebaseFirestore.instance.collection('userTypeRef');
