import 'package:cartapp/providers/cart.dart';
import 'package:cartapp/screens/Auth_Screen.dart';
import 'package:cartapp/screens/EditProductsScreen.dart';
import 'package:cartapp/screens/Orders_Screen.dart';
import 'package:cartapp/screens/UserProductsScreen.dart';
import 'package:cartapp/screens/cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:cartapp/providers/Products_provider.dart';
import 'package:cartapp/screens/Product_Detail_Screen.dart';
import 'package:cartapp/screens/Productsovervoiescreen.dart';
import '../providers/orders.dart';
import 'providers/Auth.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Auth(),
        ),

        ChangeNotifierProvider(
          create: (ctx) => Products(),
        ),

        // ChangeNotifierProxyProvider<Auth, Products>(
        //   update: ((_, auth, previousProducts) =>
        //       Products(auth.token!, previousProducts == null ? [] : previousProducts.item)),
        // ),

        ChangeNotifierProvider(
          create: ((ctx) => Cart()),
        ),
        ChangeNotifierProvider(
          create: ((ctx) => Orders()),
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, child) => MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.purple,
            accentColor: Colors.deepOrange,
          ),
          debugShowCheckedModeBanner: false,
          home: auth.isAuth ? ProductsoverviewScreen() : AuthScreen(),
          routes: {
            ProductsoverviewScreen.routeName: (context) => ProductsoverviewScreen(),
            ProductDetailScreen.routename: (context) => const ProductDetailScreen(),
            CartScreen.routename: (context) => const CartScreen(),
            OrderScreen.routeName: (context) => const OrderScreen(),
            UserProductsScreen.routeName: (context) => const UserProductsScreen(),
            EditProductsScreen.routeName: (context) => EditProductsScreen()
          },
        ),
      ),
    );
  }
}
