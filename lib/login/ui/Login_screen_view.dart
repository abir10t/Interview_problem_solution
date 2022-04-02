import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import '../controller/Login_screen_logic.dart';

class Login extends GetView<LoginController> {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put<LoginController>(LoginController());
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text('Login'),
          ),
          body: Container(
            child: Column(
              children: [
                Center(
                  child: Image(
                    image: AssetImage("assets/images/bug.png"),
                    height: 150,
                    width: 150,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: customTextField(
                    text: 'Email',
                    key: controller.emailFormKey,
                    text_controller: controller.email,
                    onChangedX: (value) {
                      controller.isSubmitButtonEnabled.value =
                          controller.isLoginFormValid();
                      controller.emailFormKey.currentState!.validate();
                    },
                    validatorX: (value) {
                      if (value.isEmpty) {
                        return "*Email is empty";
                      }
                      if (!value.contains('@')) {
                        return "*wrong email address";
                      }
                      if (!value.contains('.')) {
                        return "*wrong email address";
                      }
                      if (controller.validation.value == true) {
                        controller.validation.value =
                            !controller.validation.value;
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: customTextField(
                    text: 'Password',
                    key: controller.passwordFormKey,
                    text_controller: controller.password,
                    onChangedX: (value) {
                      controller.isSubmitButtonEnabled.value =
                          controller.isLoginFormValid();
                      controller.passwordFormKey.currentState!.validate();
                    },
                    validatorX: (value) {
                      if (value.isEmpty) {
                        return '*Password is empty';
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: ElevatedButton(
                    onPressed: () {
                      // if (controller.isSubmitButtonEnabled.isTrue) {
                      //   controller.submit();
                      //   print("hello");
                      // }

                      controller.submit(context: context);
                    },
                    child: Text('Login'),
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 40),
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }

  customTextField({
    required text,
    required Key key,
    required TextEditingController text_controller,
    Function? onChangedX,
    Function? validatorX,
  }) {
    return TextFormField(
        key: key,
        controller: text_controller,
        decoration: InputDecoration(
            hintText: text,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12.0)),
            )));
  }
}
