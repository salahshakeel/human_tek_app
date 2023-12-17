import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:human_tek_app/controllers/auth/auth_controller.dart';

import '../screens/auth/signin_screen.dart';

class AppbarWidget extends StatelessWidget {
  final bool? isLogout;
  const AppbarWidget({super.key, this.isLogout = false});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      foregroundColor: Colors.amber,
      actions: [
        isLogout == true
            ? IconButton(
                onPressed: () {
                  AuthController().signout();
                },
                icon: Icon(Icons.login_outlined),
              )
            : Container()
      ],
    );
  }
}
