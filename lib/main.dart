import 'package:flutter/material.dart';
import 'package:flutter_application_1/Views/auth_screen/login.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

import 'Views/Splash_screen/SplashScreen.dart';





Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if(kIsWeb){
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyA_9JRMZoiy0ObanG8PCUM0ew5HDqOd7MA", 
        appId: "1:16040205626:web:a2a903f9a33cf240754403", 
        messagingSenderId: "16040205626",
         projectId: "loginauth-6577d",

));
  }
  else{
     await Firebase.initializeApp();
  }

  runApp( const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
       
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  SplashScreen(),
    );
  }
}


  