// ignore_for_file: prefer_final_fields

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Views/auth_screen/signp.dart';
import 'package:flutter_application_1/Views/home_screen/homeScreen.dart';
import 'package:get/get.dart';

import '../../Controller/home_screen_controller.dart';
import '../../Services/user_auth.dart';
import '../../widgets_common/bg_widget.dart';
import '../../widgets_common/button.dart';
import '../../widgets_common/splash_logo.dart';
import '../../widgets_common/txt_field.dart';

class login extends StatefulWidget {
  login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final Authservice auth = Authservice();
  var controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return bg(
      child: Scaffold(
        backgroundColor: Colors.yellow,
        body: Form(
          key: _formKey,
          child: Center(
              child: Padding(
            padding: const EdgeInsets.only(left: 50, right: 50),
            child: Container(
              width: 400,
              height: 500,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey, // Shadow color
                    offset: Offset(
                        0, 2), // Offset of the shadow (horizontal, vertical)
                    blurRadius: 4, // Blur radius of the shadow
                    spreadRadius: 1, // Spread radius of the shadow
                  ),
                ],
              ),
              child: Column(
                children: [
                  logo(),
                  Text(
                    'Login to eMart',
                    style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                  ),
                  Obx(() {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, bottom: 8, top: 8),
                          child: txtField(
                            controller: _emailController,
                            txt: 'Email',
                            val: false,
                            icon: Icons.person,
                            color: const Color.fromARGB(255, 224, 218, 218),
                            brdrcolor: Colors.yellow,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "*required";
                              } else
                                return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, bottom: 8, top: 8),
                          child: txtField(
                            controller: _passController,
                            txt: 'Password',
                            icon: Icons.lock,
                            val: true,
                            color: const Color.fromARGB(255, 224, 218, 218),
                            brdrcolor: Colors.yellow,
                            validator: (value) {
                              // add your custom validation here.
                              if (value!.isEmpty) {
                                return 'Please enter some text';
                              }
                            },
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: TextButton(
                            child: Text(
                              'Forgot Password?',
                              style: TextStyle(
                                fontSize: 11,
                              ),
                            ),
                            onPressed: () {
                              //Navigator.of(context).pop();
                            },
                          ),
                        ),
                        controller.isLoading.value
                            ? CircularProgressIndicator()
                            : button(
                                onPress: () {
                                  if (_formKey.currentState!.validate()) {
                                    _signin();
                                  } else {
                                    controller.isLoading(false);
                                  }
                                },
                                text: 'Login',
                                color: const Color.fromARGB(255, 237, 182, 200),
                                textColor: Colors.white),
                        Text(
                          'Create a new account',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                        button(
                          onPress: () {
                            Get.to(() => signup());
                          },
                          text: 'Signup',
                          color: Color.fromARGB(255, 241, 219, 226),
                          textColor: Color.fromARGB(255, 217, 151, 173),
                        ),
                        Text(
                          'Login with',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 168, 162, 162),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: CircleAvatar(
                                child: Image.network(
                                  'https://cdn-icons-png.flaticon.com/512/720/720255.png',
                                  width: 30,
                                ),
                                backgroundColor:
                                    const Color.fromARGB(255, 209, 207, 207),
                                radius: 25,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: CircleAvatar(
                                child: Image.network(
                                  'https://png.pngtree.com/element_our/sm/20180515/sm_5afaf0c4b6017.jpg',
                                  width: 30,
                                ),
                                backgroundColor:
                                    const Color.fromARGB(255, 209, 207, 207),
                                radius: 25,
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  }),
                ],
              ),
            ),
          )),
        ),
      ),
    );
  }

  void _signin() async {
    try {
      String email = _emailController.text.trim();
      String password = _passController.text.trim();
                                        controller.isLoading(true);


      User? user = await auth.signin(email, password);
      if (user != null) {
        debugPrint('user login successfuly');

        Get.offAll(HomeScreen());
        Get.snackbar(
          'Success',
          'You login successfully',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green.withOpacity(0.1),
          colorText: Colors.green,
        );
      } else {
        debugPrint('error occurred');
         Get.snackbar(
        'Error',
        'Try again',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.1),
        colorText: Colors.red,
      );
      }
    } catch (e) {
      // Log the error message for debugging.
      print('Error during login: $e');
     
      // Handle the error as needed.
    }finally {
    // Set isLoading to false in both success and error cases to show the login button.
    controller.isLoading(false);
  }
  }
}
