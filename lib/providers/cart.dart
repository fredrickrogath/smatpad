import 'package:flutter/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smatpad/model/cart.dart';

class CartDisplay extends ChangeNotifier {
  //contains all items added to the cart
  List<Cart> cartItems = [];

  int specificItemCount = 0;

  // get total count of items added to cart
  int get getItemCount => cartItems.length;

  //get list of items added to cart
  List get getItemList => cartItems;

  // add items to cart function
  addItemsToCart(id, name, category, imagePath, salePrice) {
    Cart cart = Cart(
        id: id,
        name: name,
        count: 1,
        category: category,
        image_path: imagePath,
        sale_price: salePrice);

    cartItems.add(cart);
    notifyListeners();
  }

  updateItemCount(itemId, action) {
    var itemToUpdate = cartItems.singleWhere((item) => item.id == itemId);
    itemToUpdate.count >= 0 && action == 'add'
        ? itemToUpdate.count++
        : itemToUpdate.count <= 1 && action == 'remove'
            ? itemToUpdate.count = 0
            : itemToUpdate.count--;
            
    notifyListeners();
  }

  hardUpdateItemCount(itemId, action, gap) {
    var itemToUpdate = cartItems.singleWhere((item) => item.id == itemId);
    itemToUpdate.count >= 0 && action == 'add'
        ? itemToUpdate.count = itemToUpdate.count + int.parse(gap)
        : itemToUpdate.count <= 1 && action == 'remove'
            ? itemToUpdate.count = 0
            : itemToUpdate.count = itemToUpdate.count - int.parse(gap);

    itemToUpdate.count <= 0
        ? itemToUpdate.count = 0
        : itemToUpdate.count = itemToUpdate.count;

    notifyListeners();
  }

  resetItemCount(itemId) {
    cartItems.removeWhere((item) => item.id == itemId);
  }

  getSingleItem(itemId) {
    for (int i = 0; i < cartItems.length; i++) {
      if (cartItems[i].id == itemId) {
        return cartItems[i].count.toString().padLeft(2, '0');
      }
    }
  }

  getNumberOfAllOrders() {
    var orderNumber = 0;
    for (var i = 0; i < cartItems.length; i++) {
      orderNumber += cartItems[i].count;
    }
    return orderNumber.toString().padLeft(2, '0');
  }

  getNumberOfProducts() {
    var numberOfProducts = 0;
    for (var i = 0; i < cartItems.length; i++) {
      if (cartItems[i].category == "product") {
        numberOfProducts += cartItems[i].count;
      }
    }
    return numberOfProducts.toString().padLeft(2, '0');
  }

  getNumberOfServices() {
    var numberOfServices = 0;
    for (var i = 0; i < cartItems.length; i++) {
      if (cartItems[i].category == "service") {
        numberOfServices += cartItems[i].count;
      }
    }
    return numberOfServices.toString().padLeft(2, '0');
  }

  totalCost() {
    double totalCost = 0;
    for (var i = 0; i < cartItems.length; i++) {
      totalCost += cartItems[i].sale_price * cartItems[i].count;
    }
    return totalCost;
  }

  clearCart() {
    cartItems.clear();

    notifyListeners();
  }

  removeItemFromCart(itemId) {
    var itemToUpdate = cartItems.singleWhere((item) => item.id == itemId);
    itemToUpdate.count = 0;
    resetItemCount(itemId);
    notifyListeners();
  }
}
