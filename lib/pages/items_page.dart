import 'dart:async';

import 'package:animations/animations.dart';
import 'package:draggable_home/draggable_home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:smatpad/components/calculator.dart';
import 'package:smatpad/db/items_database.dart';
import 'package:smatpad/providers/cart.dart';
import 'package:smatpad/model/item.dart';
import 'package:smatpad/pages/view_product.dart';
import 'package:provider/provider.dart';
import 'package:smatpad/providers/item_category_buttons.dart';

import '../model/cart.dart';
import 'add_item.dart';
import 'items_cart.dart';

class welcomePage extends StatefulWidget {
  welcomePage({Key? key}) : super(key: key);

  @override
  State<welcomePage> createState() => _welcomePageState();
}

class _welcomePageState extends State<welcomePage> {
  late FToast fToast;
  bool search = false;
  //initializing active button to false
  String activeButton = '';
  //initializing build items again to false... aiming at avoiding multiple database calls
  bool buildItemsAgain = false;
  //initializing globalItems to false... aiming at supplying items value globally
  List<Item>? globalItems = [];
  //initializing _items to false... aiming at holding database items values locally
  List _items = [];
  bool isLoading = false;
  //holds the values of the items details that has been added to the cart
  List<Cart> _cart = [];
  //holds id of item that has been added successfully to the cart
  // List addedToCart = [];

  double frameHeight = 0;

  double frameWidth = 0;

  static const String defaultImagePath = 'assets/logo/logo.jpg';

  NumberFormat myFormat = NumberFormat.decimalPattern('en_us');

  // Future addItemTest() async {
  //   final item = Item(
  //       name: 'Sprite',
  //       expiry: '02-02-2020',
  //       quantity: 0,
  //       category: 'product',
  //       item_code: '2332442',
  //       created_at: DateTime.now(),
  //       aboutItem: 'Soft drink from pepsi company',
  //       image_path: 'assets/items/sprite.jpg',
  //       sale_price: 500.0,
  //       primary_unit: 'Bottle',
  //       secondary_unit: 'Crate',
  //       purchase_price: 10000.0,
  //       primary_unit_cost: 500.0,
  //       secondary_unit_cost: 12000.0);

  //   await itemsDatabase.instance.create(item);
  // }

  void deleteItem(int itemId) async {
    await itemsDatabase.instance.delete(itemId);
  }

  TextEditingController textController = TextEditingController();

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
          Text("This is a Custom Toast"),
        ],
      ),
    );

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: const Duration(seconds: 2),
    );

    // Custom Toast Position
    // fToast.showToast(
    //     child: toast,
    //     toastDuration: const Duration(seconds: 2),
    //     positionedToastBuilder: (context, child) {
    //       return Positioned(
    //         child: child,
    //         top: 16.0,
    //         left: 16.0,
    //       );
    //     });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // addItemTest();
    refreshItems();
    fToast = FToast();
    fToast.init(context);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    itemsDatabase.instance.close();
    super.dispose();
  }

  Future refreshItems() async {
    setState(() {
      isLoading = true;
    });
    _items = await itemsDatabase.instance.readAllItems();
    _items = _items.reversed.toList();

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    //checking for the current state of active button
    activeButton = context.watch<ItemCategoryButtons>().getActiveButton;

    frameHeight = MediaQuery.of(context).size.height;

    frameWidth = MediaQuery.of(context).size.width;

    return SafeArea(
        child: DraggableHome(
      backgroundColor: _items.isEmpty ? Colors.white70 : Colors.white,
      leading: Padding(
        padding: const EdgeInsets.all(5.0),
        child: CircleAvatar(
          backgroundColor: const Color(0xFF24564F),
          // radius: 35,
          child: ClipOval(
            child: Image.asset('assets/logo/logo2.png'),
          ),
        ),
      ),
      title: search
          ? const TextField(
              autofocus: false,
              decoration: InputDecoration(
                hintText: 'Search for product or service...',
                hintStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontStyle: FontStyle.italic,
                ),
                border: InputBorder.none,
              ),
              style: TextStyle(
                color: Colors.white,
              ),
            )
          : const Text(
              'Felister Shop',
              style: TextStyle(
                  color: Colors.black87,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0),
            ),
      actions: [
        search
            ? IconButton(
                onPressed: () {
                  setState(() {
                    search = false;
                  });
                },
                icon: const Icon(
                  Icons.cancel_outlined,
                  size: 30.0,
                ))
            : IconButton(
                onPressed: () {
                  setState(() {
                    search = true;
                  });
                },
                icon: const Icon(
                  Icons.search,
                  size: 30.0,
                )),
      ],
      headerWidget: Container(
        color: const Color(0xFF337A6F),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            children: [
              SizedBox(
                height: frameHeight / 70,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: CircleAvatar(
                          backgroundColor: const Color(0xFF24564F),
                          radius: frameHeight >= 800
                              ? frameHeight / 19
                              : frameHeight / 23,
                          child: ClipOval(
                            child: Image.asset('assets/logo/logo2.png'),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          'Felister Shop',
                          style: TextStyle(
                              color: Colors.black87,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0),
                        ),
                      )
                    ],
                  ),
                  FloatingActionButton(
                    onPressed: () {
                      // Add your onPressed code here
                      FocusScope.of(context).requestFocus(FocusNode());
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          CupertinoIcons.bell,
                          color: Colors.black87,
                          size: 30.0,
                        ),
                        Icon(
                          CupertinoIcons.circle_fill,
                          color: Color(0xFFC1292E),
                          size: 11.0,
                        ),
                      ],
                    ),
                    backgroundColor: const Color(0xFF337A6F),
                    elevation: 2.0,
                  ),
                ],
              ),
              SizedBox(
                height: frameHeight / 90,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      decoration: BoxDecoration(
                          color: const Color(0xFF337A6F),
                          border: Border.all(
                            color: const Color(0xFF337A6F),
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20))),
                      child: SizedBox(
                        height: frameHeight / 9,
                        width: frameWidth / 2.0,
                        child: OpenContainer(
                          closedColor: Colors.white,
                          openColor: const Color(0xFF337A6F),
                          closedElevation: 5.0,
                          openElevation: 0.0,
                          closedShape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                          ),
                          transitionType: ContainerTransitionType.fade,
                          transitionDuration: const Duration(milliseconds: 500),
                          openBuilder: (context, action) {
                            search = false;
                            return const viewProduct(
                              image: 'assets/items/fanta.jpg',
                            );
                          },
                          closedBuilder: (context, action) {
                            // FocusScope.of(context).requestFocus(FocusNode());
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Today's sales",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.05),
                                      ),
                                      const Text(
                                        'Mauzo ya leo',
                                        style: TextStyle(
                                          fontStyle: FontStyle.italic,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 5.0),
                                        child: Text(
                                          'Tsh. 120,300',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.green,
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.04),
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.arrow_upward,
                                        size: frameWidth * 0.05,
                                        color: Colors.green,
                                      ),
                                      const Text(
                                        '10%',
                                        style: TextStyle(
                                          color: Colors.green,
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      )),
                  Container(
                      decoration: BoxDecoration(
                          color: const Color(0xFF337A6F),
                          border: Border.all(
                            color: const Color(0xFF337A6F),
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20))),
                      child: SizedBox(
                        height: frameHeight / 9,
                        width: frameWidth / 2.5,
                        child: OpenContainer(
                          closedColor: Colors.white,
                          openColor: const Color(0xFF337A6F),
                          closedElevation: 5.0,
                          openElevation: 0.0,
                          closedShape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                          ),
                          transitionType: ContainerTransitionType.fade,
                          transitionDuration: const Duration(milliseconds: 500),
                          openBuilder: (context, action) {
                            search = false;
                            return const viewProduct(
                              image: 'assets/items/fanta.jpg',
                            );
                          },
                          closedBuilder: (context, action) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Stock out',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: frameWidth * 0.05),
                                ),
                                const Text(
                                  'Bidhaa zilizouzwa',
                                  style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5.0),
                                  child: Text(
                                    ': 103',
                                    style: TextStyle(
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold,
                                        fontSize: frameWidth * 0.04),
                                  ),
                                )
                              ],
                            );
                          },
                        ),
                      )),
                ],
              ),
              SizedBox(
                height: frameHeight / 90,
              ),
              SizedBox(
                height: 30.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                                context,
                                PageTransition(
                                    duration: const Duration(milliseconds: 600),
                                    reverseDuration:
                                        const Duration(milliseconds: 600),
                                    type:
                                        PageTransitionType.leftToRightWithFade,
                                    child: const addItem()))
                            .whenComplete(refreshItems);
                      },
                      child: const Text(
                        'Add item',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        onPrimary: const Color(0xFF337A6F),
                        primary: const Color(0xFF337A6F),
                        shape: const StadiumBorder(),
                        elevation: 10,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        context.read<ItemCategoryButtons>().setActiveAll();
                      },
                      child: Text(
                        'All',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: activeButton == 'all'
                              ? const Color(0xFF337A6F)
                              : Colors.white,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        onPrimary: activeButton == 'all'
                            ? const Color(0xFF337A6F)
                            : Colors.white,
                        primary: activeButton == 'all'
                            ? Colors.white
                            : const Color(0xFF337A6F),
                        shape: const StadiumBorder(),
                        elevation: 10,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        context.read<ItemCategoryButtons>().setActiveProduct();
                      },
                      child: Text(
                        'Products',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: activeButton == 'product'
                              ? const Color(0xFF337A6F)
                              : Colors.white,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        onPrimary: activeButton == 'product'
                            ? const Color(0xFF337A6F)
                            : Colors.white,
                        primary: activeButton == 'product'
                            ? Colors.white
                            : const Color(0xFF337A6F),
                        shape: const StadiumBorder(),
                        elevation: 10,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        context.read<ItemCategoryButtons>().setActiveService();
                      },
                      child: Text(
                        'Services',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: activeButton == 'service'
                              ? const Color(0xFF337A6F)
                              : Colors.white,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        onPrimary: activeButton == 'service'
                            ? const Color(0xFF337A6F)
                            : Colors.white,
                        primary: activeButton == 'service'
                            ? Colors.white
                            : const Color(0xFF337A6F),
                        shape: const StadiumBorder(),
                        elevation: 10,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      body: [
        buildItemsAgain
            ? FutureBuilder<List<Item>>(
                future: itemsDatabase.instance
                    .readAllItems(), // function where you smatpad data from database
                builder: (context, snapshot) {
                  //get values from database
                  final globalItems = snapshot.data;
                  //assigning local items values to global items values
                  // AsyncSnapshot<Your object type>
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: LoadingAnimationWidget.staggeredDotsWave(
                        color: const Color(0xFF337A6F),
                        size: 30,
                      ),
                    );
                  } else {
                    if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else {
                      return buildItems(globalItems);
                    } // snapshot.data  :- get your object which is pass from your downloadData() function
                  }
                },
              )
            : buildItems(globalItems)
      ],
      // ChangeNotifierProvider(
      // create: (context) => CartDisplay(), child:
      fullyStretchable: true,
      expandedBody: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Welcome to smatpad CAL',
            style: TextStyle(
                fontSize: 21.0,
                color: Colors.white,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: frameHeight / 15,
          ),
          SizedBox(
            height: frameHeight / 22,
            width: frameWidth / 3.0,
            child: OpenContainer(
              closedColor: Colors.white,
              openColor: const Color(0xFF337A6F),
              closedElevation: 0.0,
              openElevation: 0.0,
              closedShape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              transitionType: ContainerTransitionType.fade,
              transitionDuration: const Duration(milliseconds: 1000),
              openBuilder: (context, action) {
                return CalcButton();
              },
              closedBuilder: (context, action) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.calculate_outlined,
                      size: 20.0,
                      color: Color(0xFF337A6F),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        'Calculate',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          // ignore: unrelated_type_equality_checks
                          color: activeButton == 0
                              ? const Color(0xFF337A6F)
                              : Colors.black54,
                        ),
                      ),
                    )
                  ],
                );
              },
            ),
          ),
        ],
      )),

      //***SET CART BUTTON SIZE CORRESPONDING TO ITEM'S SIZE

      floatingActionButton: context.watch<CartDisplay>().getItemCount > 0
          ? SizedBox(
              width: frameWidth / 5,
              height: frameHeight / 19,
              child: FloatingActionButton.extended(
                onPressed: () {
                  // Add your onPressed code here!
                  Navigator.push(
                          context,
                          PageTransition(
                              duration: const Duration(milliseconds: 600),
                              reverseDuration:
                                  const Duration(milliseconds: 600),
                              type: PageTransitionType.rightToLeftWithFade,
                              child: itemsCart(cartItems: _cart)))
                      // .whenComplete(refreshItems)
                      ;
                },
                label: Text(context
                    .watch<CartDisplay>()
                    .getItemCount
                    .toString()
                    .padLeft(2, '0')),
                icon: const Icon(Icons.add_shopping_cart, size: 20.0),
                backgroundColor: const Color(0xFF337A6F),
              ),
            )
          : const SizedBox(height: 0.0, width: 0.0),
    ));
  }

  Widget buildItems(items) => Stack(children: [
        _items.isEmpty
            ? Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // TextButton(
                      //     onPressed: () {
                      //       _showToast();
                      //     },
                      //     child: Text('hello')),
                      SizedBox(height: frameHeight / 6),
                      const Text(
                        'No data',
                        style: TextStyle(color: Colors.grey, fontSize: 15),
                      ),
                      SizedBox(height: frameHeight / 5),
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18.0),
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: const TextSpan(
                              text:
                                  'Add products and services, start your business processes, ',
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black87),
                              children: <TextSpan>[
                                TextSpan(
                                    text: ' s m a t p a d  ',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15.0,
                                        color: Color(0xFF337A6F))),
                                TextSpan(
                                    text:
                                        'will take care of your business performance'),
                              ],
                            ),
                          ))
                    ]),
              )
            //builder checks if activeButton is all items, products, or services
            : ListView.builder(
                padding: const EdgeInsets.all(0.0),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                cacheExtent: 50.0,
                itemCount: _items.length,
                itemBuilder: (context, index) {
                  final _item = _items[index];
                  if (_item.category == activeButton &&
                      _item.category != 'all') {
                    return buildItemTiles(_item, index);
                  } else if (_item.category == activeButton &&
                      _item.category != 'all') {
                    return buildItemTiles(_item, index);
                  } else if (activeButton == 'all') {
                    return buildItemTiles(_item, index);
                  } else {
                    return const SizedBox(height: 0, width: 0);
                  }
                }),
      ]);

  Widget buildItemTiles(_item, index) => SizedBox(
      height: frameHeight / 8.0,
      child: Column(
        children: [
          Slidable(
            // Specify a key if the Slidable is dismissible.
            key: Key('$index'),

            startActionPane: ActionPane(
              dragDismissible: false,
              // A motion is a widget used to control how the pane animates.
              motion: const DrawerMotion(),

              // A pane can dismiss the Slidable.
              dismissible: DismissiblePane(onDismissed: () {}),

              // All actions are defined in the children parameter.
              children: [
                // A SlidableAction can have an icon and/or a label.
                const SlidableAction(
                  onPressed: null,
                  backgroundColor: Colors.white,
                  foregroundColor: Color(0xFF337A6F),
                  icon: Icons.add_shopping_cart,
                  // label: 'Purchase',
                ),
                const SlidableAction(
                  onPressed: null,
                  backgroundColor: Colors.white,
                  foregroundColor: Color(0xFF337A6F),
                  icon: Icons.edit_outlined,
                  // label: 'Edit item',
                ),
                SlidableAction(
                  onPressed: (context) {
                    deleteItem(_item.id);
                    refreshItems();
                  },
                  backgroundColor: Colors.white,
                  foregroundColor: Color(0xffDB575B),
                  icon: Icons.delete_outline_outlined,
                  // label: 'Remove',
                  // spacing: 10.0,
                ),
              ],
            ),

            // The end action pane is the one at the right or the bottom side.
            endActionPane: const ActionPane(
              motion: DrawerMotion(),
              children: [
                SlidableAction(
                  // An action can be bigger than the others.
                  // flex: 1,
                  onPressed: null,
                  backgroundColor: Colors.white,
                  foregroundColor: Color(0xFF337A6F),
                  icon: Icons.monetization_on_outlined,
                  label: 'Sale',
                ),
                SlidableAction(
                  // flex: 1,
                  onPressed: null,
                  backgroundColor: Colors.white,
                  foregroundColor: Color(0xFFC1292E),
                  icon: Icons.money_off_csred_sharp,
                  label: 'Return',
                ),
              ],
            ),

            // The child of the Slidable is what the user sees when the
            // component is not dragged.
            child: OpenContainer(
              closedColor: Colors.white,
              openColor: const Color(0xFF337A6F),
              closedElevation: 0.0,
              openElevation: 0.0,
              closedShape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              transitionType: ContainerTransitionType.fade,
              transitionDuration: const Duration(milliseconds: 600),
              openBuilder: (context, action) {
                return viewProduct(
                  image: '${_item.image_path}',
                );
              },
              closedBuilder: (context, action) {
                return Card(
                  elevation: 2.5,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: ListTile(
                      selectedTileColor: const Color(0xFF337A6F),
                      leading: GestureDetector(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16.0),
                          child: Image.asset(
                            _item.image_path == null
                                ? defaultImagePath
                                : '${_item.image_path}',
                            height: 200.0,
                          ),
                        ),
                      ),
                      title: Text(
                        "${_item.name}",
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Row(children: [
                        Text("${_item.quantity}"),
                        const SizedBox(
                          width: 10.0,
                        ),
                        if (_item.quantity == 0)
                          Row(children: const [
                            Text(
                              'Out of stock',
                              style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  fontSize: 13.0,
                                  color: Color(0xFFe63946)),
                            ),
                            SizedBox(
                              width: 3.0,
                            ),
                            Icon(Icons.warning_amber_outlined,
                                size: 15.0, color: Color(0xFFe63946))
                          ])
                        else if (_item.quantity <= 20 && _item.quantity > 0)
                          Row(children: const [
                            Text(
                              'Attention',
                              style: TextStyle(
                                  fontSize: 13.0,
                                  fontStyle: FontStyle.italic,
                                  color: Color(0xFFff9e00)),
                            ),
                            SizedBox(
                              width: 3.0,
                            ),
                            Icon(Icons.warning_amber_outlined,
                                size: 15.0, color: Color(0xFFff9e00))
                          ])
                        else if (_item.quantity > 20)
                          Row(children: const [
                            Text(
                              'Availlable',
                              style: TextStyle(
                                  fontSize: 13.0,
                                  fontStyle: FontStyle.italic,
                                  color: Color(0xFF337A6F)),
                            ),
                            SizedBox(
                              width: 3.0,
                            ),
                            Icon(Icons.circle,
                                size: 15.0, color: Color(0xFF337A6F))
                          ])
                        // const Icon(Icons.circle,
                        //     size: 15.0, color: Color(0xFF337A6F))
                      ]),
                      trailing: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              "Tsh ${myFormat.format(_item.sale_price)}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green),
                            ),
                          ),
                          context
                                  .read<CartDisplay>()
                                  .getItemList
                                  .any((element) => element.id == _item.id)
                              ? SizedBox(
                                  height: frameHeight / 26,
                                  width: frameWidth / 2.8,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      FloatingActionButton.extended(
                                          elevation: 1.0,
                                          foregroundColor: Colors.white,
                                          backgroundColor:
                                              const Color(0xFF337A6F),
                                          onPressed: () {
                                            context
                                                .read<CartDisplay>()
                                                .updateItemCount(
                                                    _item.id, 'remove');
                                          },
                                          label: Row(children: const [
                                            Icon(
                                              Icons.remove,
                                              size: 10.0,
                                            ),
                                          ])),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 3.0),
                                        child: Text(
                                            context
                                                .watch<CartDisplay>()
                                                .getSingleItem(_item.id),
                                            style: const TextStyle(
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.green)),
                                      ),
                                      FloatingActionButton.extended(
                                          elevation: 1.0,
                                          foregroundColor: Colors.white,
                                          backgroundColor:
                                              const Color(0xFF337A6F),
                                          onPressed: () {
                                            context
                                                .read<CartDisplay>()
                                                .updateItemCount(
                                                    _item.id, 'add');

                                            // addedToCart.add(_item.id);
                                          },
                                          label: Row(children: const [
                                            Icon(
                                              Icons.add,
                                              size: 10.0,
                                            ),
                                          ])),
                                    ],
                                  ))
                              : SizedBox(
                                  height: frameHeight / 26,
                                  width: frameWidth / 3.0,
                                  child: FloatingActionButton.extended(
                                      elevation: 1.0,
                                      foregroundColor: Colors.white,
                                      backgroundColor: const Color(0xFF337A6F),
                                      onPressed: () {
                                        // final isAdded = context
                                        //     .read<CartDisplay>()
                                        //     .getItemList
                                        //     .any((element) => element.id == 16);

                                        // isAdded == true
                                        //     ? context
                                        //         .read<CartDisplay>()
                                        //         .getItemList
                                        //         .firstWhere((element) =>
                                        //             element.count++)
                                        //     :
                                        context
                                            .read<CartDisplay>()
                                            .addItemsToCart(
                                                _item.id,
                                                _item.name,
                                                _item.category,
                                                _item.image_path,
                                                _item.sale_price);
                                        // context.read<CartDisplay>().increment();

                                        // addedToCart.add(_item.id);
                                      },
                                      label: Row(children: const [
                                        Icon(
                                          Icons.add_shopping_cart,
                                          size: 22.0,
                                        ),
                                        Text('Add to cart',
                                            style: TextStyle(
                                                // fontWeight: FontWeight.bold,
                                                fontSize: 13.0,
                                                color: Colors.white))
                                      ])),
                                )
                        ],
                      )),
                );
              },
            ),
          ),
        ],
      ));
}
