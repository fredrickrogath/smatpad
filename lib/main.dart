// import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:draggable_fab/draggable_fab.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:smatpad/pages/items_page.dart';
import 'package:smatpad/providers/item_category_buttons.dart';
import 'package:smatpad/themes/primary_swatch.dart';
import 'package:provider/provider.dart';
import 'package:adaptive_theme/adaptive_theme.dart';

import 'providers/cart.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final savedThemeMode = await AdaptiveTheme.getThemeMode();
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  ).then((val) {
    runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartDisplay()),
        ChangeNotifierProvider(create: (_) => ItemCategoryButtons()),
      ],
      child: myApp(savedThemeMode: savedThemeMode),
    ));
  });
}

class myApp extends StatefulWidget {
  final AdaptiveThemeMode? savedThemeMode;
  const myApp({Key? key, this.savedThemeMode}) : super(key: key);

  @override
  State<myApp> createState() => _myAppState();
}

class _myAppState extends State<myApp> {
  bool isMaterial = true;
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.from(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: MaterialColor(0xFF337A6F, color),
        ).copyWith(
          secondary: Colors.green,
        ),
        textTheme: const TextTheme(bodyText2: TextStyle(color: Colors.black87)),
      ).copyWith(
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: <TargetPlatform, PageTransitionsBuilder>{
            TargetPlatform.android: ZoomPageTransitionsBuilder(),
            TargetPlatform.iOS: ZoomPageTransitionsBuilder(),
          },
        ),
      ),
      title: "s  m  a  t  p  a d",
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // final GlobalKey<FabCircularMenuState> fabKey = GlobalKey();

  // final PersistentTabController _controller =
  //     PersistentTabController(initialIndex: 0);

  double heightFrame = 0.0;
  double widthFrame = 0.0;
  //List<String> _titles = ["Home", "Profile", "Shop"];
  List<Widget> _items = [
    welcomePage(),
    welcomePage(),
    welcomePage(),
    welcomePage(),
  ];
  int _selectedIndex = 0;

  // List<Widget> _buildScreens() {
  //   return [
  //     welcomePage(),
  //     welcomePage(),
  //     welcomePage(),
  //     welcomePage(),
  //   ];
  // }

  // List<PersistentBottomNavBarItem> _navBarsItems() {
  //   return [
  //     PersistentBottomNavBarItem(
  //       icon: const Icon(CupertinoIcons.book_fill),
  //       title: ("Items"),
  //       activeColorPrimary: const Color(0xFF337A6F),
  //       inactiveColorPrimary: const Color(0xFF337A6F),
  //     ),
  //     PersistentBottomNavBarItem(
  //       icon: const Icon(CupertinoIcons.person_crop_rectangle),
  //       title: ("Debts"),
  //       activeColorPrimary: const Color(0xFF337A6F),
  //       inactiveColorPrimary: const Color(0xFF337A6F),
  //     ),
  //     PersistentBottomNavBarItem(
  //       icon: const Icon(CupertinoIcons.creditcard_fill),
  //       title: ("Trans"),
  //       activeColorPrimary: const Color(0xFF337A6F),
  //       inactiveColorPrimary: const Color(0xFF337A6F),
  //     ),
  //     PersistentBottomNavBarItem(
  //       icon: const Icon(CupertinoIcons.table),
  //       title: ("More"),
  //       activeColorPrimary: const Color(0xFF337A6F),
  //       inactiveColorPrimary: const Color(0xFF337A6F),
  //     ),
  //   ];
  // }

  // _showToast() {
  //   Widget toast = Container(
  //     padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
  //     decoration: BoxDecoration(
  //       borderRadius: BorderRadius.circular(25.0),
  //       color: Colors.greenAccent,
  //     ),
  //     child: Row(
  //       mainAxisSize: MainAxisSize.min,
  //       children: const [
  //         Icon(Icons.check),
  //         SizedBox(
  //           width: 12.0,
  //         ),
  //         Text("Sell Units set successfully"),
  //       ],
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    heightFrame = MediaQuery.of(context).size.height;

    widthFrame = MediaQuery.of(context).size.width;
    return Scaffold(
      // body: 
      // DoubleBackToCloseApp(
      //   snackBar: const SnackBar(
      //     content: Text('Tap back again to exit  s m a t p a d'),
      //   ),
      //   child: buildBottomNavigations(),
      // ),



      
      // floatingActionButton: Builder(
      //   builder: (context) => FabCircularMenu(
      //     key: fabKey,
      //     // Cannot be `Alignment.center`
      //     alignment: Alignment.bottomRight,
      //     ringColor: Colors.white.withAlpha(100),
      //     ringDiameter: 500.0,
      //     ringWidth: 150.0,
      //     fabSize: 45.0,
      //     fabElevation: 5.0,
      //     fabIconBorder: const CircleBorder(),
      //     // Also can use specific color based on wether
      //     // the menu is open or not:
      //     // fabOpenColor: Colors.white
      //     // fabCloseColor: Colors.white
      //     // These properties take precedence over fabColor
      //     fabColor: Colors.white,
      //     fabOpenIcon: const Icon(Icons.menu, color: Color(0xFF337A6F)),
      //     fabCloseIcon: const Icon(Icons.close, color: Color(0xFF337A6F)),
      //     fabMargin: const EdgeInsets.all(16.0),
      //     animationDuration: const Duration(milliseconds: 800),
      //     animationCurve: Curves.easeInOutCirc,
      //     onDisplayChange: (isOpen) {
      //       // _showSnackBar(context, "The menu is ${isOpen ? "open" : "closed"}");
      //     },
      //     children: <Widget>[
      //       RawMaterialButton(
      //         onPressed: () {
      //           // _showSnackBar(context, "You pressed 1");
      //         },
      //         shape: const CircleBorder(),
      //         padding: const EdgeInsets.all(24.0),
      //         child: const Icon(Icons.more_outlined, color: Color(0xFF337A6F)),
      //       ),
      //       RawMaterialButton(
      //         onPressed: () {
      //           // _showSnackBar(context, "You pressed 2");
      //         },
      //         shape: const CircleBorder(),
      //         padding: const EdgeInsets.all(24.0),
      //         child: const Icon(Icons.money_off, color: Color(0xFF337A6F)),
      //       ),
      //       RawMaterialButton(
      //         onPressed: () {
      //           // _showSnackBar(context, "You pressed 3");
      //         },
      //         shape: const CircleBorder(),
      //         padding: const EdgeInsets.all(24.0),
      //         child: const Icon(Icons.attach_money, color: Color(0xFF337A6F)),
      //       ),
      //       RawMaterialButton(
      //         onPressed: () {
      //           // _showSnackBar(context, "You pressed 4. This one closes the menu on tap");
      //           fabKey.currentState?.close();
      //         },
      //         shape: const CircleBorder(),
      //         padding: const EdgeInsets.all(24.0),
      //         child: const Icon(Icons.home, color: Color(0xFF337A6F)),
      //       ),
      //     ],
      //   ),
      // ),
      body:Center(
        child: IndexedStack(
          index: _selectedIndex,
          children: _items
        )//_items.elementAt(_index),
      ),
      bottomNavigationBar: _showBottomNav(),
    );
  }

  // Widget buildBottomNavigations() => Scaffold(
  //       body: PersistentTabView(
  //         context,
  //         controller: _controller,
  //         screens: _buildScreens(),
  //         items: _navBarsItems(),
  //         confineInSafeArea: true,
  //         backgroundColor: Colors.white, // Default is Colors.white.
  //         handleAndroidBackButtonPress: true, // Default is true.
  //         resizeToAvoidBottomInset:
  //             true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
  //         stateManagement: true, // Default is true.
  //         hideNavigationBarWhenKeyboardShows:
  //             true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
  //         decoration: NavBarDecoration(
  //           borderRadius: BorderRadius.circular(10.0),
  //           colorBehindNavBar: Colors.white,
  //         ),
  //         popAllScreensOnTapOfSelectedTab: true,
  //         popActionScreens: PopActionScreensType.all,
  //         itemAnimationProperties: const ItemAnimationProperties(
  //           // Navigation Bar's items animation properties.
  //           duration: Duration(milliseconds: 500),
  //           curve: Curves.ease,
  //         ),
  //         screenTransitionAnimation: const ScreenTransitionAnimation(
  //           // Screen transition animation on change of selected tab.
  //           animateTabTransition: true,
  //           curve: Curves.ease,
  //           duration: Duration(milliseconds: 500),
  //         ),
  //         navBarStyle: NavBarStyle
  //             .style1, // Choose the nav bar style with this property.
  //       ),

  //       //   floatingAcz
  //     );



  Widget _showBottomNav()
  {
    return BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: 'Shop',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: 'Shop',
          ),
        ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.green,
      unselectedItemColor: Colors.grey,
      onTap: _onTap,
    );
  }
 
  void _onTap(int index)
  {
    _selectedIndex = index;
    setState(() {
 
    });
  }
}
