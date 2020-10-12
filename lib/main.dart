import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopper_nithin/common/theme.dart';
import 'package:shopper_nithin/screens/cart.dart';
import 'package:shopper_nithin/screens/catalog.dart';
import 'package:shopper_nithin/screens/login.dart';
import 'package:shopper_nithin/models/cart.dart';
import 'package:shopper_nithin/models/catalog.dart';
import 'models/cart.dart';
import 'models/catalog.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers:[
        Provider<CatalogModel>(create: (context) => CatalogModel()), //added <CatalogModel> to specify the provider type.
        // CartModel is implemented as a ChangeNotifier, which calls for the use
        // of ChangeNotifierProvider. Moreover, CartModel depends
        // on CatalogModel, so a ProxyProvider is needed.
        ChangeNotifierProxyProvider<CatalogModel, CartModel>( //ProxyProvider is used because it is dependent on another
          // provider (CatalogModel)....here CartModel type depends on the CatalogModel type
          create: (context) => CartModel(),
         
         // update is required because catalogmodel gets new items added as the user scrolls down and down...same items can be added to cart as well
          //so, post scrolling the updated catalog (with additional items) should be communicated to cartmodel..
          update: (context, catalog, cart) { //if catalog of type CatalogModel changes, then, cart of type CartModel should be updated
           cart.catalog = catalog;
            return cart;
          },

        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: appTheme,
        initialRoute: '/',
        routes: {
          '/': (context) => MyLogin(),
          '/catalog': (context) => MyCatalog(), //<de
          '/cart': (context) => MyCart(),
        },
      ),
    );
  }
}
