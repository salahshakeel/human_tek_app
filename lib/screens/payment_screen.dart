import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:human_tek_app/controllers/auth/auth_controller.dart';
import 'package:human_tek_app/controllers/auth/payment_controller.dart';
import 'package:human_tek_app/screens/auth/signin_screen.dart';

import '../widgets/appbar_widget.dart';
import '../widgets/card_header_widget.dart';
import '../widgets/textfeild_widget.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  PaymentController paymentController = Get.put(PaymentController());
  final key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: AppbarWidget(
            isLogout: true,
          ),
        ),
        body: SafeArea(
          child: Container(
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
                      text: "Make Payment",
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Form(
                          key: key,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                TextFeildWidget(
                                  hintText: "Amount",
                                  validator: (p0) {
                                    if (p0!.isEmpty) {
                                      return "Please enter amount";
                                    }
                                    return null;
                                  },
                                  prefix_icon: Icons.monetization_on,
                                  controller: paymentController.amount,
                                  keyboardType: TextInputType.number,
                                ),
                                Container(
                                  width: 150,
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      if (paymentController.isLoading.value ==
                                          true) {
                                        return;
                                      } else {
                                        if (key.currentState!.validate()) {
                                          paymentController.makePayment();
                                          paymentController.amount.clear();
                                        }
                                      }
                                    },
                                    child: Obx((() => paymentController
                                            .isLoading.value
                                        ? Container(
                                            height: 20,
                                            width: 20,
                                            child: CircularProgressIndicator(
                                              color: Colors.amber,
                                              strokeWidth: 2,
                                            ))
                                        : Text(
                                            'Pay',
                                            style:
                                                TextStyle(color: Colors.amber),
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
          ),
        ));
  }
}
