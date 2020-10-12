

import 'package:flutter/cupertino.dart';
import 'package:shopper_nithin/models/catalog.dart';

class CartModel extends ChangeNotifier{
  CatalogModel _catalog;
  final List<int> _itemIds = [];

  CatalogModel get catalog => _catalog;

  /// commenting setter method 'catalog' for now
  set catalog(CatalogModel newCatalog) { //// catalog is also the setter method which is setting the field catalog and it's
    //arguement is an object of type CatalogModel
    assert(newCatalog != null);
    assert(_itemIds.every((id) => newCatalog.getById(id) != null), // bool every ( bool test( E element ) )--- Checks whether
    // every element of this iterable satisfies the specified test. Here all the _itemIds are being validated if they are already
    //present in the newcatalog. If the newCatalog has a new item, then proceed to the below steps.
    'The catalog $newCatalog does not have one of $_itemIds in it.');
    _catalog = newCatalog;
    // Notify listeners, in case the new catalog provides information
    // different from the previous one. For example, availability of an item
    // might have changed.
    notifyListeners();
  }

  /// List of items in the cart.
  List<Item> get items => _itemIds.map((id) => _catalog.getById(id)).toList(); // map method --> for each 'id' in _itemIds call
// the _catalog.getById function

  /// The current total price of all items.
  int get totalPrice =>  // totalPrice is a getter method which returns totalPrice field of int type
  items.fold(0, (total, current) => total + current.price); // iterable.fold method -- Reduces a collection to a single value by
// iteratively combining each element of the collection with an existing value

  void add(Item item) {
    _itemIds.add(item.id);
    // This line tells [Model] that it should rebuild the widgets that
    // depend on it.
    notifyListeners();
  }

}