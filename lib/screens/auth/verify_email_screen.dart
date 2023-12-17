import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:human_tek_app/screens/auth/signup_screen.dart';
import 'package:human_tek_app/screens/payment_screen.dart';
import 'package:human_tek_app/widgets/textfeild_widget.dart';

import '../../controllers/auth/auth_controller.dart';
import '../../widgets/appbar_widget.dart';
import '../../widgets/card_header_widget.dart';

class VerifyEmailScreen extends StatefulWidget {
  const VerifyEmailScreen({super.key});

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  final key = GlobalKey<FormState>();

  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: AppbarWidget(),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: Container(
              height: MediaQuery.of(context).size.height / 2,
              width: MediaQuery.of(context).size.width / 1.3,
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CardHeaderWidget(
                    text: "Verify Email",
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
                                  } else if (!GetUtils.isEmail(
                                      authController.email.text)) {
                                    return "Please enter valid email";
                                  }
                                  return null;
                                },
                              ),
                              Container(
                                padding: EdgeInsets.only(top: 5),
                                width: 150,
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (authController.isLoading == true) {
                                      return;
                                    } else {
                                      if (key.currentState!.validate()) {
                                        authController.resetPassword();
                                        authController.email.clear();
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
                                              'Verify',
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
                            ])),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
