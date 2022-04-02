import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:smatpad/pages/sale.dart';
import 'package:smatpad/providers/cart.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

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

  String? selectedValue;
  List<String> items = [
    'patowave 1',
    'patowave 2',
    'patowave 3',
    'patowave 4',
  ];

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
              actions: [
                actionOptions(),
                SizedBox(
                  width: frameWidth / 50,
                )
              ],
            ),
            body: cartItems.isNotEmpty
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 8.0,
                        ),
                        child: Card(
                          elevation: 4.0,
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
                                    const Text('Items number : ',
                                        style: TextStyle(
                                          fontSize: 16.5,
                                          fontWeight: FontWeight.bold,
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
                                    const Text('Total orders     :',
                                        style: TextStyle(
                                          fontSize: 16.5,
                                          fontWeight: FontWeight.bold,
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
                                    const Text('Total products :',
                                        style: TextStyle(
                                          fontSize: 16.5,
                                          fontWeight: FontWeight.bold,
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
                                    const Text('Total services  :',
                                        style: TextStyle(
                                          fontSize: 16.5,
                                          fontWeight: FontWeight.bold,
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
                              padding: const EdgeInsets.only(
                                  top: 4, left: 4, bottom: 10, right: 4),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(width: frameWidth / 7),
                                    const Text('Total cost         :',
                                        style: TextStyle(
                                          fontSize: 16.5,
                                          fontWeight: FontWeight.bold,
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
                            return Slidable(
                              key: Key('$index'),

                              startActionPane: ActionPane(
                                dragDismissible: false,
                                // A motion is a widget used to control how the pane animates.
                                motion: const DrawerMotion(),

                                // A pane can dismiss the Slidable.
                                dismissible:
                                    DismissiblePane(onDismissed: () {}),

                                // All actions are defined in the children parameter.
                                children: [
                                  // A SlidableAction can have an icon and/or a label.
                                  SlidableAction(
                                    autoClose: false,
                                    onPressed: (context) {
                                      context
                                          .read<CartDisplay>()
                                          .hardUpdateItemCount(
                                              cartItems[index].id,
                                              'remove',
                                              '5');
                                    },
                                    backgroundColor: Colors.white,
                                    foregroundColor: const Color(0xFFef233c),
                                    label: '- 5',
                                    // label: 'Purchase',
                                  ),
                                  SlidableAction(
                                    autoClose: false,
                                    onPressed: (context) {
                                      context
                                          .read<CartDisplay>()
                                          .hardUpdateItemCount(
                                              cartItems[index].id,
                                              'remove',
                                              '10');
                                    },
                                    backgroundColor: Colors.white,
                                    foregroundColor: const Color(0xFFef233c),
                                    label: '- 10',
                                  ),
                                  SlidableAction(
                                    autoClose: false,
                                    onPressed: (context) {
                                      context
                                          .read<CartDisplay>()
                                          .hardUpdateItemCount(
                                              cartItems[index].id,
                                              'remove',
                                              '20');
                                    },
                                    backgroundColor: Colors.white,
                                    foregroundColor: const Color(0xFFef233c),
                                    label: '- 20',
                                  ),
                                ],
                              ),

                              // The end action pane is the one at the right or the bottom side.
                              endActionPane: ActionPane(
                                motion: const DrawerMotion(),
                                children: [
                                  SlidableAction(
                                    autoClose: false,
                                    onPressed: (context) {
                                      context
                                          .read<CartDisplay>()
                                          .hardUpdateItemCount(
                                              cartItems[index].id, 'add', '5');
                                    },
                                    backgroundColor: Colors.white,
                                    foregroundColor: const Color(0xFF337A6F),
                                    label: '+ 5',
                                  ),
                                  SlidableAction(
                                    autoClose: false,
                                    onPressed: (context) {
                                      context
                                          .read<CartDisplay>()
                                          .hardUpdateItemCount(
                                              cartItems[index].id, 'add', '10');
                                    },
                                    backgroundColor: Colors.white,
                                    foregroundColor: const Color(0xFF337A6F),
                                    label: '+ 10',
                                  ),
                                  SlidableAction(
                                    autoClose: false,
                                    onPressed: (context) {
                                      context
                                          .read<CartDisplay>()
                                          .hardUpdateItemCount(
                                              cartItems[index].id, 'add', '20');
                                    },
                                    backgroundColor: Colors.white,
                                    foregroundColor: const Color(0xFF337A6F),
                                    label: '+ 20',
                                  ),
                                ],
                              ),
                              child: Card(
                                elevation: 2.5,
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: ListTile(
                                    selectedTileColor: const Color(0xFF337A6F),
                                    leading: GestureDetector(
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(16.0),
                                        child: Image.asset(
                                          defaultImagePath,
                                          height: 200.0,
                                        ),
                                      ),
                                    ),
                                    title: Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 4.0),
                                      child: Text(
                                        "${cartItems[index].name}",
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    subtitle: SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              30,
                                      child: FloatingActionButton.extended(
                                        elevation: 0.0,
                                        onPressed: () {
                                          context
                                              .read<CartDisplay>()
                                              .removeItemFromCart(
                                                  cartItems[index].id);
                                        },
                                        label: const Text('Remove',
                                            style: TextStyle(
                                              color: Colors.white,
                                            )),
                                        backgroundColor:
                                            const Color(0xFFef233c),
                                      ),
                                    ),
                                    trailing: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
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
                                                width: frameWidth / 2.9,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    SizedBox(
                                                      height: frameHeight / 26,
                                                      width: frameWidth / 8.5,
                                                      child: FloatingActionButton
                                                          .extended(
                                                              elevation: 0.0,
                                                              foregroundColor:
                                                                  Colors.white,
                                                              backgroundColor:
                                                                  const Color(
                                                                      0xFF337A6F),
                                                              onPressed: () {
                                                                context
                                                                    .read<
                                                                        CartDisplay>()
                                                                    .updateItemCount(
                                                                        cartItems[index]
                                                                            .id,
                                                                        'remove');
                                                              },
                                                              label: Row(
                                                                  children: const [
                                                                    Icon(
                                                                      Icons
                                                                          .remove,
                                                                      size:
                                                                          10.0,
                                                                    ),
                                                                  ])),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 5.0),
                                                      child: Text(
                                                          context
                                                              .watch<
                                                                  CartDisplay>()
                                                              .getSingleItem(
                                                                  cartItems[
                                                                          index]
                                                                      .id),
                                                          style:
                                                              const TextStyle(
                                                                  fontSize:
                                                                      16.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  color: Colors
                                                                      .green)),
                                                    ),
                                                    SizedBox(
                                                      height: frameHeight / 26,
                                                      width: frameWidth / 8.5,
                                                      child: FloatingActionButton
                                                          .extended(
                                                              elevation: 0.0,
                                                              foregroundColor:
                                                                  Colors.white,
                                                              backgroundColor:
                                                                  const Color(
                                                                      0xFF337A6F),
                                                              onPressed: () {
                                                                context
                                                                    .read<
                                                                        CartDisplay>()
                                                                    .updateItemCount(
                                                                        cartItems[index]
                                                                            .id,
                                                                        'add');

                                                                // addedToCart.add(_item.id);
                                                              },
                                                              label: Row(
                                                                  children: const [
                                                                    Icon(
                                                                      Icons.add,
                                                                      size:
                                                                          10.0,
                                                                    ),
                                                                  ])),
                                                    ),
                                                  ],
                                                ))
                                            : SizedBox(
                                                height: frameHeight / 26,
                                                width: frameWidth / 3.0,
                                                child: FloatingActionButton
                                                    .extended(
                                                        elevation: 1.0,
                                                        foregroundColor:
                                                            Colors.white,
                                                        backgroundColor:
                                                            const Color(
                                                                0xFF337A6F),
                                                        onPressed: () {},
                                                        label: Row(
                                                            children: const [
                                                              Icon(
                                                                Icons
                                                                    .add_shopping_cart,
                                                                size: 22.0,
                                                              ),
                                                              Text(
                                                                  'Add to cart',
                                                                  style: TextStyle(
                                                                      // fontWeight: FontWeight.bold,
                                                                      fontSize: 13.0,
                                                                      color: Colors.white))
                                                            ])),
                                              )
                                      ],
                                    )),
                              ),
                            );
                          }),
                    ],
                  )
                : const Center(
                    child: Text(
                      'Nothing found',
                      style: TextStyle(color: Colors.grey, fontSize: 15),
                    ),
                  ),
            floatingActionButton: cartItems.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.only(left: 30.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 20,
                          child: FloatingActionButton.extended(
                            onPressed: () {
                              context.read<CartDisplay>().clearCart();
                            },
                            // label: Text("${context.watch<CartDisplay>().getItemCount}"),
                            label: const Text('Clear cart',
                                style: TextStyle(
                                    color: Colors.white,
                                    // fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.bold)),
                            icon: const Icon(Icons.cancel),
                            backgroundColor: const Color(0xFFef233c),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 20,
                          child: FloatingActionButton.extended(
                            onPressed: () {
                              Navigator.push(
                                      context,
                                      PageTransition(
                                          duration:
                                              const Duration(milliseconds: 600),
                                          reverseDuration:
                                              const Duration(milliseconds: 600),
                                          type: PageTransitionType
                                              .rightToLeftWithFade,
                                          child: const Sale()));
                            },
                            label: const Text('Confirm cart',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                            icon: const Icon(Icons.visibility),
                            backgroundColor: const Color(0xFF337A6F),
                          ),
                        )
                      ],
                    ),
                  )
                : const Text('')));
  }

  Widget actionOptions() => Center(
        child: DropdownButtonHideUnderline(
          child: DropdownButton2(
            customButton: const Icon(
              Icons.more_vert_rounded,
              size: 25,
              color: Colors.black,
            ),
            items: items
                .map((item) => DropdownMenuItem<String>(
                      value: item,
                      child: Text(
                        item,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ))
                .toList(),
            value: selectedValue,
            onChanged: (value) {
              setState(() {
                selectedValue = value as String;
              });
            },
            itemHeight: 48,
            itemPadding: const EdgeInsets.only(left: 16, right: 16),
            dropdownWidth: 160,
            dropdownPadding: const EdgeInsets.symmetric(vertical: 6),
            dropdownDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: const Color(0xFF337A6F),
            ),
            dropdownElevation: 8,
            offset: const Offset(0, 8),
          ),
        ),
      );
}
