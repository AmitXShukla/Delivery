import 'dart:math';
import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import '../shared/constants.dart';
import '../models/datamodel.dart';
import '../models/validators.dart';
import '../blocs/auth.bloc.dart';
import 'package:flutter/cupertino.dart';

// ignore: must_be_immutable
class Bid extends StatefulWidget {
  static const routeName = '/bid';
  Bid({super.key, required this.handleBrightnessChange
      , required this.setLocale});

  Function(bool useLightMode) handleBrightnessChange;
  Function(Locale _locale) setLocale;
  @override
  BidState createState() => BidState();
}

class BidState extends State<Bid> {
  List<ParseObject> results = <ParseObject>[];
  // ignore: prefer_typing_uninitialized_variables
  bool isUserValid = true;
  bool spinnerVisible = false;
  bool messageVisible = false;
  String messageTxt = "";
  String messageType = "";

  @override
  void initState() {
    loadAuthState();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void loadAuthState() async {
    final userState = await authBloc.isSignedIn();
    setState(() => isUserValid = userState);
    getData();
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
    await authBloc.getBiddableRides("Rides").then((res) => setState(() {
      results = res;
    }));
    toggleSpinner();
  }

  @override
  Widget build(BuildContext context) {
    // AuthBloc authBloc = AuthBloc();
    return Scaffold(
        appBar: createCustomerNavBar(context, widget),
        body: Material(
            child: Container(
                margin: const EdgeInsets.all(20.0),
                child: (isUserValid == true)
                    ? rideHistory(context)
                    : loginPage(context))));
  }

  Widget rideHistory(BuildContext context) {
    return CustomScrollView(
      // scrollDirection: Axis.vertical,
      slivers: <Widget>[
        SliverPadding(
          padding: const EdgeInsets.all(20.0),
          sliver: SliverList(
            delegate: SliverChildListDelegate(
              <Widget>[
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/bids',
                    );
                  },
                  child: const Chip(
                      backgroundColor: Colors.green,
                      // padding: EdgeInsets.symmetric(vertical: 15, horizontal: 5),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                        topRight: Radius.circular(15),
                        bottomRight: Radius.circular(15),
                        topLeft: Radius.circular(15),
                        bottomLeft: Radius.circular(15),
                      )),
                      label: Text("Back")),
                ),
                const Text(
                  "new rides",
                  style: cSuccessText,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columns: const <DataColumn>[
                      DataColumn(
                        label: Expanded(
                          child: Text(
                            'Date',
                            style: TextStyle(
                                fontStyle: FontStyle.italic,
                                color: Colors.grey),
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Expanded(
                          child: Text(
                            'From',
                            style: TextStyle(
                                fontStyle: FontStyle.italic,
                                color: Colors.grey),
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Expanded(
                          child: Text(
                            'To',
                            style: TextStyle(
                                fontStyle: FontStyle.italic,
                                color: Colors.grey),
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Expanded(
                          child: Text(
                            'Action',
                            style: TextStyle(
                                fontStyle: FontStyle.italic,
                                color: Colors.grey),
                          ),
                        ),
                      ),
                    ],
                    rows: results
                        .map(
                          (res) => DataRow(cells: [
                            DataCell(
                              Row(
                                children: [
                                  Text(
                                    res["dttm"].toString(),
                                  ),
                                ],
                              ),
                            ),
                            DataCell(
                              Text(
                                "${res["from"].toString().substring(0, min(14, res["from"].toString().length))}...",
                              ),
                            ),
                            DataCell(
                              Text(
                                "${res["to"].toString().substring(0, min(14, res["to"].toString().length))}...",
                              ),
                            ),
                            DataCell(
                              Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.fire_truck),
                                    color: Colors.green,
                                    tooltip: 'Place Bids',
                                    onPressed: () {
                                      showAlertDialog1(context, res);
                                    },
                                  ),
                                ],
                              ),
                            )
                          ]),
                        )
                        .toList(),
                  ),
                ),
                results.isEmpty
                    ? const Text("no rides data found.")
                    : const Text(""),
              ],
            ),
          ),
        ),
      ],
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

  showAlertDialog1(BuildContext context, res) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: const Text("Place Bid"),
      onPressed: () {
        Navigator.pop(context);
        Navigator.push(
          context,
          CupertinoPageRoute(
              builder: (context) => PlaceBid(
                    docId: res["objectId"],
                  )),
        );
      },
    );
    Widget InfoButton = TextButton(
      child: Text(res['status']),
      onPressed: () {
        Navigator.pop(context);
        // Navigator.push(
        //       context,
        //       CupertinoPageRoute(builder: (context) => EditRide(docId: res["objectId"],)),
        //     );
      },
    );
    Widget continueButton = TextButton(
      child: const Text("ok"),
      onPressed: () {
        // deleteData(res["objectId"]);
        Navigator.pop(context);
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(res["dttm"].toString()),
      content: SizedBox(
        width: 400,
        height: 300,
        child: Column(
          children: [
            Row(
              children: [
                const Text(
                  "From : ",
                  style: cNavText,
                ),
                Flexible(child: Text(res['from'].toString())),
              ],
            ),
            Row(
              children: [
                const Text(
                  "To : ",
                  style: cNavText,
                ),
                Flexible(child: Text(res['to'].toString())),
              ],
            ),
            Row(
              children: [
                const Text(
                  "Message : ",
                  style: cNavText,
                ),
                Flexible(child: Text(res['message'].toString())),
              ],
            ),
            Row(
              children: [
                const Text(
                  "Load Type : ",
                  style: cNavText,
                ),
                Text(res['loadType'].toString()),
              ],
            ),
            Row(
              children: [
                const Text(
                  "status : ",
                  style: cNavText,
                ),
                Text(res['status'].toString()),
              ],
            ),
            Row(
              children: [
                const Text(
                  "Images : ",
                  style: cNavText,
                ),
                Text(res['fileURL'].toString()),
              ],
            ),
          ],
        ),
      ),
      actions: [
        ((res["status"].toString() == "new") |
                (res["status"].toString() == "-"))
            ? cancelButton
            : InfoButton,
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

// Edit Ride class code
class PlaceBid extends StatefulWidget {
  final String docId;
  // const PlaceBid({super.key, required this.docID});
  // Function(bool useLightMode) handleBrightnessChange;
  const PlaceBid({super.key, required this.docId});
  @override
  PlaceBidState createState() => PlaceBidState();
}

class PlaceBidState extends State<PlaceBid> {
  bool isUserValid = true;
  bool spinnerVisible = false;
  bool messageVisible = false;
  bool _btnEnabled = false;
  bool _cancelEnabled = false;
  String messageTxt = "";
  String messageType = "";
  final _formKey = GlobalKey<FormState>();
  BidModel model = BidModel(
      objectId: '-',
      rideId: '-',
      rideDttm: '-',
      uid: '-',
      driver: '-',
      from: '-',
      to: '-',
      status: 'new',
      fileURL: '-',
      bid: '-',
      message: '-'
      );
  InboxModel msgModel = InboxModel(dttm: '-', uid: '-', to: '-', message: '-', 
              readReceipt: false, fileURL: '-');
  final TextEditingController _bidController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  @override
  void initState() {
    loadAuthState();
    super.initState();
  }

  void loadAuthState() async {
    // storing user uid/objectId from users class, as a field into message record
    var username = await authBloc.getUser();
    final userState = await authBloc.isSignedIn();
    setState(() => isUserValid = userState);
    // var userData;
    await authBloc
        .getRideDoc("Rides", widget.docId)
        .then((value) => setState(() {
                  // model.objectId = userData[0]["objectId"];
                  model.rideId = value[0]["objectId"];
                  model.rideDttm = value[0]["dttm"];
                  model.uid = value[0]["uid"];
                  model.driver = (username?.get("objectId") == null)
                      ? "-"
                      : username?.get("objectId");
                  model.from = value[0]["from"];
                  model.to = value[0]["to"];
                  model.status = "new";
                  model.fileURL = value[0]["fileURL"];
                  model.bid = "";
                  model.message = '-';

                  _bidController.text = model.bid;
                  _messageController.text = model.message;
                })
            // userData = value
            );
  }

  @override
  void dispose() {
    _bidController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  toggleSpinner() {
    // TODO : refactor code
    //make this as a global reusable widget
    // define this in constants.dart
    setState(() => spinnerVisible = !spinnerVisible);
  }

  showMessage(bool msgVisible, msgType, message) {
    // TODO : refactor code
    //make this as a global reusable widget
    // define this in constants.dart
    messageVisible = msgVisible;
    setState(() {
      messageType = msgType == "error"
          ? cMessageType.error.toString()
          : cMessageType.success.toString();
      messageTxt = message;
    });
  }

  void setBid(BidModel model) async {
    toggleSpinner();
    // ignore: prefer_typing_uninitialized_variables
    var userData;
    userData = await authBloc.setBid("Bids", model);
    if (userData == true) {
      sendMessage(model.uid, "There is a bid update your ride, please check your rides.");
      sendMessage(model.driver, "You recently updated a bid on one ride.");
      showMessage(true, "success",
          "Bid is placed, please keep checking your Inbox for further notifications.");
    } else {
      showMessage(
          true, "error", "something went wrong, please contact your Admin.");
    }
    toggleSpinner();
  }

  void sendMessage(String recipient, String msg) async {
    msgModel.dttm = DateTime.now().toString();
    msgModel.uid = recipient;
    msgModel.to = "-";
    msgModel.message = msg;

    // ignore: prefer_typing_uninitialized_variables
    await authBloc.setMessage(msgModel);
  }

  @override
  Widget build(BuildContext context) {
    // AuthBloc authBloc = AuthBloc();
    return Scaffold(
        appBar: createCustomerNavBar(context, widget),
        body: Material(
            child: Container(
                margin: const EdgeInsets.all(20.0),
                child: (isUserValid == true)
                    ? userForm(context)
                    : loginPage(context))));
  }

  Widget userForm(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onChanged: () =>
          setState(() => _btnEnabled = _formKey.currentState!.validate()),
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              // const Image(image: AssetImage('../assets/afronalalogo.png'), width: 200, height: 200,),
              SizedBox(
                width: 300,
                child: Row(
                  children: [
                    const Text(
                      "Place Bid",
                      style: cBodyText,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    IconButton(
                      icon: const Icon(Icons.info),
                      color: Colors.orangeAccent,
                      tooltip: 'Important',
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text(
                                'Please make sure your driver informations is updated in your profile. Your customer will contact you only using your app email and phone number.')));
                      },
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            '/bid',
                          );
                        },
                        child: const Text('back')),
                  ],
                ),
              ),
              Container(
                  width: 300.0,
                  margin: const EdgeInsets.only(top: 25.0),
                  child: TextFormField(
                    controller: _bidController,
                    cursorColor: Colors.blueAccent,
                    // keyboardType: TextInputType.emailAddress,
                    maxLength: 10,
                    obscureText: false,
                    onChanged: (value) => model.bid = value,
                    validator: (value) {
                      return Validators().evalNumber(value!);
                    },
                    // onSaved: (value) => _email = value,
                    decoration: InputDecoration(
                      icon: const Icon(Icons.money),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.0)),
                      hintText: 'Price',
                      labelText: 'charges for service',
                      // errorText: snapshot.error,
                    ),
                  )),
              Container(
                  width: 300.0,
                  margin: const EdgeInsets.only(top: 25.0),
                  child: TextFormField(
                    controller: _messageController,
                    cursorColor: Colors.blueAccent,
                    // keyboardType: TextInputType.emailAddress,
                    maxLength: 100,
                    obscureText: false,
                    onChanged: (value) => model.message = value,
                    // validator: (value) {
                    //         // return Validators().evalEmail(value!);
                    // },
                    // onSaved: (value) => _email = value,
                    decoration: InputDecoration(
                      icon: const Icon(Icons.message),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.0)),
                      hintText: 'type your message',
                      labelText: 'Message',
                      // errorText: snapshot.error,
                    ),
                  )),
              Container(
                margin: const EdgeInsets.only(top: 5.0),
              ),
              // Container(
              //   margin: const EdgeInsets.only(top: 5.0),
              // ),
              // const Text(
              //   "upload documents",
              //   style: cBodyText,
              // ),
              CustomSpinner(toggleSpinner: spinnerVisible, key: null),
              CustomMessage(
                toggleMessage: messageVisible,
                toggleMessageType: messageType,
                toggleMessageTxt: messageTxt,
                key: null,
              ),
              Container(
                margin: const EdgeInsets.only(top: 15.0),
              ),
              // signinSubmitBtn(context, authBloc),
              Column(
                children: [
                  // showAlertDialog3(context),
                  sendBtn(context),
                  const SizedBox(
                    width: 40,
                    height: 10,
                  ),
                  // SizedBox(
                  //   width: 200,
                  //   child: CheckboxListTile(
                  //     value: _cancelEnabled,
                  //     onChanged: (newValue) =>
                  //         setState(() => _cancelEnabled = !_cancelEnabled),
                  //     title: const Text("cancel bid"),
                  //   ),
                  // ),
                  // cancelBtn(context),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget sendBtn(context) {
    return ElevatedButton(
        onPressed: _btnEnabled == true ? () => setBid(model) : null,
        child: const Text('Place Bid'));
  }

  Widget cancelBtn(context) {
    return ElevatedButton(
        onPressed: _cancelEnabled == true
            ? () {
                model.status = "cancelled";
                setBid(model);
              }
            : null,
        // onPressed: () {
        //   model.status = "cancelled";
        //   setRide(model);
        // },
        // _btnEnabled == true ? () => setRide(model) : null,
        child: const Text('Cancel Bid'));
  }

  showAlertDialog3(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: const Text("cancel Ride"),
      onPressed: () {
        model.status = "cancelled";
        setBid(model);
        Navigator.pop(context);
        // Navigator.push(
        //       context,
        //       CupertinoPageRoute(builder: (context) => setRide(model)),
        //     );
      },
    );
    Widget continueButton = TextButton(
      child: const Text("close"),
      onPressed: () {
        // deleteData(res["objectId"]);
        Navigator.pop(context);
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Please confirm"),
      content: const Text("do you really want to cancel this Bid?"),
      actions: [cancelButton, continueButton],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
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
}