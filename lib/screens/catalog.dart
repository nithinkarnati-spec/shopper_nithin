
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopper_nithin/models/cart.dart';
import 'package:shopper_nithin/models/catalog.dart';

class MyCatalog extends StatelessWidget{
  @override
Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _MyAppBar(),
          SliverToBoxAdapter(child: SizedBox(height: 12)),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                    (context, index) => _MyListItem(index)),
          ),
        ],
      ),
    );
  }
}

class _MyAppBar extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return SliverAppBar(
     title:Text('Catalog', style: Theme.of(context).textTheme.headline1) ,
     floating: true,
     actions: [
       IconButton(icon: Icon(Icons.shopping_cart),
           onPressed: () => Navigator.pushNamed(context, '/cart'),
       )
     ],
    );
  }
}

class _MyListItem extends StatelessWidget{
  final int index;
  _MyListItem(this.index,{Key key}):super(key:key);
  @override
  Widget build(BuildContext context) {
    var item = context.select<CatalogModel,Item>(// Context.select is returning an Item object from CatalogModel class.//
           // (value) => null
          (catalog) => catalog.getByPosition(index),
    );
    var textTheme = Theme.of(context).textTheme.headline6;
    return Row(
      children: [
        Text(item.name, style: textTheme,),
        _AddButton(item: item),
      ],
    );
  }
}

class _AddButton extends StatelessWidget {
  final Item item;
  const _AddButton({Key key, @required this.item}) : super(key: key); // this is the constructor of the _AddButton widget...
  // with super(key:key), we are invoking the constructor of superclass.
  // Here the superclass is the class where this widget is initialized/created?
  @override
  Widget build(BuildContext context) {
    //firstly check if the item is already in the cart
    var isInCart = context.select<CartModel,bool>( //context.select<T, R>(R cb(T value)), which allows a widget to
      // listen to only a small part of T.
    // The context.select() method will let you listen to changes to
    // a *part* of a model. You define a function that "selects" (i.e. returns)
    // the part you're interested in, and the provider package will not rebuild
    // this widget unless that particular part of the model changes.

   // (value) => null
          (cart) => cart.items.contains(item),

    );

    //secondly define the return function
    return FlatButton(
      onPressed: isInCart ? null
          :(){
        // If the item is not in cart, we let the user add it.
        // We are using context.read() here because the callback
        // is executed whenever the user taps the the button. In other
        // words, it is executed outside the build method.
        var cart = context.read<CartModel>();
        cart.add(item);
      },
      child:
          //if the item is in cartmodel, then show a checkbox...:"isInCart" can be used to check...it's updated as
      // soon as we call the cart.add method above, because we are using context.select to listen on
          isInCart ? Icon(Icons.check,semanticLabel: 'ADDED',)
                    : Text('ADD'),
    );
  }
}


















