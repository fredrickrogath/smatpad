// import 'package:animations/animations.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_slidable/flutter_slidable.dart';
// import 'package:loading_animation_widget/loading_animation_widget.dart';
//
// import '../../model/item.dart';
// import '../view_product.dart';
// import 'package:smatpad/db/items_database.dart';
//
// class itemsAll extends StatefulWidget {
//   const itemsAll({Key? key}) : super(key: key);
//
//   @override
//   State<itemsAll> createState() => _itemsAllState();
// }
//
// class _itemsAllState extends State<itemsAll> {
//   List _items = [];
//   bool isLoading = false;
//
//   static const String defaultImagePath = 'assets/logo/logo.jpg';
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     refreshItems();
//   }
//
//   @override
//   void dispose() {
//     // TODO: implement dispose
//     itemsDatabase.instance.close();
//     super.dispose();
//   }
//
//   Future refreshItems() async {
//     setState(() {
//       isLoading = true;
//     });
//     _items = await itemsDatabase.instance.readAllItems();
//     _items = _items.reversed.toList();
//
//     setState(() {
//       isLoading = false;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(child: FutureBuilder<List<Item>>(
//       future: itemsDatabase.instance
//           .readAllItems(), // function where you call your api
//       builder: (context, snapshot) {
//         final items = snapshot.data;
//         // AsyncSnapshot<Your object type>
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Center(
//             child: LoadingAnimationWidget.staggeredDotsWave(
//               color: const Color(0xFF337A6F),
//               size: 30,
//             ),
//           );
//         } else {
//           if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else {
//             return buildItems(items);
//           } // snapshot.data  :- get your object which is pass from your downloadData() function
//         }
//       },
//     ),);
//   }
//
//   Widget buildItems(items) => Stack(children: [
//     _items.isEmpty
//         ? Center(
//       child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             // TextButton(
//             //     onPressed: () {
//             //       _showToast();
//             //     },
//             //     child: Text('hello')),
//             SizedBox(height: MediaQuery.of(context).size.height / 6),
//             const Text(
//               'No data',
//               style: TextStyle(color: Colors.grey, fontSize: 15),
//             ),
//             SizedBox(height: MediaQuery.of(context).size.height / 5),
//             Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 18.0),
//                 child: RichText(
//                   textAlign: TextAlign.center,
//                   text: const TextSpan(
//                     text:
//                     'Add products and services, start your business processes, ',
//                     style: TextStyle(
//                         fontWeight: FontWeight.w400,
//                         color: Colors.black87),
//                     children: <TextSpan>[
//                       TextSpan(
//                           text: ' s m a t p a d  ',
//                           style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               fontSize: 15.0,
//                               color: Color(0xFF337A6F))),
//                       TextSpan(
//                           text:
//                           'will take care of your business performance'),
//                     ],
//                   ),
//                 ))
//           ]),
//     )
//         : ListView.builder(
//         padding: const EdgeInsets.only(top: 0),
//         physics: const NeverScrollableScrollPhysics(),
//         shrinkWrap: true,
//         cacheExtent: 50.0,
//         itemCount: _items.length,
//         itemBuilder: (context, index) {
//           final _item = _items[index];
//           if (_item.category == activeButton &&
//               _item.category != 'all') {
//             return buildItemListTile(_item, index);
//           }
//           if (activeButton == 'all') {
//             return buildItemListTile(_item, index);
//           } else {
//             return const Text('');
//           }
//         }),
//   ]);
//
//   Widget buildItemListTile(_item, index) => SizedBox(
//       height: MediaQuery.of(context).size.height / 7.5,
//       child: Column(
//         children: [
//           Slidable(
//             // Specify a key if the Slidable is dismissible.
//             key: Key('$index'),
//
//             startActionPane: ActionPane(
//               dragDismissible: false,
//               // A motion is a widget used to control how the pane animates.
//               motion: const DrawerMotion(),
//
//               // A pane can dismiss the Slidable.
//               dismissible: DismissiblePane(onDismissed: () {}),
//
//               // All actions are defined in the children parameter.
//               children: const [
//                 // A SlidableAction can have an icon and/or a label.
//                 SlidableAction(
//                   onPressed: null,
//                   backgroundColor: Colors.white,
//                   foregroundColor: Color(0xFF337A6F),
//                   icon: Icons.add_shopping_cart,
//                   // label: 'Purchase',
//                 ),
//                 SlidableAction(
//                   onPressed: null,
//                   backgroundColor: Colors.white,
//                   foregroundColor: Color(0xFF337A6F),
//                   icon: Icons.edit_outlined,
//                   // label: 'Edit item',
//                 ),
//                 SlidableAction(
//                   onPressed: null,
//                   backgroundColor: Colors.white,
//                   foregroundColor: Color(0xffDB575B),
//                   icon: Icons.delete_outline_outlined,
//                   // label: 'Remove',
//                   // spacing: 10.0,
//                 ),
//               ],
//             ),
//
//             // The end action pane is the one at the right or the bottom side.
//             endActionPane: const ActionPane(
//               motion: DrawerMotion(),
//               children: [
//                 SlidableAction(
//                   // An action can be bigger than the others.
//                   // flex: 1,
//                   onPressed: null,
//                   backgroundColor: Colors.white,
//                   foregroundColor: Color(0xFF337A6F),
//                   icon: Icons.monetization_on_outlined,
//                   label: 'Sale',
//                 ),
//                 SlidableAction(
//                   // flex: 1,
//                   onPressed: null,
//                   backgroundColor: Colors.white,
//                   foregroundColor: Color(0xFFC1292E),
//                   icon: Icons.money_off_csred_sharp,
//                   label: 'Return',
//                 ),
//               ],
//             ),
//
//             // The child of the Slidable is what the user sees when the
//             // component is not dragged.
//             child: OpenContainer(
//               closedColor: Colors.white,
//               openColor: const Color(0xFF337A6F),
//               closedElevation: 0.0,
//               openElevation: 0.0,
//               closedShape: const RoundedRectangleBorder(
//                 borderRadius: BorderRadius.all(Radius.circular(10.0)),
//               ),
//               transitionType: ContainerTransitionType.fade,
//               transitionDuration: const Duration(milliseconds: 500),
//               openBuilder: (context, action) {
//                 return viewProduct(
//                   image: '${_item.image_path}',
//                 );
//               },
//               closedBuilder: (context, action) {
//                 return Card(
//                   elevation: 2.5,
//                   color: Colors.white,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(20.0),
//                   ),
//                   child: ListTile(
//                       selectedTileColor: const Color(0xFF337A6F),
//                       leading: GestureDetector(
//                         child: ClipRRect(
//                           borderRadius: BorderRadius.circular(16.0),
//                           child: Image.asset(
//                             _item.image_path == null
//                                 ? defaultImagePath
//                                 : '${_item.image_path}',
//                             height: 200.0,
//                           ),
//                         ),
//                       ),
//                       title: Text(
//                         "${_item.name}",
//                         overflow: TextOverflow.ellipsis,
//                         style: const TextStyle(
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       subtitle: Row(children: [
//                         Text("${_item.quantity}"),
//                         const SizedBox(
//                           width: 10.0,
//                         ),
//                         if (_item.quantity == 0)
//                           Row(children: const [
//                             Text(
//                               'Out of stock',
//                               style: TextStyle(
//                                   fontStyle: FontStyle.italic,
//                                   fontSize: 13.0,
//                                   color: Color(0xFFe63946)),
//                             ),
//                             SizedBox(
//                               width: 3.0,
//                             ),
//                             Icon(Icons.warning_amber_outlined,
//                                 size: 15.0, color: Color(0xFFe63946))
//                           ])
//                         else if (_item.quantity <= 20 && _item.quantity > 0)
//                           Row(children: const [
//                             Text(
//                               'Attention',
//                               style: TextStyle(
//                                   fontSize: 13.0,
//                                   fontStyle: FontStyle.italic,
//                                   color: Color(0xFFff9e00)),
//                             ),
//                             SizedBox(
//                               width: 3.0,
//                             ),
//                             Icon(Icons.warning_amber_outlined,
//                                 size: 15.0, color: Color(0xFFff9e00))
//                           ])
//                         else if (_item.quantity > 20)
//                             Row(children: const [
//                               Text(
//                                 'Availlable',
//                                 style: TextStyle(
//                                     fontSize: 13.0,
//                                     fontStyle: FontStyle.italic,
//                                     color: Color(0xFF337A6F)),
//                               ),
//                               SizedBox(
//                                 width: 3.0,
//                               ),
//                               Icon(Icons.circle,
//                                   size: 15.0, color: Color(0xFF337A6F))
//                             ])
//                         // const Icon(Icons.circle,
//                         //     size: 15.0, color: Color(0xFF337A6F))
//                       ]),
//                       trailing: Column(
//                         crossAxisAlignment: CrossAxisAlignment.end,
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Padding(
//                             padding:
//                             const EdgeInsets.symmetric(horizontal: 8.0),
//                             child: Text(
//                               "Tsh ${_item.sale_price}",
//                               style: const TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.green),
//                             ),
//                           ),
//                           SizedBox(
//                             height: MediaQuery.of(context).size.height / 26,
//                             width: MediaQuery.of(context).size.width / 3,
//                             child: FloatingActionButton.extended(
//                                 elevation: 1.0,
//                                 foregroundColor: Colors.white,
//                                 backgroundColor: const Color(0xFF337A6F),
//                                 onPressed: () {},
//                                 label: Row(children: const [
//                                   Icon(
//                                     Icons.add_shopping_cart,
//                                     size: 20.0,
//                                   ),
//                                   Text('Add to cart',
//                                       style: TextStyle(
//                                         // fontWeight: FontWeight.bold,
//                                           fontSize: 13.0,
//                                           color: Colors.white))
//                                 ])),
//                           )
//                         ],
//                       )),
//                 );
//               },
//             ),
//           ),
//         ],
//       ));
// }
