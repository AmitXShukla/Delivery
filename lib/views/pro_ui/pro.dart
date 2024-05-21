import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../shared/constants.dart';

// ignore: must_be_immutable
class ProLook extends StatefulWidget {
  static const routeName = '/pro';
  ProLook(
      {super.key,
      required this.handleBrightnessChange,
      required this.setLocale});

  Function(bool useLightMode) handleBrightnessChange;
  Function(Locale locale) setLocale;

  @override
  ProLookState createState() => ProLookState();
}

class ProLookState extends State<ProLook> {
  // bool _varpressed = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: createAuthBar(context),
        appBar: createNavLogInBar(context, widget),
        body: Material(child: Container(child: userForm(context))));
  }

  Widget userForm(BuildContext context) {
    return Form(
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              const SizedBox(
                width: 10,
                height: 40,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.food_bank_rounded, color: Colors.green,),
                  SizedBox(
                    width: 10,
                    height: 40,
                  ),
                  Icon(Icons.fire_truck, color: Colors.grey),
                  SizedBox(
                    width: 10,
                    height: 40,
                  ),
                  Icon(Icons.delivery_dining, color: Colors.grey),
                ],
              ),
              const SizedBox(
                width: 10,
                height: 40,
              ),
              SizedBox(
                  width: 300.0,
                  // margin: const EdgeInsets.only(top: 25.0),
                  child: TextFormField(
                    // controller: _emailController,
                    cursorColor: Colors.blueAccent,
                    // keyboardType: TextInputType.emailAddress,
                    maxLength: 50,
                    obscureText: false,
                    // onChanged: (value) => model.email = value,
                    // validator: (value) {
                    //   return Validators().evalEmail(value!);
                    // },
                    // onSaved: (value) => _email = value,
                    decoration: InputDecoration(
                      icon: const Icon(Icons.house),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.0)),
                      hintText: AppLocalizations.of(context)!.cWhereTo,
                      labelText: AppLocalizations.of(context)!.cWhereToHint,
                      // errorText: snapshot.error,
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
