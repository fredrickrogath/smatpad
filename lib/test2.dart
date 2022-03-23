// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
// import 'package:smatpad/pages/items_page.dart';
//
// class homePage extends StatelessWidget {
//
//   final _controller = PersistentTabController(initialIndex: 0);
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: PersistentTabView(
//         context,
//         controller: _controller,
//         screens: _buildScreens(),
//         items: _navBarsItems(),
//         confineInSafeArea: true,
//         backgroundColor: Colors.white, // Default is Colors.white.
//         handleAndroidBackButtonPress: true, // Default is true.
//         resizeToAvoidBottomInset: true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
//         stateManagement: true, // Default is true.
//         hideNavigationBarWhenKeyboardShows: true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
//         decoration: NavBarDecoration(
//           borderRadius: BorderRadius.circular(10.0),
//           colorBehindNavBar: Colors.white,
//         ),
//         popAllScreensOnTapOfSelectedTab: true,
//         popActionScreens: PopActionScreensType.all,
//         itemAnimationProperties: const ItemAnimationProperties( // Navigation Bar's items animation properties.
//           duration: Duration(milliseconds: 900),
//           curve: Curves.ease,
//         ),
//         screenTransitionAnimation: const ScreenTransitionAnimation( // Screen transition animation on change of selected tab.
//           animateTabTransition: true,
//           curve: Curves.ease,
//           duration: Duration(milliseconds: 900),
//         ),
//         navBarStyle: NavBarStyle.style1, // Choose the nav bar style with this property.
//       ),
//     );
//   }
// }
//
// List<Widget> _buildScreens() {
//   return [
//     const welcomePage(),
//     // const createBudget(),
//     // const loanManagement(),
//   ];
// }
//
// List<PersistentBottomNavBarItem> _navBarsItems() {
//   return [
//     PersistentBottomNavBarItem(
//       icon: const Icon(CupertinoIcons.home),
//       title: ("Home"),
//       textStyle: const TextStyle(fontWeight: FontWeight.bold),
//       activeColorPrimary: CupertinoColors.activeBlue,
//       inactiveColorPrimary: CupertinoColors.systemGrey,
//     ),
//     PersistentBottomNavBarItem(
//       icon: const Icon(CupertinoIcons.money_dollar),
//       title: ("Budget"),
//       textStyle: const TextStyle(fontWeight: FontWeight.bold),
//       activeColorPrimary: CupertinoColors.activeBlue,
//       inactiveColorPrimary: CupertinoColors.systemGrey,
//     ),
//     PersistentBottomNavBarItem(
//       icon: const Icon(CupertinoIcons.money_dollar),
//       title: ("Loans"),
//       textStyle: const TextStyle(fontWeight: FontWeight.bold),
//       activeColorPrimary: CupertinoColors.activeBlue,
//       inactiveColorPrimary: CupertinoColors.systemGrey,
//     ),
//   ];
// }
//
//
//
