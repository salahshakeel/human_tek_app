import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:human_tek_app/controllers/auth/auth_controller.dart';
import 'package:human_tek_app/screens/auth/signin_screen.dart';
import 'package:human_tek_app/widgets/card_header_widget.dart';
import 'package:human_tek_app/widgets/error_alert_box_widget.dart';
import 'package:human_tek_app/widgets/success_alert_box_widget.dart';
import 'package:human_tek_app/widgets/textfeild_widget.dart';

import '../../widgets/appbar_widget.dart';
import '../payment_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final AuthController authController = Get.put(AuthController());
  final key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: AppbarWidget(),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Center(
            child: Container(
              height: MediaQuery.of(context).size.height / 1.4,
              width: MediaQuery.of(context).size.width / 1.3,
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CardHeaderWidget(
                    text: "Sign Up",
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Form(
                        key: key,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              TextFeildWidget(
                                  hintText: "Email",
                                  prefix_icon: Icons.email,
                                  controller: authController.email,
                                  validator: (p0) {
                                    if (p0!.isEmpty) {
                                      return "Please enter email";
                                    } else if (!GetUtils.isEmail(p0)) {
                                      return "Please enter valid email";
                                    }
                                    return null;
                                  }),
                              TextFeildWidget(
                                hintText: "Password",
                                prefix_icon: Icons.lock,
                                controller: authController.password,
                                obscureText: true,
                                validator: (p0) {
                                  if (p0!.isEmpty) {
                                    return "Please enter password";
                                  } else if (p0.length < 6) {
                                    return "Password must be at least 6 characters";
                                  }
                                  return null;
                                },
                              ),
                              Container(
                                width: 150,
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (authController.isLoading.value ==
                                        true) {
                                      return;
                                    } else {
                                      if (key.currentState!.validate()) {
                                        authController.signup();
                                        authController.email.clear();
                                        authController.password.clear();
                                      }
                                    }
                                  },
                                  child:
                                      Obx((() => authController.isLoading.value
                                          ? Container(
                                              height: 20,
                                              width: 20,
                                              child: CircularProgressIndicator(
                                                color: Colors.amber,
                                                strokeWidth: 2,
                                              ))
                                          : Text(
                                              'Sign Up',
                                              style: TextStyle(
                                                  color: Colors.amber),
                                            ))),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.black,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    SizedBox(
                                      height: 10,
                                      width: MediaQuery.of(context).size.width /
                                          1.5,
                                      child: Divider(color: Colors.grey),
                                    ),
                                    Container(
                                      height: 20,
                                      width: 50,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.black,
                                      ),
                                      child: Center(
                                        child: Text(
                                          "Or",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.amber,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                  onTap: () {
                                    Get.back();
                                  },
                                  child: Text(
                                    "Already have an account?",
                                    style: TextStyle(
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                              )
                            ])),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
