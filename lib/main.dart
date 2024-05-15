import 'package:flutter/material.dart';
import './views/app.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  const keyApplicationId = '';
  const keyClientKey = '';
  const keyParseServerUrl = 'https://parseapi.back4app.com';
  await Parse().initialize(keyApplicationId, keyParseServerUrl,
      clientKey: keyClientKey, autoSendSessionId: true);
      // var firstObject = ParseObject('FirstClass')..set(
      //                 'message', 'Hey ! Second message from Flutter. Parse is now connected');
      // await firstObject.save();  
      // print('done');

  runApp(const App());
}