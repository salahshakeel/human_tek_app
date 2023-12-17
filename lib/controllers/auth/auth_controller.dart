import 'dart:ffi';

import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../screens/auth/signin_screen.dart';
import '../../screens/payment_screen.dart';
import '../../widgets/error_alert_box_widget.dart';
import '../../widgets/success_alert_box_widget.dart';

class AuthController extends GetxController {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  var isLoading = false.obs;

  Future<void> signup() async {
    try {
      isLoading.value = true;
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: email.text, password: password.text);

      if (userCredential.user != null) {
        isLoading.value = false;
        Get.dialog(
            SuccessAlertBoxWidget(message: "Account created successfully"));
        Get.offAll(
          PaymentScreen(),
          transition: Transition.fade,
          duration: Duration(seconds: 1),
          curve: Curves.easeIn,
        );
      }
    } on FirebaseAuthException catch (e) {
      isLoading.value = false;
      if (e.code == 'weak-password') {
        Get.dialog(ErrorAlertBoxWidget(message: "Password is too weak"));
      } else if (e.code == 'email-already-in-use') {
        Get.dialog(ErrorAlertBoxWidget(message: "Email already in use"));
      }
    } catch (e) {
      isLoading.value = false;
      print(e);
      Get.dialog(ErrorAlertBoxWidget(message: e.toString()));
    }
  }

  Future<void> signin() async {
    try {
      isLoading.value = true;
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: email.text, password: password.text);

      if (userCredential.user != null) {
        isLoading.value = false;
        Get.dialog(SuccessAlertBoxWidget(
          message: "Sign in successful",
        ));
        Get.offAll(
          PaymentScreen(),
          transition: Transition.fade,
          duration: Duration(seconds: 1),
          curve: Curves.easeIn,
        );
      }
    } on FirebaseAuthException catch (e) {
      isLoading.value = false;
      if (e.code == 'user-not-found') {
        Get.dialog(
            ErrorAlertBoxWidget(message: "No user found for that email."));
      } else if (e.code == 'wrong-password') {
        Get.dialog(ErrorAlertBoxWidget(
            message: "Wrong password provided for that user."));
      }
    } catch (e) {
      isLoading.value = false;
      ErrorAlertBoxWidget(message: e.toString());
    }
  }

  Future<void> resetPassword() async {
    try {
      isLoading.value = true;
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email.text);
      Get.dialog(SuccessAlertBoxWidget(
        message: "Password reset email sent",
      ));
      isLoading.value = false;
    } on FirebaseAuthException catch (e) {
      isLoading.value = false;
      Get.dialog(ErrorAlertBoxWidget(message: e.toString()));
    }
  }

  Future<void> signout() async {
    await FirebaseAuth.instance.signOut();
    Get.offAll(
      SignInScreen(),
      transition: Transition.fade,
      duration: Duration(seconds: 1),
      curve: Curves.easeIn,
    );
  }
}
