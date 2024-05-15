import 'dart:math';
import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import '../shared/constants.dart';
import '../models/datamodel.dart';
import '../models/validators.dart';
import '../blocs/auth.bloc.dart';
import 'package:flutter/cupertino.dart';

// ignore: must_be_immutable
class Bids extends StatefulWidget {
  static const routeName = '/bids';
  Bids({super.key, required this.handleBrightnessChange
  , required this.setLocale});

  Function(bool useLightMode) handleBrightnessChange;
  Function(Locale _locale) setLocale;
  @override
  BidsState createState() => BidsState();
}

class BidsState extends State<Bids> {
  List<ParseObject> results = <ParseObject>[];
  // ignore: prefer_typing_uninitialized_variables
  bool isUserValid = true;
  bool spinnerVisible = false;
  bool messageVisible = false;
  String messageTxt = "";
  String messageType = "";

  @override
  void initState() {
    super.initState();
    loadAuthState();
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
    var res = await authBloc.getBids("Bids", "driver");
    setState(() {
      results = res;
    });
    toggleSpinner();
  }

  // deleteData(docID) async {
  //   await authBloc.delDoc("Rides", docID);
  //   getData();
  // }

  @override
  Widget build(BuildContext context) {
    // AuthBloc authBloc = AuthBloc();
    return Scaffold(
        appBar: createCustomerNavBar(context, widget),
        body: Material(
            child: Container(
                margin: const EdgeInsets.all(20.0),
                child: (isUserValid == true)
                    ? bidHistory(context)
                    : loginPage(context))));
  }

  Widget bidHistory(BuildContext context) {
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
                      '/bid',
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
                      label: Text("place a new bid")),
                ),
                const Text(
                  "recent bids",
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
                            'Status',
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
                                    res["rideDttm"].toString(),
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
                              Text(res["status"]),
                            ),
                            DataCell(
                              Row(
                                children: [
                                  // IconButton(
                                  //   // iconSize: 20.0,
                                  //   onPressed: () {
                                  //     showAlertDialog1(context, res);
                                  //   },
                                  //   icon: const Icon(Icons.zoom_in,
                                  //       color: Colors.blue),
                                  //   tooltip: 'Details',
                                  // ),
                                  // const SizedBox(
                                  //   width: 10,
                                  // ),
                                  IconButton(
                                    icon: const Icon(Icons.trolley),
                                    color: Colors.green,
                                    tooltip: 'Bids',
                                    onPressed: () {
                                      showAlertDialog1(context, res);
                                    },
                                  ),
                                  // const SizedBox(
                                  //   width: 10,
                                  // ),
                                  // IconButton(
                                  //   icon: const Icon(Icons.edit),
                                  //   color: Colors.orangeAccent,
                                  //   tooltip: 'Edit',
                                  //   onPressed: () {
                                  //     showAlertDialog1(context, res);
                                  //   },
                                  // ),
                                ],
                              ),
                            )
                          ]),
                        )
                        .toList(),
                  ),
                ),
                results.isEmpty
                    ? const Text("no bids data found.")
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
      child: const Text("Edit Bid"),
      onPressed: () {
        Navigator.pop(context);
        Navigator.push(
          context,
          CupertinoPageRoute(
              builder: (context) => EditBid(
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
      title: Text(res["rideDttm"].toString()),
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
                  "Bid : ",
                  style: cNavText,
                ),
                Text(res['bid'].toString()),
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
class EditBid extends StatefulWidget {
  final String docId;
  // const EditBid({super.key, required this.docID});
  // Function(bool useLightMode) handleBrightnessChange;
  const EditBid({super.key, required this.docId});
  @override
  EditBidState createState() => EditBidState();
}

class EditBidState extends State<EditBid> {
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
    final userData = await authBloc.getBidDoc("Bids", widget.docId);

    if (userData.isNotEmpty) {
      setState(() {
      model.objectId = userData[0]["objectId"];
      model.rideId = userData[0]["objectId"];
      model.rideDttm = userData[0]["rideDttm"];
      model.uid = userData[0]["uid"];
      model.driver = (username?.get("objectId") ==  null) ? "-" : username?.get("objectId");
      model.from = userData[0]["from"];
      model.to = userData[0]["to"];
      model.status = "new";
      model.fileURL = userData[0]["fileURL"];
      model.bid = userData[0]["bid"];
      model.message = userData[0]["message"];

      _bidController.text = model.bid;
      _messageController.text = model.message;  
      });
    }
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
                      "Edit Bid",
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
                            '/bids',
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
                    maxLength: 30,
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
              // Container(
              //   margin: const EdgeInsets.only(top: 5.0),
              // ),
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
                  SizedBox(
                    width: 200,
                    child: CheckboxListTile(
                      value: _cancelEnabled,
                      onChanged: (newValue) =>
                          setState(() => _cancelEnabled = !_cancelEnabled),
                      title: const Text("cancel bid"),
                    ),
                  ),
                  cancelBtn(context),
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
        child: const Text('Update'));
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
      child: const Text("cancel Bid"),
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
      content: const Text("do you really want to cancel this bid?"),
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