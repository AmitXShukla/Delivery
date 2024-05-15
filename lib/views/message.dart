import 'package:flutter/material.dart';
import '../shared/constants.dart';
import '../models/datamodel.dart';
import '../models/validators.dart';
import '../blocs/auth.bloc.dart';

// ignore: must_be_immutable
class Message extends StatefulWidget {
  static const routeName = '/message';
  Message({super.key,
  required this.handleBrightnessChange
  , required this.setLocale});

  Function(bool useLightMode) handleBrightnessChange;
  Function(Locale _locale) setLocale;
  @override
  MessageState createState() => MessageState();
}

class MessageState extends State<Message> {
  bool isUserValid = true;
  bool spinnerVisible = false;
  bool messageVisible = false;
  bool _btnEnabled = false;
  String messageTxt = "";
  String messageType = "";
  final _formKey = GlobalKey<FormState>();
  InboxModel model = InboxModel(dttm: '-', uid: '-', to: '-', message: '-', 
              readReceipt: false, fileURL: '-');
  final TextEditingController _txtController = TextEditingController();

  @override
  void initState() {
    loadAuthState();
    super.initState();
  }
  
  void loadAuthState() async {
    final userState = await authBloc.isSignedIn();
    setState(() => isUserValid = userState);
    var username = await authBloc.getUser();
    // storing user uid/objectId from users class, as a field into message record
    model.dttm = DateTime.now().toString();
    model.uid = (username?.get("objectId") ==  null) ? "-" : username?.get("objectId");
    model.to = "ADMIN";
  }

  @override
  void dispose() {
    _txtController.dispose();
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

  void setData(InboxModel model) async {
    toggleSpinner();
    // ignore: prefer_typing_uninitialized_variables
    var userData;
    userData = await authBloc.setMessage(model);
    if (userData == true) {
      showMessage(true, "success", "message sent to Admin.");
    } else {
      showMessage(true, "error", "something went wrong, please contact your Admin.");
    }
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
                  ? userForm(context)
                  : loginPage(context)))
    );
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
                width: 200,
                child: Row(
                  children: [
                    const Text("new message", style: cBodyText,),
                    const SizedBox(width: 10,),
                    ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(
                      context,
                      '/inbox',
                    );
                  },
                          child: const Text('back')
                        ),
                  ],
                ),
              ),
              Container(
                  width: 300.0,
                  margin: const EdgeInsets.only(top: 25.0),
                  child: TextFormField(
                    controller: _txtController,
                    cursorColor: Colors.blueAccent,
                    keyboardType: TextInputType.text,
                    maxLength: 50,
                    obscureText: false,
                    onChanged: (value) => model.message = value,
                    validator: (value) {
                            return Validators().evalChar(value!);
                    },
                    // onSaved: (value) => _email = value,
                    decoration: InputDecoration(
                      icon: const Icon(Icons.person),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.0)),
                      hintText: 'Message',
                      labelText: 'Message *',
                      // errorText: snapshot.error,
                    ),
                  )),
              Container(
                margin: const EdgeInsets.only(top: 5.0),
              ),
              const Text("upload documents", style: cBodyText,),
              CustomSpinner(toggleSpinner: spinnerVisible, key: null),
              CustomMessage(
                  toggleMessage: messageVisible,
                  toggleMessageType: messageType,
                  toggleMessageTxt: messageTxt, key: null,),
              Container(
                margin: const EdgeInsets.only(top: 15.0),
              ),
              // signinSubmitBtn(context, authBloc),
              sendBtn(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget sendBtn(context) {
    return ElevatedButton(
      onPressed:
          _btnEnabled == true ? () => setData(model) : null,
      child: const Text('send message')
    );
  }

  Widget loginPage(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Chip(
              avatar: CircleAvatar(
                backgroundColor: Colors.grey,
                child: Icon(Icons.warning, color: Colors.red,),
              ),
              label: Text("please Login again, you are currently signed out.", style: cErrorText)),
          const SizedBox(width: 20, height: 50),
          ElevatedButton(
            child: const Text('Login'),
            // color: Colors.blue,
            onPressed: () { Navigator.pushNamed(
                    context,
                    '/',
                  );},
          ),
        ],
      ),
    );
  }
}