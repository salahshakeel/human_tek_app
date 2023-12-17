import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:human_tek_app/screens/payment_screen.dart';

import 'auth/signin_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final isLoading = false.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: Align(
                alignment: Alignment.center,
                child: Image.asset(
                    "././assets/images/logo.png",),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 50),
              child: ElevatedButton(
                onPressed: isLoading.value
                    ? null
                    : () async {
                        try {
                          isLoading.value = true;
                          await Future.delayed(Duration(seconds: 2));

                          Get.off(
                            SignInScreen(),
                            transition: Transition.fade,
                            duration: Duration(seconds: 1),
                            curve: Curves.easeIn,
                          );

                          
                        } finally {
                          isLoading.value = false;
                        }
                      },
                child: Obx(() => isLoading.value
                    ? Container(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          color: Colors.amber,
                          strokeWidth: 2,
                        ))
                    : Text(
                        'Get Started',
                        style: TextStyle(color: Colors.amber),
                      )),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: Colors.amber,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
