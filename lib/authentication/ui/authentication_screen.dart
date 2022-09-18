import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mitrace/authorization/create%20account/create%20account%20customer/data%20layer/create_account_repository.dart';
import 'package:mitrace/authorization/create%20account/create%20account%20vendor/data%20layer/vendor_account_repository.dart';
import 'package:mitrace/authorization/main%20app/data%20layer/refrences_objects.dart';
import 'package:provider/provider.dart';
import '../auth.dart';
import 'auth_initial_screen.dart';

class RegistrationForm extends StatefulWidget {
  const RegistrationForm(
      {Key? key,
      required this.registrationActivityText,
      required this.authType})
      : super(key: key);
  final String registrationActivityText;
  final AuthType authType;
  @override
  // ignore: library_private_types_in_public_api
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  String get email => emailController.text;
  String get password => passwordController.text;
  bool emailCheck = false;
  bool passwordCheck = false;

  storeUserDetailsInFirebase() {
    if (widget.authType == AuthType.customer) {
      userTypeRef.doc(FirebaseAuthApi().currentUser() as String).set({
        'id': FirebaseAuthApi().currentUser() as String,
        'type': 'customer',
      });
      final repObj =
          Provider.of<CustomerAccountRepository>(context, listen: false);
      repObj.createCustomer(id: FirebaseAuthApi().currentUser() as String);
    } else if (widget.authType == AuthType.vendor) {
      userTypeRef.doc(FirebaseAuthApi().currentUser() as String).set({
        'id': FirebaseAuthApi().currentUser() as String,
        'type': 'vendor',
      });
      final repObj =
          Provider.of<VendorAccountRepository>(context, listen: false);
      repObj.createVendor(id: FirebaseAuthApi().currentUser() as String);
    }
  }

  Future<void> _resetPasswordPopup(var s) {
    return showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          // title: Text('Reset Password'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(s),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              //  textColor: Colors.blueAccent,
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  _resetPasswordLink(BuildContext context) async {
    late String s;
    final auth = Provider.of<FirebaseAuthApi>(context, listen: false);
    try {
      await auth.resetPasswordUsingEmail(emailController.text);
      s = 'Reset link sent to mail id.';
    } catch (e) {
      s = e.toString();
    } finally {
      _resetPasswordPopup(s);
    }
  }

  Future<void> signIn(BuildContext context) async {
    final auth = Provider.of<FirebaseAuthApi>(context, listen: false);
    try {
      await auth.signInWithEmailAndPassword(
        emailController.text,
        passwordController.text,
      );
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text(e.message.toString()),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('ok'),
                ),
              ],
            );
          });
    }
  }

  void signUp(BuildContext context) async {
    final auth = Provider.of<FirebaseAuthApi>(context, listen: false);
    late String s;
    try {
      await auth.signUpWithEmailAndPassword(email, password);
      storeUserDetailsInFirebase();
      s = 'verification link sent to mail Id.';
    } on FirebaseAuthException catch (e) {
      s = e.message.toString();
    } finally {
      if (widget.authType == AuthType.customer) {
        // Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(
        //       builder: (context) => CreateCustomerProfileScreen.create()),
        // );
        Navigator.pop(context);
      } else if (widget.authType == AuthType.vendor) {
        // Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(
        //       builder: (context) => CreateVendorProfileScreen.create()),
        // );
        Navigator.pop(context);
      }

      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(s),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('ok'),
              ),
            ],
          );
        },
      );
    }
  }

  Widget activateFlatButtonToResetPassword() {
    if ('Sign In' == widget.registrationActivityText) {
      return TextButton(
        child: const Text('Forgot password? Reset it'),
        onPressed: () => activateResetPasswordButton(context),
      );
    } else {
      return const Text('Welcome');
    }
  }

  activateResetPasswordButton(BuildContext context) {
    if (email.isNotEmpty) {
      _resetPasswordLink(context);
    } else {
      setState(() {
        emailCheck = true;
        passwordCheck = false;
      });
    }
  }

  activateSignInButton(BuildContext context) {
    if (email.isNotEmpty && password.isNotEmpty) {
      if ('Sign In' == widget.registrationActivityText) {
        signIn(context);
      } else {
        signUp(context);
      }
    } else if (email.isEmpty && password.isEmpty) {
      setState(() {
        emailCheck = true;
        passwordCheck = true;
      });
    } else {
      if (email.isEmpty) {
        setState(() {
          emailCheck = true;
          passwordCheck = false;
        });
      } else {
        setState(() {
          passwordCheck = true;
          emailCheck = false;
        });
      }
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(' '),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          labelText: 'Email',
                          hintText: 'Enter Email Id',
                          errorText: emailCheck ? "Email can't be empty" : null,
                          icon: const Icon(Icons.email)),

                      controller: emailController,
                      onChanged: (email) {
                        setState(() {
                          emailCheck = false;
                        });
                      },
                      autocorrect: false,
                      textInputAction: TextInputAction.next,
                      focusNode: _emailFocusNode,
                      onEditingComplete: () =>
                          FocusScope.of(context).requestFocus(
                        _passwordFocusNode,
                      ), // This function will be exequited when next (on the keyboad) is pressed.
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    TextField(
                      decoration: InputDecoration(
                        icon: const Icon(Icons.remove_red_eye),
                        labelText: 'Password',
                        hintText: 'Enter password',
                        errorText:
                            passwordCheck ? "password can't be empty" : null,
                      ),
                      controller: passwordController,
                      onChanged: (password) {
                        setState(() {
                          passwordCheck = false;
                        });
                      },
                      obscureText: true,
                      textInputAction: TextInputAction.done,
                      focusNode: _passwordFocusNode,
                      onEditingComplete:
                          widget.registrationActivityText == 'Sign In'
                              ? () => signIn(context)
                              : () => signUp(context),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    activateFlatButtonToResetPassword(),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          widget.registrationActivityText,
                          style: const TextStyle(
                            fontSize: 30,
                          ),
                        ),
                      ),
                      onPressed: () => activateSignInButton(context),
                    ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
