import 'package:flutter/material.dart';
import 'package:mitrace/authentication/auth.dart';
import 'package:mitrace/initial%20screens/initial_screen.dart';
import 'package:provider/provider.dart';
import '../authorization/authorization_direction.dart';

class AuthenticationDirection extends StatelessWidget {
  const AuthenticationDirection({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    FirebaseAuthApi authDataProvider =
        Provider.of<FirebaseAuthApi>(context, listen: false);
    return StreamBuilder<String?>(
      stream: authDataProvider.onAuthStateChange,
      builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.data == null || !snapshot.hasData) {
            return const InitialScreen();
          } else {
            return const AuthorisationDirection();
          }
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
