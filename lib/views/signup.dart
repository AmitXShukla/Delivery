// import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../shared/constants.dart';
import '../models/datamodel.dart';
import '../models/validators.dart';
import '../blocs/auth.bloc.dart';

// ignore: must_be_immutable
class SignUp extends StatefulWidget {
  static const routeName = '/signup';
  SignUp({super.key,
  required this.handleBrightnessChange
  , required this.setLocale});

  Function(bool useLightMode) handleBrightnessChange;
  Function(Locale _locale) setLocale;
  @override
  SignUpState createState() => SignUpState();
}

class SignUpState extends State<SignUp> {
  bool isUserValid = false;
  bool spinnerVisible = false;
  bool messageVisible = false;
  bool _btnEnabled = false;
  String messageTxt = "";
  String messageType = "";
  final _formKey = GlobalKey<FormState>();
  InboxModel msgModel = InboxModel(
      dttm: '-',
      uid: '-',
      to: '-',
      message: '-',
      readReceipt: false,
      fileURL: '-');
  LoginDataModel model = LoginDataModel(email: 'noreply@duck.com', password: 'na',);
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    loadAuthState();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  toggleSpinner() {
    setState(() => spinnerVisible = !spinnerVisible);
  }

  void loadAuthState() async {
    final userState = await authBloc.isSignedIn();
    setState(() => isUserValid = userState);
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

  void setData(String loginType) async {
    toggleSpinner();
    // ignore: prefer_typing_uninitialized_variables
    var userAuth;
    if (loginType == "Google") {
      userAuth = await authBloc.signInWithGoogle();
    } else {
      userAuth = await authBloc.signUpWithEmail(model);
    }
    if (userAuth.success) {
      sendMessage("Congratulations, your account is created, please update your settings.");
      showMessage(true, "success", "Account created, an email is sent to your email ID, please Reset your password using that link and login back.");
      await Future.delayed(const Duration(seconds: 2));
      // navigateToUser();
    } else {
      showMessage(true, "error", userAuth.error!.message);
    }
    toggleSpinner();
  }

  void navigateToUser() {
    Navigator.pushReplacementNamed(context,'/settings');
  }

  void sendMessage(String msg) async {
    var username = await authBloc.getUser();
    // storing user uid/objectId from users class, as a field into message record
    msgModel.dttm = DateTime.now().toString();
    msgModel.uid =
        (username?.get("objectId") == null) ? "-" : username?.get("objectId");
    msgModel.to = "-";
    msgModel.message = msg;

    // ignore: prefer_typing_uninitialized_variables
    await authBloc.setMessage(msgModel);
  }

  @override
  Widget build(BuildContext context) {
    // AuthBloc authBloc = AuthBloc();
    return Scaffold(
      // appBar: createAuthBar(context),
      appBar: createNavLogInBar(context, widget),
      body: Material(
          child: Container(
              margin: const EdgeInsets.all(20.0),
              // ignore: unnecessary_null_comparison
              child: (isUserValid == true)
                  ? settingsPage(context)
                  : userForm(context)))
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
              const Icon(Icons.electric_rickshaw_outlined,
                                    color: Colors.greenAccent, size: 134),
              const SizedBox(width: 10,height: 20,),
              Container(
                  width: 300.0,
                  margin: const EdgeInsets.only(top: 25.0),
                  child: TextFormField(
                    controller: _emailController,
                    cursorColor: Colors.blueAccent,
                    keyboardType: TextInputType.emailAddress,
                    maxLength: 50,
                    obscureText: false,
                    onChanged: (value) => model.email = value,
                    validator: (value) {
                            return Validators().evalEmail(value!);
                    },
                    // onSaved: (value) => _email = value,
                    decoration: InputDecoration(
                      icon: const Icon(Icons.email),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.0)),
                      hintText: 'username@domain.com',
                      labelText: 'EmailID *',
                      // errorText: snapshot.error,
                    ),
                  )),
              Container(
                margin: const EdgeInsets.only(top: 5.0),
              ),
              Container(
                  width: 300.0,
                  margin: const EdgeInsets.only(top: 25.0),
                  child: TextFormField(
                    controller: _passwordController,
                    cursorColor: Colors.blueAccent,
                    keyboardType: TextInputType.visiblePassword,
                    maxLength: 50,
                    obscureText: true,
                    onChanged: (value) => model.password = value,
                    validator: (value) {
                            return Validators().evalPassword(value!);
                    },
                    decoration: InputDecoration(
                      icon: const Icon(Icons.lock_outline),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.0)),
                      hintText: 'enter password',
                      labelText: 'Password *',
                    ),
                  )),
              Container(
                margin: const EdgeInsets.only(top: 25.0),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
              ),
              CustomSpinner(toggleSpinner: spinnerVisible, key: null),
              CustomMessage(
                  toggleMessage: messageVisible,
                  toggleMessageType: messageType,
                  toggleMessageTxt: messageTxt, key: null,),
              Container(
                margin: const EdgeInsets.only(top: 15.0),
              ),
              // signinSubmitBtn(context, authBloc),
              signinSubmitBtn(context),
              Container(
                margin: const EdgeInsets.only(top: 15.0),
              ),
              // Chip(
              //     label: const Text("login with Google"),
              //     avatar: ElevatedButton(
              //       child: const Text(''),
              //       // onPressed: () => fetchData(authBloc, "Google"),
              //       onPressed: () => {},
              //     )),
              GestureDetector(
                child: const Chip(
                  backgroundColor: Colors.red,
                  // padding: EdgeInsets.symmetric(vertical: 15, horizontal: 5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                      topLeft: Radius.circular(15),
                      bottomLeft: Radius.circular(15),
                      )),
                  label: Text("Sign In with Google"),
                ),
                onTap: () {
                  setData("Google");
                },
              ),
              Container(
                margin: const EdgeInsets.only(top: 15.0),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/',
                  );
                },
                child: const Chip(
                    avatar: CircleAvatar(
                      backgroundColor: Colors.black26,
                      child: Text("-"),
                    ),
                    label: Text("already have an Account")),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget signinSubmitBtn(context) {
    return ElevatedButton(
      onPressed:
          _btnEnabled == true ? () => setData("email") : null,
      child: const Text('Sign Up')
    );
  }

  Widget settingsPage(context) {
    return Center(
      child: Column(
        children: [
          // const Chip(
          //     avatar: CircleAvatar(
          //       backgroundColor: Colors.grey,
          //       child: Icon(Icons.home, color: Colors.blue,),
          //     ),
          //     label: Text("welcome to Manualify!.", style: cNavText)),
          const SizedBox(width: 20, height: 50),
          ElevatedButton(
            child: const Text('click here to go to Dashboard.'),
            // color: Colors.blue,
            onPressed: () {
              Navigator.pushReplacementNamed(
                context,
                '/',
              );
            },
          ),
          // const SizedBox(width: 20, height: 70),
          // ElevatedButton(
          //   child: const Text('Logout'),
          //   // color: Colors.blue,
          //   onPressed: () {
          //     // return logout(authBloc);
          //   },
          // ),
        ],
      ),
    );
  }
}
