import 'package:ecommerce_test/core/app_theam.dart';
import 'package:ecommerce_test/feature/presentation/page/cart/cart_page.dart';
import 'package:ecommerce_test/feature/presentation/page/category/category_page.dart';
import 'package:ecommerce_test/feature/presentation/page/favourite/favourite_page.dart';
import 'package:ecommerce_test/feature/presentation/page/home/home_page.dart';
import 'package:ecommerce_test/feature/presentation/page/profile/profile_page.dart';
import 'package:flutter/material.dart';

Widget bottomNavigation(
    {required BuildContext context,
    required int selectedIndex,
    required var onItemTapped}) {
  return Container(
    margin: EdgeInsets.only(top: 10),
    decoration: BoxDecoration(
      color: Theme.of(context).scaffoldBackgroundColor,
      border: Border(top: BorderSide(
        color: Colors.white,
      ))
    ),
    child: Container(
      // decoration: const BoxDecoration(
      //   borderRadius: BorderRadius.only(
      //       topLeft: Radius.circular(10), topRight: Radius.circular(10)),
      //   color: AppTheme.skeletonBaseColor,
      // ),
      child: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home),label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.sync_alt_outlined),label: '' ),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart_outlined), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_rounded),label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person_outlined),label: ''),
        ],
        type: BottomNavigationBarType.fixed,
        currentIndex: selectedIndex,
        selectedItemColor: AppTheme.secondaryColor,
        unselectedItemColor: AppTheme.lightOnPrimaryColor,
        backgroundColor: Colors.white,
        iconSize: 30,
        onTap: (value) => onItemTapped(value),
        elevation: 30,
      ),
    ),
  );
}

class AppNavigationBar extends StatefulWidget {
  final int selectedIndex;
  const AppNavigationBar({required this.selectedIndex, super.key});

  @override
  State<AppNavigationBar> createState() => _AppNavigationBarState();
}

class _AppNavigationBarState extends State<AppNavigationBar> {
  int selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  void initState() {
    selectedIndex = widget.selectedIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var pages = [
      const HomePage(),
      CategoryView(),
      CartView(),
      FavouriteView(),
      ProfileView(),
    ];
    return Scaffold(
      body: pages[selectedIndex],
      bottomNavigationBar: bottomNavigation(
          context: context,
          selectedIndex: selectedIndex,
          onItemTapped: _onItemTapped),
    );
  }
}
