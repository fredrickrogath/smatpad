import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:smatpad/db/items_database.dart';
import 'package:smatpad/model/item.dart';

class addItem extends StatefulWidget {
  const addItem({Key? key}) : super(key: key);

  @override
  _addItemState createState() => _addItemState();
}

class _addItemState extends State<addItem> {
  var activeButton = 'product';
  var expireDate;
  var stockDate;
  late FToast fToast;

  String itemName = '';
  // String imagePath = '';
  String itemUnit = '';
  String itemCode = '';
  String itemExpiry = '';
  String itemQuantity = '';
  String itemSalePrice = '';
  String itemPurchasePrice = '';

  final _formKey = GlobalKey<FormState>();

  void addOrUpdateItem() async {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      await addNewItem();
    }
  }

  Future addNewItem() async {
    final item = Item(
        name: itemName,
        expiry: expireDate ?? itemExpiry,
        quantity: double.parse(itemQuantity),
        category: activeButton,
        item_code: itemCode,
        created_at: DateTime.now(),
        aboutItem: 'Soft drink from pepsi company',
        image_path: 'assets/items/sprite.jpg',
        sale_price: double.parse(itemSalePrice),
        primary_unit: 'Bottle',
        secondary_unit: 'Crate',
        purchase_price: double.parse(itemPurchasePrice),
        primary_unit_cost: 500.0,
        secondary_unit_cost: 12000.0);

    await itemsDatabase.instance.create(item);

    Navigator.of(context).pop();
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
          Text("ell Units set successfully"),
        ],
      ),
    );

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: const Duration(seconds: 2),
    );

    @override
    void initState() {
      // TODO: implement initState
      super.initState();
      fToast = FToast();
      fToast.init(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
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
              Icons.arrow_back_ios,
              color: Colors.black,
              size: 20.0,
            ),
          ),
          title: const Text(
            'Add New Item',
            style: TextStyle(color: Colors.black, fontSize: 16.0),
          ),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.transparent,
                elevation: 0.0,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.settings_rounded,
                color: Colors.black,
                size: 20.0,
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Column(children: [
                    buildItemCategory(),
                    buildItemNameAndItemImage(),
                    buildItemCodeAndUnit(),
                    buildItemQuantityAndExpiry(),
                    buildItemSalesPriceAndItemPurchasePrice(),
                    SizedBox(height: MediaQuery.of(context).size.height / 35),
                    buildDivider(),
                    buildAvailableStock(),
                    buildPricePerUnitStockLevel(),
                  ])
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: buildSubmitCancel(),
      ),
    );
  }

  Widget buildItemQuantityAndExpiry() => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: TextFormField(
              autofocus: false,
              decoration: InputDecoration(
                  // border: OutlineInputBorder(
                  //   borderRadius: BorderRadius.circular(10.0),
                  // ),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 0.0,
                  ),
                  filled: true,
                  hintStyle: TextStyle(
                      color: Colors.grey[800],
                      fontWeight: FontWeight.w500,
                      fontSize: 12),
                  hintText: "Item quantity",
                  fillColor: Colors.white70),
              onChanged: (value) => setState(
                () {
                  itemQuantity = value;
                },
              ),
              // The validator receives the text that the user has entered.
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter Item quantity';
                }
                return null;
              },
            ),
          ),
        ),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 10.0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width / 3.5,
            height: MediaQuery.of(context).size.height / 22,
            child: ElevatedButton(
              child: Text(
                expireDate == null ? 'Expiry Date' : '$expireDate',
                style: const TextStyle(
                    fontSize: 12,
                    // fontWeight: FontWeight.w900,
                    color: Color(0xFFE3F2FD)),
              ),
              onPressed: () async {
                DatePicker.showDatePicker(context,
                    showTitleActions: true,
                    minTime: DateTime(2022, 1, 5),
                    maxTime: DateTime(3000, 12, 31),
                    theme: const DatePickerTheme(
                        headerColor: Color(0xFF337A6F),
                        backgroundColor: Color(0xFF337A6F),
                        itemStyle: TextStyle(
                            color: Color(0xFFE3F2FD),
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                        doneStyle:
                            TextStyle(color: Colors.white, fontSize: 16)),
                    onChanged: (date) {
                  setState(() {
                    expireDate = DateFormat.yMMMd().format(date);
                  });
                }, onConfirm: (date) {
                  setState(() {
                    expireDate = DateFormat.yMMMd().format(date);
                  });
                }, currentTime: DateTime.now(), locale: LocaleType.en);

                FocusScope.of(context).requestFocus(FocusNode());
              },
              style: ElevatedButton.styleFrom(
                elevation: 0.0,
              ),
            ),
          ),
        ))
      ]));

  Widget buildItemNameAndItemImage() => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: TextFormField(
              autofocus: false,
              decoration: InputDecoration(
                  // border: OutlineInputBorder(
                  //   borderRadius: BorderRadius.circular(10.0),
                  // ),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 0.0,
                  ),
                  filled: true,
                  hintStyle: TextStyle(
                      color: Colors.grey[800],
                      fontWeight: FontWeight.w500,
                      fontSize: 12),
                  hintText: "Item name",
                  fillColor: Colors.white70),
              onChanged: (value) => setState(
                () {
                  itemName = value;
                },
              ),
              // The validator receives the text that the user has entered.
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter Item name';
                }
                return null;
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 3.5,
              height: MediaQuery.of(context).size.height / 24,
              child: ElevatedButton(
                child: Text(
                  expireDate == null ? 'Upload image' : 'Image set',
                  style: const TextStyle(
                      fontSize: 12,
                      // fontWeight: FontWeight.w900,
                      color: Color(0xFFE3F2FD)),
                ),
                onPressed: () async {
                  DatePicker.showDatePicker(context,
                      showTitleActions: true,
                      minTime: DateTime(2022, 1, 5),
                      maxTime: DateTime(3000, 12, 31),
                      theme: const DatePickerTheme(
                          headerColor: Color(0xFF337A6F),
                          backgroundColor: Color(0xFF337A6F),
                          itemStyle: TextStyle(
                              color: Color(0xFFE3F2FD),
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                          doneStyle:
                              TextStyle(color: Colors.white, fontSize: 16)),
                      onChanged: (date) {
                    setState(() {
                      expireDate = DateFormat.yMMMd().format(date);
                    });
                  }, onConfirm: (date) {
                    setState(() {
                      expireDate = DateFormat.yMMMd().format(date);
                    });
                  }, currentTime: DateTime.now(), locale: LocaleType.en);

                  FocusScope.of(context).requestFocus(FocusNode());
                },
                style: ElevatedButton.styleFrom(
                  elevation: 0.0,
                ),
              ),
            ),
          ),
        ),
      ]));

  Widget buildItemCategory() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 24,
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  activeButton = 'product';
                });
              },
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Icon(Icons.circle_outlined,
                        size: 20.0,
                        color: activeButton == 'product'
                            ? Colors.white
                            : Colors.black),
                  ),
                  Text(
                    'Product',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      color: activeButton == 'product'
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                ],
              ),
              style: ElevatedButton.styleFrom(
                onPrimary: activeButton == 'Product'
                    ? Colors.white
                    : const Color(0xFF337A6F),
                primary: activeButton == 'product'
                    ? const Color(0xFF337A6F)
                    : Colors.white,
                shape: const StadiumBorder(),
                elevation: 0.0,
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 24,
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  activeButton = 'service';
                });
              },
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Icon(Icons.circle_outlined,
                        size: 20.0,
                        color: activeButton == 'service'
                            ? Colors.white
                            : Colors.black),
                  ),
                  Text(
                    'Service',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      color: activeButton == 'service'
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                ],
              ),
              style: ElevatedButton.styleFrom(
                onPrimary: activeButton == 'service'
                    ? Colors.white
                    : const Color(0xFF337A6F),
                primary: activeButton == 'service'
                    ? const Color(0xFF337A6F)
                    : Colors.white,
                shape: const StadiumBorder(),
                elevation: 0.0,
              ),
            ),
          ),
        ],
      );

  Widget buildItemSalesPriceAndItemPurchasePrice() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Row(children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: TextFormField(
                autofocus: false,
                decoration: InputDecoration(
                    // border: OutlineInputBorder(
                    //   borderRadius: BorderRadius.circular(10.0),
                    // ),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 0.0,
                    ),
                    filled: true,
                    hintStyle: TextStyle(
                        color: Colors.grey[800],
                        fontWeight: FontWeight.w500,
                        fontSize: 12),
                    hintText: "Sales price",
                    fillColor: Colors.white70),
                onChanged: (value) => setState(
                  () {
                    itemSalePrice = value;
                  },
                ),
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Sales price';
                  }
                  return null;
                },
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 10.0),
              child: TextFormField(
                autofocus: false,
                decoration: InputDecoration(
                    // border: OutlineInputBorder(
                    //   borderRadius: BorderRadius.circular(10.0),
                    // ),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 0.0,
                    ),
                    filled: true,
                    hintStyle: TextStyle(
                        color: Colors.grey[800],
                        fontWeight: FontWeight.w500,
                        fontSize: 12),
                    hintText: "Purchase price",
                    fillColor: Colors.white70),
                onChanged: (value) => setState(
                  () {
                    itemPurchasePrice = value;
                  },
                ),
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Purchase price';
                  }
                  return null;
                },
              ),
            ),
          )
        ]),
      );

  Widget buildItemCodeAndUnit() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 16.0, horizontal: 10.0),
                child: TextFormField(
                  autofocus: false,
                  decoration: InputDecoration(
                      // border: OutlineInputBorder(
                      //   borderRadius: BorderRadius.circular(10.0),
                      // ),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 0.0,
                      ),
                      filled: true,
                      hintStyle: TextStyle(
                          color: Colors.grey[800],
                          fontWeight: FontWeight.w500,
                          fontSize: 12),
                      hintText: "Item code",
                      fillColor: Colors.white70),
                  onChanged: (value) => setState(
                    () {
                      itemCode = value;
                    },
                  ),
                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Item code';
                    }
                    return null;
                  },
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width / 5,
                  height: MediaQuery.of(context).size.height / 24,
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
                        descStyle: const TextStyle(fontWeight: FontWeight.bold),
                        descTextAlign: TextAlign.start,
                        animationDuration: const Duration(milliseconds: 700),
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
                                      MediaQuery.of(context).size.height / 23),
                              SizedBox(
                                height: MediaQuery.of(context).size.height / 12,
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
                              SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 23),
                              SizedBox(
                                height: MediaQuery.of(context).size.height / 12,
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
            ),
          ],
        ),
      );

  Widget buildDivider() => const Text(
        'Stock (Optional)',
        style: TextStyle(
            color: Colors.black87,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w400),
      );

  Widget buildAvailableStock() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Row(children: [
          Expanded(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 10.0),
              child: TextFormField(
                decoration: InputDecoration(
                    // border: OutlineInputBorder(
                    //   borderRadius: BorderRadius.circular(10.0),
                    // ),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 0.0,
                    ),
                    filled: true,
                    hintStyle: TextStyle(
                        color: Colors.grey[800],
                        fontWeight: FontWeight.w500,
                        fontSize: 12),
                    hintText: "Available stock",
                    fillColor: Colors.white70),
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    // return 'Please enter Sales price';
                    return null;
                  }
                  return null;
                },
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: SizedBox(
                height: MediaQuery.of(context).size.height / 24,
                child: ElevatedButton(
                  child: Text(
                    expireDate == null ? 'Set Stock Date' : '$expireDate',
                    style: const TextStyle(
                        fontSize: 12,
                        // fontWeight: FontWeight.w900,
                        color: Color(0xFFE3F2FD)),
                  ),
                  onPressed: () async {
                    DatePicker.showDatePicker(context,
                        showTitleActions: true,
                        minTime: DateTime(2022, 1, 5),
                        maxTime: DateTime(3000, 12, 31),
                        theme: const DatePickerTheme(
                            headerColor: Color(0xFF337A6F),
                            backgroundColor: Color(0xFF337A6F),
                            itemStyle: TextStyle(
                                color: Color(0xFFE3F2FD),
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                            doneStyle:
                                TextStyle(color: Colors.white, fontSize: 16)),
                        onChanged: (date) {
                      setState(() {
                        stockDate = DateFormat.yMMMd().format(date);
                      });
                    }, onConfirm: (date) {
                      setState(() {
                        stockDate = DateFormat.yMMMd().format(date);
                      });
                    }, currentTime: DateTime.now(), locale: LocaleType.en);

                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 0.0,
                  ),
                ),
              ),
            ),
          )
        ]),
      );

  Widget buildPricePerUnitStockLevel() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Row(children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: TextFormField(
                autofocus: false,
                decoration: InputDecoration(
                    // border: OutlineInputBorder(
                    //   borderRadius: BorderRadius.circular(10.0),
                    // ),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 0.0,
                    ),
                    filled: true,
                    hintStyle: TextStyle(
                        color: Colors.grey[800],
                        fontWeight: FontWeight.w500,
                        fontSize: 12),
                    hintText: "Price Per Unit",
                    fillColor: Colors.white70),
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    // return 'Please enter Sales price';
                    return null;
                  }
                  return null;
                },
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 10.0),
              child: TextFormField(
                autofocus: false,
                decoration: InputDecoration(
                    // border: OutlineInputBorder(
                    //   borderRadius: BorderRadius.circular(10.0),
                    // ),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 0.0,
                    ),
                    filled: true,
                    hintStyle: TextStyle(
                        color: Colors.grey[800],
                        fontWeight: FontWeight.w500,
                        fontSize: 12),
                    hintText: "Stock Level",
                    fillColor: Colors.white70),
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    // return 'Please enter Sales price';
                    return null;
                  }
                  return null;
                },
              ),
            ),
          )
        ]),
      );

  Widget buildSubmitCancel() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Row(children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'Cancel',
                  style: TextStyle(color: Color(0xFF337A6F)),
                ),
                style: ElevatedButton.styleFrom(
                  onPrimary: Colors.white,
                  primary: Colors.white,
                  // shape: const StadiumBorder(),
                  elevation: 1.0,
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  // Validate returns true if the form is valid, or false otherwise.
                  if (_formKey.currentState!.validate()) {
                    // If the form is valid, display a snackbar. In the real world,
                    // you'd often call a server or save the information in a database.
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Processing Data')),
                    );
                    addNewItem();
                  }
                },
                child: const Text('Submit'),
                style: ElevatedButton.styleFrom(
                  // onPrimary: Colors.white,
                  // primary: Colors.white,
                  // shape: const StadiumBorder(),
                  elevation: 1.0,
                ),
              ),
            ),
          )
        ]),
      );
}
