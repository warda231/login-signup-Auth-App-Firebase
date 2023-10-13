import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Controller/home_screen_controller.dart';
import '../Cart_screen/cart_screen.dart';
import '../account/account_screen.dart';
import '../category_screen/category_screen.dart';
import 'home.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var navsbar = [
      BottomNavigationBarItem(
        icon: Icon(
          Icons.home,
          color: Colors.yellow,
        ),
        backgroundColor: Colors.grey,
        label: 'Home',
      ),
      BottomNavigationBarItem(
        icon: Icon(
          Icons.category,
          color: Colors.yellow,
        ),
        backgroundColor: Colors.grey,
        label: 'Categories',
      ),
      BottomNavigationBarItem(
        icon: Icon(
          Icons.shopping_cart,
          color: Colors.yellow,
        ),
        backgroundColor: Colors.grey,
        label: 'Cart',
      ),
      BottomNavigationBarItem(
        icon: Icon(
          Icons.person,
          color: Colors.yellow,
        ),
        backgroundColor: Colors.grey,
        label: 'Account',
      ),
    ];

    var pages = [
      Home(),
      CategoryScreen(),
      CartScreen(),
      AccountScreen(),
    ];

    var controller = Get.put(HomeController());
    return Scaffold(
      //backgroundColor: Colors.yellow,
      body: Column(
        children: [
          Obx(() =>
              Expanded(child: pages.elementAt(controller.navbarindex.value)))
        ],
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: controller.navbarindex.value,
          items: navsbar,
          backgroundColor: Colors.white,
          selectedItemColor: Colors.red,
          unselectedItemColor: const Color.fromARGB(255, 19, 92, 151),
          selectedLabelStyle: TextStyle(color: Colors.red, fontSize: 15, fontWeight: FontWeight.bold),
          type: BottomNavigationBarType.fixed,
          onTap: (Value) {
            controller.navbarindex.value = Value;
          },
        ),
      ),
    );
  }
}
