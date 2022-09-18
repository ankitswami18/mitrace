import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mitrace/initial%20screens/authentication_direction.dart';
import 'package:mitrace/initial%20screens/repositories_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: ((context, AsyncSnapshot<Object?> snapshot) {
        if (snapshot.hasError) {
          return const MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Center(
              child: Text('Firebase Error'),
            ),
          );
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        return const RepositoriesProvider(
          myMaterialApp: MaterialApp(
            debugShowCheckedModeBanner: false,
            home: AuthenticationDirection(),
          ),
        );
      }),
    );
  }
}

// ANDROID + IOS + WINDOWS + WEB.



// CREATE ACCOUNT SCREEN
// SHOPPING SCREENS
// ADD PRODUCT TO CART BY THE CUSTOMER
// BILL IT.