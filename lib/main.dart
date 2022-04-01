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

import 'providers/cart.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
      child: const myApp(),
    ));
  });
}

class myApp extends StatelessWidget {
  const myApp({Key? key}) : super(key: key);

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
  final GlobalKey<FabCircularMenuState> fabKey = GlobalKey();

  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);

  double heightFrame = 0.0;
  double widthFrame = 0.0;

  List<Widget> _buildScreens() {
    return [
      welcomePage(),
      welcomePage(),
      welcomePage(),
      welcomePage(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.book_fill),
        title: ("Items"),
        activeColorPrimary: const Color(0xFF337A6F),
        inactiveColorPrimary: const Color(0xFF337A6F),
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.person_crop_rectangle),
        title: ("Debts"),
        activeColorPrimary: const Color(0xFF337A6F),
        inactiveColorPrimary: const Color(0xFF337A6F),
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.creditcard_fill),
        title: ("Trans"),
        activeColorPrimary: const Color(0xFF337A6F),
        inactiveColorPrimary: const Color(0xFF337A6F),
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.table),
        title: ("More"),
        activeColorPrimary: const Color(0xFF337A6F),
        inactiveColorPrimary: const Color(0xFF337A6F),
      ),
    ];
  }

  _showToast() {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.greenAccent,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Icon(Icons.check),
          SizedBox(
            width: 12.0,
          ),
          Text("Sell Units set successfully"),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    heightFrame = MediaQuery.of(context).size.height;

    widthFrame = MediaQuery.of(context).size.width;
    return Scaffold(
      body: DoubleBackToCloseApp(
        snackBar: const SnackBar(
          content: Text('Tap back again to exit  s m a t p a d'),
        ),
        child: buildBottomNavigations(),
      ),
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
      floatingActionButtonLocation: FloatingActionButtonLocation.startDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 63.0),
        child: DraggableFab(
          child: SizedBox(
            height: heightFrame / 19.0,
            child: FloatingActionButton(
              backgroundColor: const Color(0xFF337A6F),
              onPressed: () {
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: SizedBox(
                      width: widthFrame / 5,
                      height: heightFrame / 24,
                      child: ElevatedButton(
                        child: const Text(
                          'Set Unit',
                          style: TextStyle(
                              fontSize: 12,
                              // fontWeight: FontWeight.w900,
                              color: Color(0xFFE3F2FD)),
                        ),
                        onPressed: () async {
                          var alertStyle = AlertStyle(
                            backgroundColor: Colors.white,
                            animationType: AnimationType.fromLeft,
                            isCloseButton: true,
                            isOverlayTapDismiss: false,
                            descStyle:
                                const TextStyle(fontWeight: FontWeight.bold),
                            descTextAlign: TextAlign.start,
                            animationDuration:
                                const Duration(milliseconds: 400),
                            alertBorder: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              side: const BorderSide(
                                color: Colors.white,
                              ),
                            ),
                            titleStyle: const TextStyle(
                              color: Color(0xFF337A6F),
                            ),
                            alertAlignment: Alignment.center,
                          );
                          Alert(
                              context: context,
                              style: alertStyle,
                              title: "Set Sells Units",
                              content: Column(
                                children: <Widget>[
                                  SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              23),
                                  SizedBox(
                                    height:
                                        MediaQuery.of(context).size.height / 18,
                                    child: DropdownSearch<String>(
                                      mode: Mode.MENU,
                                      showSelectedItems: true,
                                      items: const [
                                        "Bags",
                                        "Bottles",
                                        "Box",
                                        'Bundles',
                                        "Cans",
                                        "Cartons",
                                        "Dozens",
                                        'Grammes',
                                        "Kilograms",
                                        "Litres",
                                        "Meters",
                                        'Millilitres',
                                        "Numbers",
                                        "Packs",
                                        "Pairs",
                                        'Pieces',
                                      ],
                                      label: "Primary unit",
                                      // hint: "country in menu mode",
                                      // popupItemDisabled: (String s) =>
                                      //     s.startsWith('I'),
                                      onChanged: print,
                                    ),
                                  ),
                                  SizedBox(height: heightFrame / 23),
                                  SizedBox(
                                    height: heightFrame / 18,
                                    child: DropdownSearch<String>(
                                      mode: Mode.MENU,
                                      // showSelectedItem: true,
                                      items: const [
                                        "Bottles",
                                        "Box",
                                        'Bundles',
                                        "Cans",
                                        "Cartons",
                                        "Dozens",
                                        'Grammes',
                                        "Kilograms",
                                        "Litres",
                                        "Meters",
                                        'Millilitres',
                                        "Numbers",
                                        "Packs",
                                        "Pairs",
                                      ],
                                      label: "Secondary unit",
                                      // hint: "country in menu mode",
                                      // popupItemDisabled: (String s) =>
                                      //     s.startsWith('I'),
                                      onChanged: print,
                                    ),
                                  ),
                                ],
                              ),
                              buttons: [
                                DialogButton(
                                  color: const Color(0xFF337A6F),
                                  onPressed: () =>
                                      {Navigator.pop(context), _showToast()},
                                  child: const Text(
                                    "Confirm",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  ),
                                )
                              ]).show();

                          FocusScope.of(context).requestFocus(FocusNode());
                        },
                        style: ElevatedButton.styleFrom(
                          elevation: 0.0,
                        ),
                      ),
                    ),
                  ),
                );
              },
              child: const Icon(Icons.add),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildBottomNavigations() => Scaffold(
        body: PersistentTabView(
          context,
          controller: _controller,
          screens: _buildScreens(),
          items: _navBarsItems(),
          confineInSafeArea: true,
          backgroundColor: Colors.white, // Default is Colors.white.
          handleAndroidBackButtonPress: true, // Default is true.
          resizeToAvoidBottomInset:
              true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
          stateManagement: true, // Default is true.
          hideNavigationBarWhenKeyboardShows:
              true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
          decoration: NavBarDecoration(
            borderRadius: BorderRadius.circular(10.0),
            colorBehindNavBar: Colors.white,
          ),
          popAllScreensOnTapOfSelectedTab: true,
          popActionScreens: PopActionScreensType.all,
          itemAnimationProperties: const ItemAnimationProperties(
            // Navigation Bar's items animation properties.
            duration: Duration(milliseconds: 500),
            curve: Curves.ease,
          ),
          screenTransitionAnimation: const ScreenTransitionAnimation(
            // Screen transition animation on change of selected tab.
            animateTabTransition: true,
            curve: Curves.ease,
            duration: Duration(milliseconds: 500),
          ),
          navBarStyle: NavBarStyle
              .style1, // Choose the nav bar style with this property.
        ),

        //   floatingAcz
      );
}
