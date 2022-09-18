import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthApi {
  String? _userFromFirebase(User? user) {
    if (user == null) {
      return null;
    } else {
      return user.uid;
    }
  }

  bool isSignedIn() {
    var currentUser = FirebaseAuth.instance.currentUser;
    return currentUser != null;
  }

  String? currentUser() {
    final User? user = FirebaseAuth.instance.currentUser;
    return _userFromFirebase(user);
  }

  //? Functions Related to email and password firebase

  signUpWithEmailAndPassword(String email, String password) async {
    try {
      final authResult = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      User? user = authResult.user;
      await user?.sendEmailVerification();
      return _userFromFirebase(authResult.user);
    } catch (e) {
      rethrow;
    }
  }

  Future<String?> signInWithEmailAndPassword(
      String email, String password) async {
    final authResult = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    return _userFromFirebase(authResult.user);
  }

  Future<void> resetPasswordUsingEmail(String email) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }

  Future<void> resetPasswordUsingApp(String newPassword) async {
    final User? user = FirebaseAuth.instance.currentUser;
    user?.updatePassword(newPassword);
  }

  Stream<String?> get onAuthStateChange {
    return FirebaseAuth.instance.authStateChanges().map(_userFromFirebase);
    // authStateChanges() recives a Stream of (firebaseUser's) User each time the user signin or signOut;
  }

  Future<void> sendEmailVerificationCodeAuthentication() async {
    await FirebaseAuth.instance.currentUser!.sendEmailVerification();
  }

  verifyEmailWithCode(String code) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    try {
      await auth.checkActionCode(code);
      await auth.applyActionCode(code);
      auth.currentUser!.reload();
    } catch (e) {
      rethrow;
    }
  }

  //? FUNCTIONS RELATED TO ANONYMOUS AUTHENTICATION.

  Future<String?> signInAnonymously() async {
    final authResult = await FirebaseAuth.instance.signInAnonymously();
    return _userFromFirebase(authResult.user);
  }

  //? SIGN-OUT FUNCTION.

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
