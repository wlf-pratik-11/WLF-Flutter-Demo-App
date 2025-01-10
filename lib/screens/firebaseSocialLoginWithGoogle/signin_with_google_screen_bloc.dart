import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:main_app_demo/commons/my_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SigninWithGoogleScreenBloc {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignin = GoogleSignIn();
  var user;

  Future<UserCredential?> signinWithGoogle(BuildContext context) async {
    try {
      final googleUser = await _googleSignin.signIn();
      final googleAuth = await googleUser?.authentication;
      final cred = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      final prefs = await SharedPreferences.getInstance();
      prefs.setString("name", googleUser?.displayName ?? "White Label Fox");
      prefs.setString("email", googleUser?.email ?? "wlfpratiktank@gmaol.com");
      prefs.setString(
          "image",
          googleUser?.photoUrl ??
              "https://media.licdn.com/dms/image/v2/C560BAQHyHE_cbVGa4A/company-logo_200_200/company-logo_200_200/0/1630666191516/whitelabelfox_logo?e=2147483647&v=beta&t=oaefFKsMGp9KThjiyuMCSl8T1Ki5i1GKm93w2pqYDS8");
      return await _auth.signInWithCredential(cred).then(
        (value) {
          final snakBar = SnackBar(
            content: Text(
              "${googleUser!.displayName} login successfully..!!",
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            backgroundColor: MyColors.darkBlue,
          );
          ScaffoldMessenger.of(context).showSnackBar(snakBar);
          Navigator.pop(context);
          return null;
        },
      );
    } catch (e) {
      print("signInWithCredential ===========================>>>>>>>>>>>>>>>>${e.toString()}");
      ;
    }
    return null;
  }

  Future<void> signOut() async {
    try {
      await _googleSignin.signOut();
      final prefs = await SharedPreferences.getInstance();
      prefs.clear();
    } catch (e) {
      print(e.toString());
    }
  }
}
