import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:smatpad/db/items_database.dart';
import 'package:smatpad/model/item.dart';

class Sale extends StatefulWidget {
  const Sale({Key? key}) : super(key: key);

  @override
  _SaleState createState() => _SaleState();
}

class _SaleState extends State<Sale> {
  var activeButton = 'product';
  String saleDate = DateFormat.yMMMd().format(DateTime.now());
  var expireDate;
  var stockDate;
  double heightFrame = 0;
  double widthFrame = 0;
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

  // void addOrUpdateItem() async {
  //   final isValid = _formKey.currentState!.validate();
  //   if (isValid) {
  //     await addNewItem();
  //   }
  // }

  // Future addNewItem() async {
  //   final item = Item(
  //       name: itemName,
  //       expiry: expireDate ?? itemExpiry,
  //       quantity: double.parse(itemQuantity),
  //       category: activeButton,
  //       item_code: itemCode,
  //       created_at: DateTime.now(),
  //       aboutItem: 'Soft drink from pepsi company',
  //       image_path: 'assets/items/sprite.jpg',
  //       sale_price: double.parse(itemSalePrice),
  //       primary_unit: 'Bottle',
  //       secondary_unit: 'Crate',
  //       purchase_price: double.parse(itemPurchasePrice),
  //       primary_unit_cost: 500.0,
  //       secondary_unit_cost: 12000.0);

  //   await itemsDatabase.instance.create(item);

  //   Navigator.of(context).pop();
  // }

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
    heightFrame = MediaQuery.of(context).size.height;
    widthFrame = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
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
              Icons.arrow_forward_ios,
              color: Colors.black,
              size: 20.0,
            ),
          ),
          title: const Text(
            'New Sale',
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
                    buildSaleCategory(),
                    buildReceiptNoAndSaleTime(),
                    buildCutomerName(),
                    buildAddItem(),
                    buildDiscount(),
                    // buildItemQuantityAndExpiry(),
                    // buildItemSalesPriceAndItemPurchasePrice(),
                    // SizedBox(height: MediaQuery.of(context).size.height / 35),
                    // buildDivider(),
                    // buildAvailableStock(),
                    // buildPricePerUnitStockLevel(),
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

  Widget buildSaleCategory() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: heightFrame / 24,
            width: widthFrame / 2.5,
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
                    'Credit',
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
            height: heightFrame / 24,
            width: widthFrame / 2.5,
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
                    'Cash',
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

  Widget buildReceiptNoAndSaleTime() => Padding(
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
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 0.0,
                  ),
                  filled: true,
                  hintStyle: TextStyle(
                      color: Colors.grey[800],
                      fontWeight: FontWeight.w500,
                      fontSize: 14),
                  hintText: 'Receipt No :' + DateTime.now().toIso8601String(),
                  fillColor: Colors.white70),
              onChanged: (value) => setState(
                () {
                  itemName = DateTime.now().toIso8601String();
                },
              ),
              // The validator receives the text that the user has entered.
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '';
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
              width: widthFrame / 3.5,
              height: heightFrame / 24,
              child: ElevatedButton(
                child: Text(
                  saleDate,
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
                      saleDate = DateFormat.yMMMd().format(date);
                    });
                  }, onConfirm: (date) {
                    setState(() {
                      saleDate = DateFormat.yMMMd().format(date);
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

  Widget buildCutomerName() => Padding(
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
                  hintText: "Customer Name ( Optional )",
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
      ]));

  Widget buildAddItem() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Row(children: [
          Expanded(
              child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 10.0),
            child: SizedBox(
              width: widthFrame / 3.5,
              height: heightFrame / 22,
              child: FloatingActionButton.extended(
                elevation: 0.0,
                onPressed: () {
                  // Add your onPressed code here!
                },
                label: Text('Add Items ( Optional )'),
                icon: const Icon(Icons.add_shopping_cart, size: 20.0),
                backgroundColor: const Color(0xFF337A6F),
              ),
            ),
          ))
        ]),
      );

  Widget buildDiscount() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text('Discount'),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 16.0, horizontal: 10.0),
                child: SizedBox(
                  height: heightFrame / 24,
                  child: TextFormField(
                    autofocus: false,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        prefixIcon: Container(
                          decoration: BoxDecoration(
                              border: Border.all(),
                              color: Color.fromARGB(255, 249, 194, 190),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                           // background color
                          child: Icon(Icons.percent_outlined,
                              color: const Color(0xFFef233c)), // icon
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 0.0,
                        ),
                        filled: true,
                        // hintStyle: TextStyle(
                        //     color: Colors.grey[800],
                        //     fontWeight: FontWeight.w500,
                        //     fontSize: 12),
                        // hintText: "Item code",
                        fillColor: Colors.white70),
                    onChanged: (value) => setState(
                      () {
                        itemCode = value;
                      },
                    ),
                    // The validator receives the text that the user has entered.
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '';
                      }
                      return null;
                    },
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 16.0, horizontal: 10.0),
                child: SizedBox(
                  height: heightFrame / 24,
                  child: TextFormField(
                    autofocus: false,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        prefixIcon: Container(
                          decoration: BoxDecoration(
                              border: Border.all(),
                              color: Color.fromARGB(255, 249, 194, 190),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                           // background color
                          child: Icon(Icons.percent_outlined,
                              color: const Color(0xFFef233c)), // icon
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 0.0,
                        ),
                        filled: true,
                        // hintStyle: TextStyle(
                        //     color: Colors.grey[800],
                        //     fontWeight: FontWeight.w500,
                        //     fontSize: 12),
                        // hintText: "Item code",
                        fillColor: Colors.white70),
                    onChanged: (value) => setState(
                      () {
                        itemCode = value;
                      },
                    ),
                    // The validator receives the text that the user has entered.
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '';
                      }
                      return null;
                    },
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
                height: heightFrame / 24,
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
                    // addNewItem();
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
