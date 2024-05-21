// import 'package:shared/ui/placeholder/placeholder_image.dart';
import 'package:flutter/material.dart';

class GalleryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool isLandscape = MediaQuery.of(context).size.aspectRatio > 1;
    var columnCount = isLandscape ? 4 : 2;

    return Container(
      child: GridView.count(
        crossAxisCount: columnCount,
        crossAxisSpacing: 2,
        mainAxisSpacing: 2,
        children: [
          Image.asset("assets/food1.png"),
          Image.asset("assets/food2.png"),
          Image.asset("assets/food3.png"),
          Image.asset("assets/food4.png"),
          Image.asset("assets/food5.png"),
          Image.asset("assets/food6.png"),
          Image.asset("assets/food1.png"),
          Image.asset("assets/food2.png"),
        ]
        // List.generate(20, (index) {
        //   return Text("test ui");
        // }),
      ),
    );
  }
}