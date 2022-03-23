import 'package:flutter/material.dart';

import 'db/items_database.dart';
import 'model/item.dart';

class itemsPage extends StatefulWidget {
  const itemsPage({Key? key}) : super(key: key);

  @override
  _itemsPageState createState() => _itemsPageState();
}

class _itemsPageState extends State<itemsPage> {
  List _items = [];
  bool isLoading = false;

  Future addItem() async {
    final item = Item(
        name: 'coca cola',
        expiry: '02-02-2020',
        quantity: 49,
        category: 'product',
        item_code: '2332442',
        created_at: DateTime.now(),
        aboutItem: 'Soft drink from cocacola company',
        image_path: 'assets/logo/logo.jpg',
        sale_price: 500.0,
        primary_unit: 'Bottle',
        secondary_unit: 'Crate',
        purchase_price: 10000.0,
        primary_unit_cost: 500.0,
        secondary_unit_cost: 12000.0);

    await itemsDatabase.instance.create(item);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // addItem();
    refreshItems();
    // _items = items;
    // print(items);
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
    this._items = await itemsDatabase.instance.readAllItems();
    this._items = this._items.reversed.toList();

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      // body: Center(
      //   child: Column(
      //     children: [
      //       Text('${items?.length}'),
      //       Text('${items}'),
      //     ],
      //   ),
      // ),
      body: ListView.builder(
        // Let the ListView know how many items it needs to build.
        itemCount: _items.length,
        // Provide a builder function. This is where the magic happens.
        // Convert each item into a widget based on the type of item it is.
        itemBuilder: (context, index) {
          final _item = _items[index];

          return ListTile(
            title: Text('${_item.name}'),
            subtitle: Text('${_item.created_at}'),
          );
        },
      ),
    );
  }
}
