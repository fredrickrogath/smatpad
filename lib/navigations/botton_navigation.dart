// import 'package:fab_circular_menu/fab_circular_menu.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
// import 'package:smatpad/pages/items_page.dart';
// import 'package:smatpad/themes/primary_swatch.dart';
//
// import 'package:fab_circular_menu/fab_circular_menu.dart';
//
// class bottomNavigation extends StatelessWidget {
//   final GlobalKey<FabCircularMenuState> fabKey = GlobalKey();
//
//   @override
//   Widget build(BuildContext context) {
//     return Builder(
//     builder: (context) => FabCircularMenu(
//     key: fabKey,
//     // Cannot be `Alignment.center`
//     alignment: Alignment.bottomRight,
//     ringColor: Colors.white.withAlpha(25),
//     ringDiameter: 500.0,
//     ringWidth: 150.0,
//     fabSize: 64.0,
//     fabElevation: 8.0,
//     fabIconBorder: CircleBorder(),
//     // Also can use specific color based on wether
//     // the menu is open or not:
//     // fabOpenColor: Colors.white
//     // fabCloseColor: Colors.white
//     // These properties take precedence over fabColor
//     fabColor: Colors.white,
//     fabOpenIcon: Icon(Icons.menu, color: primaryColor),
//     fabCloseIcon: Icon(Icons.close, color: primaryColor),
//     fabMargin: const EdgeInsets.all(16.0),
//     animationDuration: const Duration(milliseconds: 800),
//     animationCurve: Curves.easeInOutCirc,
//     onDisplayChange: (isOpen) {
//     _showSnackBar(
//     context, "The menu is ${isOpen ? "open" : "closed"}");
//     },
//     children: <Widget>[
//     RawMaterialButton(
//     onPressed: () {
//     _showSnackBar(context, "You pressed 1");
//     },
//     shape: CircleBorder(),
//     padding: const EdgeInsets.all(24.0),
//     child: Icon(Icons.looks_one, color: Colors.white),
//     ),
//     RawMaterialButton(
//     onPressed: () {
//     _showSnackBar(context, "You pressed 2");
//     },
//     shape: CircleBorder(),
//     padding: const EdgeInsets.all(24.0),
//     child: Icon(Icons.looks_two, color: Colors.white),
//     ),
//     RawMaterialButton(
//     onPressed: () {
//     _showSnackBar(context, "You pressed 3");
//     },
//     shape: CircleBorder(),
//     padding: const EdgeInsets.all(24.0),
//     child: Icon(Icons.looks_3, color: Colors.white),
//     ),
//     RawMaterialButton(
//     onPressed: () {
//     _showSnackBar(context,
//     "You pressed 4. This one closes the menu on tap");
//     fabKey.currentState?.close();
//     },
//     shape: CircleBorder(),
//     padding: const EdgeInsets.all(24.0),
//     child: Icon(Icons.looks_4, color: Colors.white),
//     )
//     ],
//     );
//   }
// }
//
// List<Widget> _buildScreens() {
//   return [
//     welcomePage(),
//     Center(child: const Text('page 2')),
//     Center(child: const Text('page 3')),
//     Center(child: const Text('page 2')),
//     Center(child: const Text('page 2')),
//     // const createBudget(),
//     // const loanManagement(),
//   ];
// }
//
// List<PersistentBottomNavBarItem> _navBarsItems() {
//   return [
//     PersistentBottomNavBarItem(
//       icon: const Icon(CupertinoIcons.home),
//       title: ("Items"),
//       iconSize: 20.0,
//       textStyle: const TextStyle(fontWeight: FontWeight.bold),
//       activeColorPrimary: MaterialColor(0xFF337A6F, color),
//       inactiveColorPrimary: CupertinoColors.black,
//     ),
//     PersistentBottomNavBarItem(
//       icon: const Icon(CupertinoIcons.person_2_fill),
//       title: ("Debts"),
//       textStyle: const TextStyle(fontWeight: FontWeight.bold),
//       activeColorPrimary: MaterialColor(0xFF337A6F, color),
//       inactiveColorPrimary: CupertinoColors.black,
//     ),
//     PersistentBottomNavBarItem(
//       icon: const Icon(CupertinoIcons.add_circled),
//       title: ("New"),
//       textStyle: const TextStyle(fontWeight: FontWeight.bold),
//       activeColorPrimary: MaterialColor(0xFF337A6F, color),
//       inactiveColorPrimary: CupertinoColors.black,
//     ),
//     PersistentBottomNavBarItem(
//       icon: const Icon(CupertinoIcons.money_dollar),
//       title: ("Trans"),
//       textStyle: const TextStyle(fontWeight: FontWeight.bold),
//       activeColorPrimary: MaterialColor(0xFF337A6F, color),
//       inactiveColorPrimary: CupertinoColors.black,
//     ),
//     PersistentBottomNavBarItem(
//       icon: const Icon(CupertinoIcons.table_badge_more),
//       title: ("More"),
//       textStyle: const TextStyle(fontWeight: FontWeight.bold),
//       activeColorPrimary: MaterialColor(0xFF337A6F, color),
//       inactiveColorPrimary: CupertinoColors.black,
//     ),
//   ];
// }
