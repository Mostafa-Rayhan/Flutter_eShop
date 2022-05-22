import 'dart:io';

import 'package:e_shop/providers/my_theme.dart';
import 'package:e_shop/screens/wishlist_screen.dart';
import 'package:e_shop/screens/cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserScreen extends StatefulWidget {
  static const routeName = '/User-screen';

  const UserScreen({Key? key}) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  double top = 0;

  late ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverAppBar(
                pinned: true,
                stretch: true,
                expandedHeight: 250,
                flexibleSpace: LayoutBuilder(builder: (ctx, cons) {
                  top = cons.biggest.height;
                  return FlexibleSpaceBar(
                    centerTitle: true,
                    background: Image.network(
                      'https://images.pexels.com/photos/1537875/pexels-photo-1537875.jpeg?auto=compress&cs=tinysrgb&h=750&w=1260',
                      fit: BoxFit.cover,
                    ),
                    title: AnimatedOpacity(
                      duration: const Duration(milliseconds: 300),
                      opacity: top <= 200 ? 1.0 : 0.0,
                      child: Row(
                        children: const [
                          SizedBox(
                            width: 12,
                          ),
                          CircleAvatar(
                            backgroundImage: NetworkImage(
                                'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260'),
                          ),
                          SizedBox(
                            width: 12,
                          ),
                          Text('Fluttercraft')
                        ],
                      ),
                    ),
                  );
                }),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ListView(
                    primary: false,
                    shrinkWrap: true,
                    children: [
                      // User Bag
                      const _userTileText(text: 'User Bag'),
                      const _userTileHeightSpace(height: 10),
                      _userListTile(
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(WishlistScreen.routeName);
                        },
                        lIcon: Icons.favorite,
                        color: Colors.red,
                        title: 'Wishlist',
                        tIcon: Icons.arrow_forward_ios,
                        tIconCallBack: () {},
                      ),
                      _userListTile(
                        onTap: () {
                          Navigator.of(context).pushNamed(CartScreen.routeName);
                        },
                        lIcon: Icons.shopping_cart,
                        color: Colors.deepPurpleAccent,
                        title: 'Cart',
                        tIcon: Icons.arrow_forward_ios,
                        tIconCallBack: () {},
                      ),

                      // User Settings
                      const _userTileHeightSpace(height: 15),
                      const _userTileText(text: 'User Settings'),
                      const _userTileHeightSpace(height: 10),
                      Card(
                        child: Consumer<ThemeNotifier>(
                            builder: (context, notifier, _) {
                              return SwitchListTile.adaptive(
                                secondary: notifier.isDark
                                    ? Icon(Icons.dark_mode,
                                    color: Colors.amber.shade700)
                                    : Icon(Icons.light_mode,
                                    color: Colors.amber.shade700),
                                title: notifier.isDark
                                    ? const Text('Dark Mode')
                                    : const Text('Light Mode'),
                                value: notifier.isDark,
                                onChanged: (value) {
                                  notifier.toggleTheme(value);
                                },
                              );
                            }),
                      ),

                      // User Information
                      const _userTileHeightSpace(height: 15),
                      const _userTileText(text: 'User Informattion'),
                      const _userTileHeightSpace(height: 10),
                      _userListTile(
                        lIcon: Icons.call,
                        color: Colors.green.shade700,
                        title: 'Phone Number',
                        subTitle: 'Number',
                        onTap: () {},
                      ),
                      _userListTile(
                        lIcon: Icons.email,
                        color: Colors.yellow.shade700,
                        title: 'Email',
                        subTitle: 'Email',
                        onTap: () {},
                      ),

                      _userListTile(
                        lIcon: Icons.local_shipping,
                        color: Colors.indigo.shade400,
                        title: 'Address',
                        subTitle: 'Address',
                        onTap: () {},
                      ),
                      _userListTile(
                        lIcon: Icons.watch_later,
                        color: Colors.redAccent.shade100,
                        title: 'Join Date',
                        subTitle: 'date',
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          _buildFab(),
        ],
      ),
    );
  }

  Widget _buildFab() {
    double defaultMargin = Platform.isIOS ? 270 : 250;
    double scrollStart = 230;
    double scrollEnd = scrollStart / 2;

    double top = defaultMargin;
    double scale = 1.0;

    if (_scrollController.hasClients) {
      double offSet = _scrollController.offset;
      top -= offSet;

      if (offSet < defaultMargin - scrollStart) {
        scale = 1;
      } else if (offSet < defaultMargin - scrollEnd) {
        scale = (defaultMargin - scrollEnd - offSet) / scrollEnd;
      } else {
        scale = 0;
      }
    }

    return Positioned(
      top: top,
      right: 20,
      child: Transform(
        transform: Matrix4.identity()..scale(scale),
        alignment: Alignment.center,
        child: FloatingActionButton(
          child: const Icon(Icons.camera),
          onPressed: () {},
        ),
      ),
    );
  }
}

// ignore: camel_case_types
class _userListTile extends StatelessWidget {
  final IconData lIcon;
  final Color color;
  final String title;
  final String? subTitle;
  final IconData? tIcon;
  final VoidCallback? tIconCallBack;
  final VoidCallback? onTap;
  const _userListTile({
    this.subTitle,
    this.tIcon,
    this.tIconCallBack,
    this.onTap,
    Key? key,
    required this.lIcon,
    required this.color,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(
          lIcon,
          color: color,
        ),
        title: Text(title),
        subtitle: subTitle == null ? null : Text(subTitle!),
        onTap: onTap,
        trailing: IconButton(
          icon: Icon(tIcon),
          onPressed: tIconCallBack,
        ),
      ),
    );
  }
}

// ignore: camel_case_types
class _userTileHeightSpace extends StatelessWidget {
  final double height;
  const _userTileHeightSpace({
    Key? key,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: height);
  }
}

// ignore: camel_case_types
class _userTileText extends StatelessWidget {
  final String text;
  const _userTileText({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      ' $text',
      style: const TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.w700,
        // decoration: TextDecoration.underline,
      ),
    );
  }
}