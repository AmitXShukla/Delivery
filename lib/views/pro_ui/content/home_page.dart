// import 'package:shared/ui/placeholder/placeholder_card_tall.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return Container(
    //   child: ListView.builder(
    //     itemCount: 1,
    //     itemBuilder: (content, index) {
    //       return Container(
    //         padding: EdgeInsets.symmetric(vertical: 1),
    //         child: Image.asset("assets/map.png"),
    //       );
    //     },
    //   ),
    // );
    return SizedBox(
      child: Image.asset("assets/map.png", fit: BoxFit.cover,));
  }
}