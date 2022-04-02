import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../utils/loader/loader_class.dart';
import 'package:http/http.dart' as http;
import '../../utils/shared/const.dart';
import '../../utils/shared/snackbar.dart';
import '../../utils/shared/storage_prefs.dart';
import '../provider/provider.dart';

class LoginController extends GetxController {
  @override
  void onInit() async {}
  AuthApiProvider provider = AuthApiProvider();
  var isSubmitButtonEnabled = false.obs;
  final validation = true.obs;

  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();

  GlobalKey<FormFieldState> emailFormKey = GlobalKey<FormFieldState>();
  GlobalKey<FormFieldState> passwordFormKey = GlobalKey<FormFieldState>();

  bool isLoginFormValid() {
    return ((emailFormKey.currentState!.isValid &&
        passwordFormKey.currentState!.isValid));
  }

  submit({required BuildContext context}) {
    login(context: context);
  }

  login({required BuildContext context}) async {
    try {
      http.Response response = await provider.login(email: email.text.toString(), password: password.text.toString());
      print(response.body);
      var jsonData = jsonDecode(response.body);
      if ( jsonData["message"] == "success") {
        await StoragePrefs.gs.write(StorageConstants.token, jsonData["token"].toString());
        Get.snackbar(
          'Success',
          'Login Done',
          snackPosition: SnackPosition.BOTTOM
        );


      }
    }
    on Exception {
      Loader.dismissLoading();
      Get.snackbar(
        "Faild Login",
        "Something wrong",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
