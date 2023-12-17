import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:human_tek_app/screens/auth/signup_screen.dart';
import 'package:human_tek_app/screens/auth/verify_email_screen.dart';
import 'package:human_tek_app/screens/payment_screen.dart';
import 'package:human_tek_app/widgets/textfeild_widget.dart';

import '../../controllers/auth/auth_controller.dart';
import '../../widgets/appbar_widget.dart';
import '../../widgets/card_header_widget.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
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
              height: MediaQuery.of(context).size.height / 1.3,
              width: MediaQuery.of(context).size.width / 1.3,
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CardHeaderWidget(
                    text: "Sign In",
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
                                },
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  TextFeildWidget(
                                      hintText: "Password",
                                      prefix_icon: Icons.lock,
                                      obscureText: true,
                                      controller: authController.password,
                                      validator: (p0) {
                                        if (p0!.isEmpty) {
                                          return "Please enter password";
                                        } else if (p0.length < 6) {
                                          return "Password must be at least 6 characters";
                                        }
                                        return null;
                                      }),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8),
                                    child: GestureDetector(
                                      onTap: () {
                                        Get.to(
                                          VerifyEmailScreen(),
                                          transition: Transition.fade,
                                          duration: Duration(seconds: 1),
                                          curve: Curves.easeIn,
                                        );
                                      },
                                      child: Text(
                                        "Forgot Password?",
                                        style: TextStyle(
                                          fontSize: 12,
                                          decoration: TextDecoration.underline,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Container(
                                padding: EdgeInsets.only(top: 20),
                                width: 150,
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (authController.isLoading.value ==
                                        true) {
                                      return;
                                    } else {
                                      if (key.currentState!.validate()) {
                                        authController.signin();
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
                                              'Sign In',
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
                                    Get.to(
                                      SignUpScreen(),
                                      transition: Transition.fade,
                                      duration: Duration(seconds: 1),
                                      curve: Curves.easeIn,
                                    );
                                  },
                                  child: Text(
                                    "Create an account",
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
