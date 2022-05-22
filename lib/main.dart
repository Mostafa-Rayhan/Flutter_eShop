import 'package:e_shop/providers/my_theme.dart';
import 'package:e_shop/screens/bottom_nav_screen.dart';
import 'package:e_shop/screens/cart_screen.dart';
import 'package:e_shop/screens/feeds_screen.dart';
import 'package:e_shop/screens/home_screen.dart';
import 'package:e_shop/screens/inner_screens/brands_nav_rail.dart';
import 'package:e_shop/screens/search_screen.dart';
import 'package:e_shop/screens/inner_screens/product_details_screen.dart';
import 'package:e_shop/screens/user_screen.dart';
import 'package:e_shop/screens/wishlist_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => ThemeNotifier()),
      ],
      child: Consumer<ThemeNotifier>(builder: (context, notifier, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: MyAppTheme.myThemes(notifier.isDark, context),
          home: const BottomNavScreen(),
          routes: {
            BottomNavScreen.routeName: (ctx) => const BottomNavScreen(),
            HomeScreen.routeName: (ctx) => const HomeScreen(),
            FeedsScreen.routeName: (ctx) => FeedsScreen(),
            SearchScreen.routeName: (ctx) => const SearchScreen(),
            CartScreen.routeName: (ctx) => const CartScreen(),
            UserScreen.routeName: (ctx) => const UserScreen(),
            BrandsNavRailScreen.routeName: (ctx) => const BrandsNavRailScreen(),
            WishlistScreen.routeName: (ctx) => WishlistScreen(),
            ProductDetailsScreen.routeName: (ctx) => const ProductDetailsScreen(),
          },
        );
      }),
    );
  }
}