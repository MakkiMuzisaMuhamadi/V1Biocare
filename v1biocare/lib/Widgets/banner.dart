import 'package:v1biocare/Widgets/DOtsIndicatorWIdget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../firebaseServices/firebaseservice.dart';
import 'package:getwidget/getwidget.dart';

class BannerWidget extends StatefulWidget {
  const BannerWidget({super.key});

  @override
  State<BannerWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  final FirebaseService _service = FirebaseService();
  int selectedPage = 0;
  PageController pageController = PageController();

  double scrollPosition = 0;
  List _bannerimage = [];
  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    getBanners();
    super.initState();
  }

  getBanners() {
    return _service.homebanner.get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        setState(() {
          _bannerimage.add(doc['image']);
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: SizedBox(
              height: 150,
              width: MediaQuery.of(context).size.width,
              // color: Colors.orange,
              child: _bannerimage.isEmpty
                  ? GFShimmer(
                      showShimmerEffect: true,
                      mainColor: Colors.grey.shade500,
                      secondaryColor: Colors.grey.shade400,
                      child: Container(
                        height: 150,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.grey.shade300,
                      ),
                    )
                  : PageView.builder(
                      controller: pageController,
                      itemCount: _bannerimage.length,
                      itemBuilder: (BuildContext context, int index) {
                        // setState(() {
                        //   _bannerimage = in;
                        // });
                        // pageController.animateToPage(index,
                        //     duration: Duration(microseconds: 500),
                        //     curve: Curves.easeInOutExpo);
                        return Image.network(
                          _bannerimage[index],
                          fit: BoxFit.fill,
                        );
                      },
                      onPageChanged: (val) {
                        setState(() {
                          scrollPosition = val.toDouble();
                        });
                      },
                    ),

              // ignore: prefer_const_constructors, prefer_const_literals_to_create_immutables
            ),
          ),
        ),
        DOtsIndicatorWIdget(scrollPosition: scrollPosition)
      ],
    );
  }
}
