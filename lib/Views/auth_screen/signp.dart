import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Controller/home_screen_controller.dart';
import '../../Services/user_auth.dart';
import '../../widgets_common/bg_widget.dart';
import '../../widgets_common/button.dart';
import '../../widgets_common/splash_logo.dart';
import '../../widgets_common/txt_field.dart';
import '../home_screen/homeScreen.dart';

class signup extends StatefulWidget {
  signup({super.key});

  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {
  bool isChecked = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
    TextEditingController firstController = TextEditingController();
        TextEditingController lastController = TextEditingController();
            TextEditingController reppassController = TextEditingController();
  final Authservice auth= Authservice();
  var controller=Get.put(HomeController());



  
  @override
  Widget build(BuildContext context) {
    return bg(
      child: Scaffold(
        backgroundColor: Colors.yellow,
        body: Center(
            child: Padding(
          padding: const EdgeInsets.only(left: 50, right: 50),
          child: Container(
            width: 400,
            height: 600,
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
                  'Join to eMart',
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                ),
                Obx(
                   () {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, bottom: 8, top: 8),
                          child: txtField(
                            controller: firstController,
                              txt: 'First Name',
                              val: false,
                              color: const Color.fromARGB(255, 224, 218, 218),
                              brdrcolor: Colors.yellow),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, bottom: 8, top: 8),
                          child: txtField(
                            controller: lastController,
                              txt: 'Last Name',
                              val: false,
                              color: const Color.fromARGB(255, 224, 218, 218),
                              brdrcolor: Colors.yellow),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, bottom: 8, top: 8),
                          child: txtField(
                                controller: emailController,

                              txt: 'Email',
                              val: false,
                              color: const Color.fromARGB(255, 224, 218, 218),
                              brdrcolor: Colors.yellow),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, bottom: 8, top: 8),
                          child: txtField(
                            controller: passController,
                              txt: 'Password',
                              val: true,
                              color: const Color.fromARGB(255, 224, 218, 218),
                              brdrcolor: Colors.yellow),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, bottom: 8, top: 8),
                          child: txtField(
                            controller: reppassController,
                              txt: 'Repeat Password',
                              val: true,
                              color: const Color.fromARGB(255, 224, 218, 218),
                              brdrcolor: Colors.yellow),
                        ),
                        Row(
                          children: [
                            Checkbox(
                                value: isChecked,
                                onChanged: (value) {
                                  setState(() {
                                    isChecked = value!;
                                  });
                                }),
                            Text(
                              'Agree to our terms and policies',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.blue,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        controller.isLoading.value  ? CircularProgressIndicator()
                        :button(
                            onPress: () {
                              
                                _signup();
                              
                            },
                            text: 'Signup',
                            color: const Color.fromARGB(255, 237, 182, 200),
                            textColor: Colors.white),
                      ],
                    );
                  }
                ),
              ],
            ),
          ),
        )),
      ),
    );
  }
  void _signup() async{
    String email =emailController.text;
    String password=passController.text;
       String firstname=firstController.text;
      String lastname=lastController.text;
       //String repeatpass=reppassController.text;
          controller.isLoading(true);


    User? user = await auth.signup(email, password);
    try{
    if(user!=null){
      debugPrint('user create account successfuly');
          String uid = user.uid;
                  Get.offAll(HomeScreen());

          Get.snackbar('Success', 'You account has been created',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green.withOpacity(0.1),
          colorText: Colors.green,
          );

      //Navigator.of(context).pushNamed('/homepg');
      return auth.storeUserData(uid, firstname, lastname, email, password);

    }
    else{
      debugPrint('error occured');
      Get.snackbar('Error', 'Something went wrong, try again',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red.withOpacity(0.1),
      colorText: Colors.red,
      );
    }

  }catch (e) {
      // Log the error message for debugging.
      print('Error during signup: $e');
     
      // Handle the error as needed.
    }finally {
    // Set isLoading to false in both success and error cases to show the login button.
    controller.isLoading(false);
  }
  }
}
