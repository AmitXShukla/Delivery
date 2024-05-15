// import 'dart:convert';
// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import '../shared/constants.dart';
import '../models/datamodel.dart';
import '../blocs/auth.bloc.dart';

// ignore: must_be_immutable
class Inbox extends StatefulWidget {
  static const routeName = '/inbox';
  Inbox({super.key, required this.handleBrightnessChange
  , required this.setLocale});

  Function(bool useLightMode) handleBrightnessChange;
  Function(Locale _locale) setLocale;

  @override
  InboxState createState() => InboxState();
}

class InboxState extends State<Inbox> {
  List<DataRow> dataRows = [];
  List<ParseObject> results = <ParseObject>[];
  // ignore: prefer_typing_uninitialized_variables
  bool isUserValid = true;
  bool spinnerVisible = false;
  bool messageVisible = false;
  String messageTxt = "";
  String messageType = "";
  List data = [
    InboxModel(
        dttm: 'none',
        uid: 'na',
        to: 'na',
        message: 'na',
        readReceipt: false,
        fileURL: 'na')
  ];

  @override
  void initState() {
    loadAuthState();
    super.initState();
  }

  void loadAuthState() async {
    final userState = await authBloc.isSignedIn();
    setState(() => isUserValid = userState);
    getData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  toggleSpinner() {
    setState(() => spinnerVisible = !spinnerVisible);
  }

  showMessage(bool msgVisible, msgType, message) {
    messageVisible = msgVisible;
    setState(() {
      messageType = msgType == "error"
          ? cMessageType.error.toString()
          : cMessageType.success.toString();
      messageTxt = message;
    });
  }

  getData() async {
    toggleSpinner();
    // var data = await authBloc.getMessages("Messages", "-");
    // setState(() => results = data);
    await authBloc.getMessages("Messages", "-").then((value) => setState(() => results = value));
    toggleSpinner();
  }

  deleteData(docID) async {
    await authBloc.delDoc("Messages", docID);
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: createCustomerNavBar(context, widget),
        body: Material(
            child: Container(
                margin: const EdgeInsets.all(20.0),
                child: (isUserValid == true)
                    ? messageHistory(context)
                    : loginPage(context))));
  }

  Widget messageHistory(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Center(
        child: SizedBox(
          width: 400,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  const Text("Recent 10 Messages",style: cBodyText,),
                  const SizedBox(width: 40, height: 10,),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/message',
                      );
                    },
                    child: const Chip(
                        backgroundColor: Colors.blueAccent,
                        // padding: EdgeInsets.symmetric(vertical: 15, horizontal: 5),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                          topRight: Radius.circular(15),
                          bottomRight: Radius.circular(15),
                          topLeft: Radius.circular(15),
                          bottomLeft: Radius.circular(15),
                        )),
                        label: Text("send a message")),
                  ),
                ],
              ),
              const SizedBox(width: 40, height: 20,),
              results.isEmpty ? const Text("no messages") : const Text(""),
              ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  // padding: const EdgeInsets.all(20.0),
                  itemCount: results.length,
                  // itemBuilder:
                  itemBuilder: (context, index) {
                    final item = results[index];
                    return ListTile(
                      title: Column(
                        children: [
                          Row(
                            children: [
                              Text(item["dttm"].toString().substring(0,16)),
                              const SizedBox(
                                width: 30,
                              ),
                              IconButton(
                                onPressed: () {
                                  showAlertDialog(
                                      context, item["objectId"].toString());
                                },
                                icon: const Icon(Icons.delete,
                                    color: Colors.redAccent),
                              )
                            ],
                          ),
                        ],
                      ),
                      subtitle: Text(item["message"].toString()),
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }

  Widget loginPage(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Chip(
              avatar: CircleAvatar(
                backgroundColor: Colors.grey,
                child: Icon(
                  Icons.warning,
                  color: Colors.red,
                ),
              ),
              label: Text("please Login again, you are currently signed out.",
                  style: cErrorText)),
          const SizedBox(width: 20, height: 50),
          ElevatedButton(
            child: const Text('Login'),
            // color: Colors.blue,
            onPressed: () {
              Navigator.pushNamed(
                context,
                '/',
              );
            },
          ),
        ],
      ),
    );
  }

  showAlertDialog(BuildContext context, docId) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: const Text("Cancel"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = TextButton(
      child: const Text("Continue"),
      onPressed: () {
        deleteData(docId);
        Navigator.pop(context);
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Please confirm"),
      content: const Text("Do you really want to delete this record ?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
