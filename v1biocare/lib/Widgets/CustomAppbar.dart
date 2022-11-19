import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

import '../Screens/SearchPage.dart';

class CustomAppbar extends StatelessWidget with PreferredSizeWidget {
  const CustomAppbar({
    Key? key,
    required this.title,
  }) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: Drawer(),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(40),
        child: AppBar(
          title: Text(
            title,
            style: const TextStyle(letterSpacing: 2),
          ),
          centerTitle: true,
          backgroundColor: Colors.green,
          actions: [
            // Navigate to the Search Screen
            IconButton(
              onPressed: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => const SearchPage())),
              icon: const Icon(Icons.search),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                IconlyBold.buy,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),

      // drawer: const Drawer(),
    );

    // return AppBar(
    //   centerTitle: true,
    //   backgroundColor: Colors.white,
    //   // alignment: Alignment.center,
    //   elevation: 0,

    //   title: Container(
    //       color: Colors.green,
    //       padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    //       child: Text(
    //         title,
    //         style: const TextStyle(
    //             fontWeight: FontWeight.normal,
    //             fontSize: 20,
    //             color: Colors.white),
    //       )),
    //   actions: [
    // IconButton(
    //     onPressed: () {},
    //     icon: const Icon(
    //       IconlyBold.buy,
    //       color: Colors.white,
    //     ))
    //   ],
    // );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50.0);
}
