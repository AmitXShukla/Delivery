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

// //
// // comment prvious and uncomment below section
// // pro ui code
// //
// import 'package:flutter/material.dart';
// import 'views/pro_ui/shared/env.dart';
// import 'views/pro_ui/shared/app_scroll.dart';
// import './views/pro_ui/demo.dart';

// void main() => runApp(App());

// class App extends StatelessWidget {

//   static String _pkg = "bubble_tab_bar";
//   static String? get pkg => Env.getPackage(_pkg);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       scrollBehavior: AppScrollBehavior(),
//       debugShowCheckedModeBanner: false,
//       home: BubbleTabBarDemo(),
//     );
//   }
// }