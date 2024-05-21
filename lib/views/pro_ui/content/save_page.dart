// import 'package:shared/ui/placeholder/placeholder_image_with_text.dart';
import 'package:delivery/shared/constants.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
import 'package:outline_material_icons/outline_material_icons.dart';

class SavePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // bool isLandscape = MediaQuery.of(context).size.aspectRatio > 1;
    // var columnCount = isLandscape ? 3 : 2;

    return const Column(
      children: [
        Card(
          color: Colors.white70,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
                ListTile(
                  leading: Icon(OMIcons.settings, color: Colors.grey,),
                  title: Text("Update Settings"),
                  subtitle: 
                  Column(
                    children: [
                      Row(
                        children: [
                          Text("theme"),
                          Switch(value: false, onChanged: null)
                        ],
                      ),
                      Row(
                        children: [
                          Text("dark mode"),
                          Switch(value: false, onChanged: null, focusColor: Colors.blue,)
                        ],
                      ),
                      Row(
                        children: [
                          Text("language"),
                          Icon(Icons.arrow_drop_down),
                        ],
                      ),
                      SizedBox(width: 10, height: 10,),
                      Row(
                        children: [
                          Text("reset password", style: cNavText,),
                          SizedBox(width: 10, height: 10,),
                          Text("sign out", style: cNavText,),
                        ],
                      ),
                    ],
                  ),
                )
            ],
          ),
        ),
        Card(
          color: Colors.amberAccent,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
                ListTile(
                  leading: Icon(OMIcons.creditCard, color: Colors.black,),
                  title: Text("Billing"),
                  subtitle: 
                  Column(
                    children: [
                      Text("order history"),
                      Text("past rides"),
                      Text("past services"),
                      Text("food orders"),
                    ],
                  ),
                )
            ],
          ),
        ),
        Card(
          color: Colors.lightBlue,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
                ListTile(
                  leading: Icon(OMIcons.person, color: Colors.black,),
                  title: Text("Personal Info"),
                  subtitle: 
                  Column(
                    children: [
                      Text("name"),
                      Text("phone"),
                      Text("email"),
                      Text("address"),
                      Text("billing"),
                      SizedBox(width: 10, height: 20,),
                      Text("service provider"),
                    ],
                  ),
                )
            ],
          ),
        ),
      ],
    );
    // return Container(
    //   child: GridView.count(
    //     crossAxisCount: columnCount,
    //     children: List.generate(20, (index) {
    //       return Text("test ui");
    //     }),
    //   ),
    // );
  }
}