import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:smatpad/providers/cart.dart';

import '../model/cart.dart';

class itemsCart extends StatefulWidget {
  final List cartItems;
  const itemsCart({
    Key? key,
    required this.cartItems,
  }) : super(key: key);

  @override
  State<itemsCart> createState() => _itemsCartState();
}

class _itemsCartState extends State<itemsCart> {
  // late List<Cart> _cart;
  double frameHeight = 0;
  double frameWidth = 0;

  static const String defaultImagePath = 'assets/logo/logo2.png';

  NumberFormat myFormat = NumberFormat.decimalPattern('en_us');

  ScrollController scrollController =
      ScrollController(initialScrollOffset: 25 * 12);

  @override
  Widget build(BuildContext context) {
    var cartItems = context.watch<CartDisplay>().getItemList;

    frameHeight = MediaQuery.of(context).size.height;

    frameWidth = MediaQuery.of(context).size.width;

    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: const Color(0xFF337A6F),
              elevation: 0.0,
              leading: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.transparent,
                  elevation: 0.0,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.black,
                  size: 20.0,
                ),
              ),
              title: Text(
                'Items cart',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                    fontSize: MediaQuery.of(context).size.width * 0.05),
              ),
            ),
            body: cartItems.isNotEmpty
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Card(
                          elevation: 3.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(150),
                          ),
                          child: Column(children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(width: frameWidth / 7),
                                    const Text('Items number   : ',
                                        style: const TextStyle(
                                          fontSize: 16.5,
                                        )),
                                    SizedBox(width: frameWidth / 10),
                                    Text(
                                        context
                                            .watch<CartDisplay>()
                                            .getItemCount
                                            .toString()
                                            .padLeft(2, '0'),
                                        style: const TextStyle(
                                            fontSize: 16.5,
                                            color: Colors.green))
                                  ]),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(width: frameWidth / 7),
                                    const Text('Total orders       :',
                                        style: const TextStyle(
                                          fontSize: 16.5,
                                        )),
                                    SizedBox(width: frameWidth / 8.5),
                                    Text(
                                        '${context.watch<CartDisplay>().getNumberOfAllOrders()}',
                                        style: const TextStyle(
                                            fontSize: 16.5,
                                            color: Colors.green))
                                  ]),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(width: frameWidth / 7),
                                    const Text('Total products   :',
                                        style: const TextStyle(
                                          fontSize: 16.5,
                                        )),
                                    SizedBox(width: frameWidth / 9),
                                    Text(
                                        '${context.watch<CartDisplay>().getNumberOfProducts()}',
                                        style: const TextStyle(
                                            fontSize: 16.5,
                                            color: Colors.green))
                                  ]),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(width: frameWidth / 7),
                                    const Text('Total services    :',
                                        style: const TextStyle(
                                          fontSize: 16.5,
                                        )),
                                    SizedBox(width: frameWidth / 9),
                                    Text(
                                        '${context.watch<CartDisplay>().getNumberOfServices()}',
                                        style: const TextStyle(
                                            fontSize: 16.5,
                                            color: Colors.green))
                                  ]),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(width: frameWidth / 7),
                                    const Text('Total cost           :',
                                        style: const TextStyle(
                                          fontSize: 16.5,
                                        )),
                                    SizedBox(width: frameWidth / 9),
                                    Text(
                                        'Tsh ${myFormat.format(context.watch<CartDisplay>().totalCost())}',
                                        style: const TextStyle(
                                            fontSize: 16.5,
                                            color: Colors.green))
                                  ]),
                            )
                          ]),
                        ),
                      ),
                      ListView.builder(
                          padding: const EdgeInsets.only(
                              top: 8.0, left: 2.0, right: 2.0),
                          physics: const AlwaysScrollableScrollPhysics(
                              parent: BouncingScrollPhysics()),
                          shrinkWrap: true,
                          cacheExtent: 50.0,
                          itemCount:
                              context.watch<CartDisplay>().getItemList.length,
                          itemBuilder: (context, index) {
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
                                        defaultImagePath,
                                        height: 200.0,
                                      ),
                                    ),
                                  ),
                                  title: Text(
                                    "${cartItems[index].name}",
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  subtitle: Row(children: [
                                    Text(
                                        'Tsh ${myFormat.format(cartItems[index].sale_price * cartItems[index].count)}'),
                                    const SizedBox(
                                      width: 10.0,
                                    ),
                                  ]),
                                  trailing: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: Text(
                                          "Tsh ${myFormat.format(cartItems[index].sale_price * cartItems[index].count)}",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.green),
                                        ),
                                      ),
                                      context
                                              .read<CartDisplay>()
                                              .getItemList
                                              .any((element) =>
                                                  element.id ==
                                                  cartItems[index].id)
                                          ? SizedBox(
                                              height: frameHeight / 26,
                                              width: frameWidth / 2.5,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  FloatingActionButton.extended(
                                                      elevation: 1.0,
                                                      foregroundColor:
                                                          Colors.white,
                                                      backgroundColor:
                                                          const Color(
                                                              0xFF337A6F),
                                                      onPressed: () {
                                                        context
                                                            .read<CartDisplay>()
                                                            .updateItemCount(
                                                                cartItems[index]
                                                                    .id,
                                                                'remove');
                                                      },
                                                      label:
                                                          Row(children: const [
                                                        Icon(
                                                          Icons.remove,
                                                          size: 10.0,
                                                        ),
                                                      ])),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 5.0),
                                                    child: Text(
                                                        context
                                                            .watch<
                                                                CartDisplay>()
                                                            .getSingleItem(
                                                                cartItems[index]
                                                                    .id),
                                                        style: const TextStyle(
                                                            fontSize: 18.0,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color:
                                                                Colors.green)),
                                                  ),
                                                  FloatingActionButton.extended(
                                                      elevation: 1.0,
                                                      foregroundColor:
                                                          Colors.white,
                                                      backgroundColor:
                                                          const Color(
                                                              0xFF337A6F),
                                                      onPressed: () {
                                                        context
                                                            .read<CartDisplay>()
                                                            .updateItemCount(
                                                                cartItems[index]
                                                                    .id,
                                                                'add');

                                                        // addedToCart.add(_item.id);
                                                      },
                                                      label:
                                                          Row(children: const [
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
                                              child:
                                                  FloatingActionButton.extended(
                                                      elevation: 1.0,
                                                      foregroundColor:
                                                          Colors.white,
                                                      backgroundColor:
                                                          const Color(
                                                              0xFF337A6F),
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

                                                        // context.read<CartDisplay>().increment();

                                                        // addedToCart.add(_item.id);
                                                      },
                                                      label: Row(
                                                          children: const [
                                                            Icon(
                                                              Icons
                                                                  .add_shopping_cart,
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
                          })
                    ],
                  )
                : const Center(
                    child: Text(
                      'Nothing found',
                      style: TextStyle(color: Colors.grey, fontSize: 15),
                    ),
                  ),
            floatingActionButton: cartItems.isNotEmpty
                ? SizedBox(
                    height: MediaQuery.of(context).size.height / 20,
                    child: FloatingActionButton.extended(
                      onPressed: () {
                        // Add your onPressed code here!
                        // Navigator.push(
                        //         context,
                        //         PageTransition(
                        //             duration: const Duration(milliseconds: 600),
                        //             reverseDuration: const Duration(milliseconds: 600),
                        //             type: PageTransitionType.rightToLeftWithFade,
                        //             child: itemsCart(cartItems: _cart)))
                        //     // .whenComplete(refreshItems)
                        //     ;
                      },
                      // label: Text("${context.watch<CartDisplay>().getItemCount}"),
                      label: const Text('Confirm items on cart',
                          style: TextStyle(
                              color: Colors.white,
                              // fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold)),
                      icon: const Icon(Icons.visibility),
                      backgroundColor: const Color(0xFF337A6F),
                    ),
                  )
                : const Text('')));
  }
}
