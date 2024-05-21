// import 'package:shared/ui/placeholder/placeholder_card_short.dart';
import 'package:flutter/material.dart';

class LikesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: const Color.fromARGB(255, 153, 197, 218),
        child: ListView.builder(
          itemCount: 1,
          itemBuilder: (content, index) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 200, horizontal: 120),
              child: TextFormField(
                    cursorColor: Colors.blueAccent,
                    keyboardType: TextInputType.text,
                    maxLength: 50,
                    obscureText: false,
                    // onChanged: (value) => model.email = value,
                    // validator: (value) {
                    //   return Validators().evalEmail(value!);
                    // },
                    // onSaved: (value) => _email = value,
                    decoration: InputDecoration(
                      icon: const Icon(Icons.gps_fixed_sharp),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.0)),
                      hintText: "serving location",
                      labelText: "Where to?",
                      // errorText: snapshot.error,
                    ),
                  )
            );
          },
        ),
      ),
    );
  }
}