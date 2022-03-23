// import 'package:animations/animations.dart';
// import 'package:draggable_home/draggable_home.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_slidable/flutter_slidable.dart';
// import 'package:smatpad/components/calculator.dart';
// import 'package:smatpad/models/items_model.dart';
// import 'package:smatpad/pages/add_item.dart';
// import 'package:smatpad/pages/view_product.dart';

// class welcomePage extends StatefulWidget {
//   welcomePage({Key? key}) : super(key: key);

//   @override
//   State<welcomePage> createState() => _welcomePageState();
// }

// class _welcomePageState extends State<welcomePage> {
//   bool search = false;
//   int activeButton = 0;

//   @override
//   void initState() {
//     super.initState();
//     late List<Items> items;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return DraggableHome(
//       backgroundColor: Colors.white,
//       leading: CircleAvatar(
//         backgroundColor: const Color(0xFF337A6F),
//         radius: 40,
//         child: ClipOval(
//           child: Image.asset('assets/logo/logo.jpg'),
//         ),
//       ),
//       title: search
//           ? const TextField(
//         decoration: InputDecoration(
//           hintText: 'Search for product or service...',
//           hintStyle: TextStyle(
//             color: Colors.white,
//             fontSize: 18,
//             fontStyle: FontStyle.italic,
//           ),
//           border: InputBorder.none,
//         ),
//         style: TextStyle(
//           color: Colors.white,
//         ),
//       )
//           : const Text(
//         'Happy Shop',
//         style: TextStyle(
//             color: Colors.black87,
//             fontWeight: FontWeight.bold,
//             fontSize: 16.0),
//       ),
//       actions: [
//         search
//             ? IconButton(
//             onPressed: () {
//               setState(() {
//                 search = false;
//               });
//             },
//             icon: const Icon(
//               Icons.cancel_outlined,
//               size: 30.0,
//             ))
//             : IconButton(
//             onPressed: () {
//               setState(() {
//                 search = true;
//               });
//             },
//             icon: const Icon(
//               Icons.search,
//               size: 30.0,
//             )),
//       ],
//       headerWidget: Container(
//         color: const Color(0xFF337A6F),
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 10.0),
//           child: Column(
//             children: [
//               SizedBox(
//                 height: MediaQuery.of(context).size.height / 27,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Row(
//                     children: [
//                       CircleAvatar(
//                         backgroundColor: const Color(0xFF337A6F),
//                         radius: 40,
//                         child: ClipOval(
//                           child: Image.asset('assets/logo/logo.jpg'),
//                         ),
//                       ),
//                       const Text(
//                         'Happy Shop',
//                         style: TextStyle(
//                             color: Colors.black87,
//                             fontWeight: FontWeight.bold,
//                             fontSize: 16.0),
//                       )
//                     ],
//                   ),
//                   FloatingActionButton(
//                     onPressed: () {
//                       // Add your onPressed code here
//                     },
//                     child: const Icon(
//                       Icons.chat,
//                       color: Colors.white,
//                     ),
//                     backgroundColor: const Color(0xFF337A6F),
//                   ),
//                 ],
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Container(
//                       decoration: BoxDecoration(
//                           color: Colors.white,
//                           border: Border.all(
//                             color: const Color(0xFF337A6F),
//                           ),
//                           borderRadius:
//                           const BorderRadius.all(Radius.circular(20))),
//                       child: SizedBox(
//                           height: MediaQuery.of(context).size.height / 9,
//                           width: MediaQuery.of(context).size.width / 2.1,
//                           child: Padding(
//                             padding:
//                             const EdgeInsets.symmetric(horizontal: 8.0),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceAround,
//                               children: [
//                                 Column(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     Text(
//                                       "Today's sales",
//                                       style: TextStyle(
//                                           fontWeight: FontWeight.bold,
//                                           fontSize: MediaQuery.of(context)
//                                               .size
//                                               .width *
//                                               0.05),
//                                     ),
//                                     const Text(
//                                       'Mauzo ya leo',
//                                       style: TextStyle(
//                                         fontStyle: FontStyle.italic,
//                                       ),
//                                     ),
//                                     Padding(
//                                       padding: const EdgeInsets.symmetric(
//                                           vertical: 5.0),
//                                       child: Text(
//                                         'Tsh. 120,300',
//                                         style: TextStyle(
//                                             fontWeight: FontWeight.bold,
//                                             color: Colors.green,
//                                             fontSize: MediaQuery.of(context)
//                                                 .size
//                                                 .width *
//                                                 0.04),
//                                       ),
//                                     )
//                                   ],
//                                 ),
//                                 Row(
//                                   children: [
//                                     Icon(
//                                       Icons.arrow_upward,
//                                       size: MediaQuery.of(context).size.width *
//                                           0.05,
//                                       color: Colors.green,
//                                     ),
//                                     const Text(
//                                       '10%',
//                                       style: TextStyle(
//                                         color: Colors.green,
//                                       ),
//                                     )
//                                   ],
//                                 )
//                               ],
//                             ),
//                           ))),
//                   Container(
//                       decoration: BoxDecoration(
//                           color: Colors.white,
//                           border: Border.all(
//                             color: const Color(0xFF337A6F),
//                           ),
//                           borderRadius:
//                           const BorderRadius.all(Radius.circular(20))),
//                       child: SizedBox(
//                           height: MediaQuery.of(context).size.height / 9,
//                           width: MediaQuery.of(context).size.width / 2.3,
//                           child: Center(
//                               child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   Text(
//                                     'Stock out',
//                                     style: TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                         fontSize:
//                                         MediaQuery.of(context).size.width *
//                                             0.05),
//                                   ),
//                                   const Text(
//                                     'Bidhaa zilizouzwa',
//                                     style: TextStyle(
//                                       fontStyle: FontStyle.italic,
//                                     ),
//                                   ),
//                                   Padding(
//                                     padding:
//                                     const EdgeInsets.symmetric(vertical: 5.0),
//                                     child: Text(
//                                       ': 103',
//                                       style: TextStyle(
//                                           color: Colors.green,
//                                           fontWeight: FontWeight.bold,
//                                           fontSize:
//                                           MediaQuery.of(context).size.width *
//                                               0.04),
//                                     ),
//                                   )
//                                 ],
//                               )))),
//                 ],
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 8.0),
//                 child: SizedBox(
//                   height: 30.0,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: <Widget>[
//                       SizedBox(
//                         height: 30.0,
//                         width: 90.0,
//                         child: OpenContainer(
//                           closedColor: Colors.white,
//                           openColor: const Color(0xFF337A6F),
//                           closedElevation: 5.0,
//                           openElevation: 0.0,
//                           closedShape: const RoundedRectangleBorder(
//                             borderRadius:
//                             BorderRadius.all(Radius.circular(10.0)),
//                           ),
//                           transitionType: ContainerTransitionType.fade,
//                           transitionDuration: const Duration(milliseconds: 600),
//                           openBuilder: (context, action) {
//                             return const addItem();
//                           },
//                           closedBuilder: (context, action) {
//                             return Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: const [
//                                 Icon(
//                                   Icons.add_shopping_cart,
//                                   size: 20.0,
//                                   color: Color(0xFF337A6F),
//                                 ),
//                                 Text(
//                                   'Add item',
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     color: Color(0xFF337A6F),
//                                   ),
//                                 )
//                               ],
//                             );
//                           },
//                         ),
//                       ),
//                       ElevatedButton(
//                         onPressed: () {
//                           setState(() {
//                             activeButton = 0;
//                           });
//                         },
//                         child: Text(
//                           'All',
//                           style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             color: activeButton == 0
//                                 ? const Color(0xFF337A6F)
//                                 : Colors.black87,
//                           ),
//                         ),
//                         style: ElevatedButton.styleFrom(
//                           onPrimary: activeButton == 0
//                               ? const Color(0xFF337A6F)
//                               : Colors.white,
//                           primary: activeButton == 0
//                               ? Colors.white
//                               : const Color(0xFF337A6F),
//                           shape: const StadiumBorder(),
//                           elevation: 10,
//                         ),
//                       ),
//                       ElevatedButton(
//                         onPressed: () {
//                           setState(() {
//                             activeButton = 1;
//                           });
//                         },
//                         child: Text(
//                           'Products',
//                           style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             color: activeButton == 1
//                                 ? const Color(0xFF337A6F)
//                                 : Colors.black87,
//                           ),
//                         ),
//                         style: ElevatedButton.styleFrom(
//                           onPrimary: activeButton == 1
//                               ? const Color(0xFF337A6F)
//                               : Colors.white,
//                           primary: activeButton == 1
//                               ? Colors.white
//                               : const Color(0xFF337A6F),
//                           shape: const StadiumBorder(),
//                           elevation: 10,
//                         ),
//                       ),
//                       ElevatedButton(
//                         onPressed: () {
//                           setState(() {
//                             activeButton = 2;
//                           });
//                         },
//                         child: Text(
//                           'Services',
//                           style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             color: activeButton == 2
//                                 ? const Color(0xFF337A6F)
//                                 : Colors.black87,
//                           ),
//                         ),
//                         style: ElevatedButton.styleFrom(
//                           onPrimary: activeButton == 2
//                               ? const Color(0xFF337A6F)
//                               : Colors.white,
//                           primary: activeButton == 2
//                               ? Colors.white
//                               : const Color(0xFF337A6F),
//                           shape: const StadiumBorder(),
//                           elevation: 10,
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//       body: [
//         ListView.builder(
//           padding: const EdgeInsets.only(top: 0),
//           physics: const NeverScrollableScrollPhysics(),
//           addAutomaticKeepAlives: true,
//           reverse: true,
//           cacheExtent: 100.0,
//           itemCount: 30,
//           shrinkWrap: true,
//           dragStartBehavior: DragStartBehavior.start,
//           itemBuilder: (context, index) => SizedBox(
//             height: MediaQuery.of(context).size.height / 7,
//             child: Slidable(
//               // Specify a key if the Slidable is dismissible.
//               key: Key('$index'),

//               startActionPane: ActionPane(
//                 dragDismissible: false,
//                 // A motion is a widget used to control how the pane animates.
//                 motion: const ScrollMotion(),

//                 // A pane can dismiss the Slidable.
//                 dismissible: DismissiblePane(onDismissed: () {}),

//                 // All actions are defined in the children parameter.
//                 children: const [
//                   // A SlidableAction can have an icon and/or a label.
//                   SlidableAction(
//                     onPressed: null,
//                     backgroundColor: Colors.white,
//                     foregroundColor: Color(0xFF337A6F),
//                     icon: Icons.add_shopping_cart,
//                     label: 'Purchase',
//                   ),
//                   SlidableAction(
//                     onPressed: null,
//                     backgroundColor: Colors.white,
//                     foregroundColor: Color(0xFF337A6F),
//                     icon: Icons.edit,
//                     label: 'Edit item',
//                   ),
//                 ],
//               ),

//               // The end action pane is the one at the right or the bottom side.
//               endActionPane: const ActionPane(
//                 motion: ScrollMotion(),
//                 children: [
//                   SlidableAction(
//                     // An action can be bigger than the others.
//                     flex: 2,
//                     onPressed: null,
//                     backgroundColor: Colors.white,
//                     foregroundColor: Color(0xFF337A6F),
//                     icon: Icons.monetization_on_outlined,
//                     label: 'Sale',
//                   ),
//                   SlidableAction(
//                     flex: 2,
//                     onPressed: null,
//                     backgroundColor: Colors.white,
//                     foregroundColor: Color(0xFFD00000),
//                     icon: Icons.money_off_csred_sharp,
//                     label: 'Return',
//                   ),
//                 ],
//               ),

//               // The child of the Slidable is what the user sees when the
//               // component is not dragged.
//               child: OpenContainer(
//                 closedColor: Colors.white,
//                 openColor: const Color(0xFF337A6F),
//                 closedElevation: 0.0,
//                 openElevation: 0.0,
//                 closedShape: const RoundedRectangleBorder(
//                   borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                 ),
//                 transitionType: ContainerTransitionType.fade,
//                 transitionDuration: const Duration(milliseconds: 1000),
//                 openBuilder: (context, action) {
//                   return const viewProduct(
//                     image: 'assets/items/fanta.jpg',
//                   );
//                 },
//                 closedBuilder: (context, action) {
//                   return Card(
//                     elevation: 2.5,
//                     color: Colors.white,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(20.0),
//                     ),
//                     child: ListTile(
//                       selectedTileColor: const Color(0xFF337A6F),
//                       leading: GestureDetector(
//                         child: ClipRRect(
//                           borderRadius: BorderRadius.circular(16.0),
//                           child: Image.asset(
//                             'assets/items/fanta.jpg',
//                             height: 200.0,
//                           ),
//                         ),
//                       ),
//                       title: const Text(
//                         "Cocacola zero",
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       subtitle: const Text("Quantity: 6"),
//                       trailing: const Text(
//                         "Tsh 34000",
//                         style: TextStyle(fontWeight: FontWeight.bold),
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ),
//         ),
//       ],
//       fullyStretchable: true,
//       expandedBody: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const Text(
//                 'Welcome to smatpad CAL',
//                 style: TextStyle(
//                     fontSize: 21.0,
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold),
//               ),
//               SizedBox(
//                 height: MediaQuery.of(context).size.height / 15,
//               ),
//               SizedBox(
//                 height: MediaQuery.of(context).size.height / 22,
//                 width: MediaQuery.of(context).size.width / 3.0,
//                 child: OpenContainer(
//                   closedColor: Colors.white,
//                   openColor: const Color(0xFF337A6F),
//                   closedElevation: 2.0,
//                   openElevation: 0.0,
//                   closedShape: const RoundedRectangleBorder(
//                     borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                   ),
//                   transitionType: ContainerTransitionType.fade,
//                   transitionDuration: const Duration(milliseconds: 1000),
//                   openBuilder: (context, action) {
//                     return CalcButton();
//                   },
//                   closedBuilder: (context, action) {
//                     return Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         const Icon(
//                           Icons.calculate_outlined,
//                           size: 20.0,
//                           color: Color(0xFF337A6F),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                           child: Text(
//                             'Calculate',
//                             style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               color: activeButton == 0
//                                   ? const Color(0xFF337A6F)
//                                   : Colors.black54,
//                             ),
//                           ),
//                         )
//                       ],
//                     );
//                   },
//                 ),
//               ),
//             ],
//           )),
//     );
//   }
// }
