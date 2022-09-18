import 'package:flutter/material.dart';
import 'authentication_screen.dart';

enum AuthType {
  customer,
  vendor,
  none,
}

class AuthScreen extends StatefulWidget {
  const AuthScreen({required this.authType, Key? key}) : super(key: key);
  final AuthType authType;

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  navigateToAuthenticate(BuildContext context, String title) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => RegistrationForm(
          registrationActivityText: title,
          authType: widget.authType,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 5, 78, 138),
      body: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(60.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Column(
                  children: const [
                    Padding(
                      padding: EdgeInsets.all(18.0),
                      child: ColorFiltered(
                        colorFilter: ColorFilter.mode(
                          Color.fromARGB(255, 5, 78, 138),
                          BlendMode.color,
                        ),
                        child: Image(
                          image: AssetImage(
                            'assets/logo/mi_image.png',
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(14.0),
                      child: Center(
                        child: Text(
                          "XIAOMI WELCOME'S YOU",
                          style: TextStyle(
                            color: Colors.white,
                            // fontSize: 30,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        'Have an account?',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      ElevatedButton(
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Sign In',
                            style: TextStyle(
                              fontSize: 30,
                            ),
                          ),
                        ),
                        onPressed: () {
                          navigateToAuthenticate(context, 'Sign In');
                        },
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      const Text(
                        'Create an account?',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          navigateToAuthenticate(context, 'Sign Up');
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Sign Up',
                            style: TextStyle(
                              fontSize: 30,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
