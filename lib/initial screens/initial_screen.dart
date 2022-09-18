import 'package:flutter/material.dart';
import 'package:mitrace/authentication/ui/auth_initial_screen.dart';
import 'package:mitrace/authorization/main%20app/ui%20layer/shop%20ui/shop_main_screen.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({Key? key}) : super(key: key);

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  getMiLogo() {
    return Column(
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
              'WELCOME',
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 5, 78, 138),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          getMiLogo(),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  child: const Text('Customer'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const AuthScreen(authType: AuthType.customer),
                      ),
                    );
                  },
                ),
                ElevatedButton(
                  child: const Text('Vendor'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const AuthScreen(authType: AuthType.vendor),
                      ),
                    );
                  },
                ),
                ElevatedButton(
                  child: const Text('Skip! Sign-In'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ShopMainScreen.create(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          const Center(
            child: Text(
              'Xiaomi Inc.',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
