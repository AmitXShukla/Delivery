import 'package:flutter/material.dart';
import '../blocs/auth.bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

const double narrowScreenWidthThreshold = 450;

const double mediumWidthBreakpoint = 1000;
const double largeWidthBreakpoint = 1500;

const double transitionLength = 500;
var mailCount = 0;
var userType = "Customer";
bool isBright = true;

const cAppTitle = "Deliverify";
// ignore: camel_case_types
enum cMessageType { error, success }
const cBodyText = TextStyle(
  fontWeight: FontWeight.w400,
  color: Colors.blueGrey,
);
const cErrorText = TextStyle(
  fontWeight: FontWeight.w400,
  color: Colors.red,
);
const cWarnText = TextStyle(
  fontWeight: FontWeight.w400,
  color: Colors.yellow,
);
const cSuccessText = TextStyle(
  fontWeight: FontWeight.w400,
  color: Colors.green,
);

const cNavText = TextStyle(
    color: Colors.blueAccent,
    fontSize: 16.0,
    fontWeight: FontWeight.w500,
    fontStyle: FontStyle.normal);

const cHeaderText = TextStyle(
    color: Colors.blueAccent,
    fontSize: 20.0,
    fontWeight: FontWeight.w500,
    fontStyle: FontStyle.normal);

class CustomSpinner extends StatelessWidget {
  final bool toggleSpinner;
  const CustomSpinner({super.key, required this.toggleSpinner});

  @override
  Widget build(BuildContext context) {
    return Center(child: toggleSpinner ? const CircularProgressIndicator() : null);
  }
}

class CustomMessage extends StatelessWidget {
  final bool toggleMessage;
  // ignore: prefer_typing_uninitialized_variables
  final toggleMessageType;
  final String toggleMessageTxt;
  const CustomMessage(
      {super.key,
      required this.toggleMessage,
      this.toggleMessageType,
      required this.toggleMessageTxt})
      : super();

  @override
  Widget build(BuildContext context) {
    return Center(
        child: toggleMessage
            ? Text(toggleMessageTxt,
                style: toggleMessageType == cMessageType.error.toString()
                    ? cErrorText
                    : cSuccessText)
            : null);
  }
}

// Whether the user has chosen a theme color via a direct [ColorSeed] selection,
// or an image [ColorImageProvider].
enum ColorSelectionMethod {
  colorSeed,
  image,
}

enum ColorSeed {
  baseColor('M3 Baseline', Color(0xff6750a4)),
  indigo('Indigo', Colors.indigo),
  blue('Blue', Colors.blue),
  teal('Teal', Colors.teal),
  green('Green', Colors.green),
  yellow('Yellow', Colors.yellow),
  orange('Orange', Colors.orange),
  deepOrange('Deep Orange', Colors.deepOrange),
  pink('Pink', Colors.pink);

  const ColorSeed(this.label, this.color);
  final String label;
  final Color color;
}

enum ColorImageProvider {
  leaves('Leaves',
      'https://flutter.github.io/assets-for-api-docs/assets/material/content_based_color_scheme_1.png'),
  peonies('Peonies',
      'https://flutter.github.io/assets-for-api-docs/assets/material/content_based_color_scheme_2.png'),
  bubbles('Bubbles',
      'https://flutter.github.io/assets-for-api-docs/assets/material/content_based_color_scheme_3.png'),
  seaweed('Seaweed',
      'https://flutter.github.io/assets-for-api-docs/assets/material/content_based_color_scheme_4.png'),
  seagrapes('Sea Grapes',
      'https://flutter.github.io/assets-for-api-docs/assets/material/content_based_color_scheme_5.png'),
  petals('Petals',
      'https://flutter.github.io/assets-for-api-docs/assets/material/content_based_color_scheme_6.png');

  const ColorImageProvider(this.label, this.url);
  final String label;
  final String url;
}

enum ScreenSelected {
  component(0),
  color(1),
  typography(2),
  elevation(3);

  const ScreenSelected(this.value);
  final int value;
}

PreferredSizeWidget createNavLogInBar(BuildContext context, widget) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.electric_rickshaw_outlined, color: Colors.greenAccent),
        onPressed: () { Navigator.pushNamed(
                  context,
                  '/',
                );},
        tooltip: "home",
      ),
      // title: const Text(cAppTitle, style: cBodyText,),
      title: Text(AppLocalizations.of(context)!.cAppTitle, style: cBodyText,),
      actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.power),
            tooltip: 'about us',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Powered by elish consulting.')));
            },
          ),
          IconButton(
            icon: const Icon(Icons.email_rounded),
            tooltip: 'contact',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('MAKING EVERY DELIVERY A DELIGHT : info@elishconsulting.com')));
            },
          ),
          IconButton(
            icon: const Icon(Icons.dark_mode_outlined),
            tooltip: 'toggle brightness',
            onPressed: () {
              isBright = !isBright;
              widget.handleBrightnessChange(isBright);
            },
          ),
          PopupMenuButton(
          initialValue: 1,
          tooltip: 'toggle language',
          onSelected: (item) {
            switch (item) { // Your Enum Value which you have passed
                case 1:
                  widget.setLocale(const Locale.fromSubtags(languageCode: 'en'));
                  break;
                case 2:
                  widget.setLocale(const Locale.fromSubtags(languageCode: 'es'));
                  break;
            }
          },
          itemBuilder: (BuildContext context) => <PopupMenuEntry>[
            const PopupMenuItem(
              value: 1,
              child: Text('English'),
            ),
            const PopupMenuItem(
              value: 2,
              child: Text('Spanish', style: cNavText,),
            )
          ],
        ),
          // IconButton(
          //   icon: const Icon(Icons.language, color: Colors.green),
          //   tooltip: 'language',
          //   onPressed: () {
          //     isBright = !isBright;
          //     widget.handleBrightnessChange(isBright);
          //   },
          // ),
        ],
      );
  }

  PreferredSizeWidget createCustomerNavBar(BuildContext context, widget) { 
    var data = authBloc.getMessages("Messages", "-");
    data.then((value) => mailCount = value.length);
    var username = authBloc.getUserType();
    username.then((value) => userType = (value.isEmpty) ? "Customer" : value[0]["userType"]);
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.electric_rickshaw_outlined, color: Colors.greenAccent),
        // icon: const Icon(Icons.menu),
        // icon: const Image(image: AssetImage('../assets/afronalalogo.png')),
        // onPressed: () { Scaffold.of(context).openDrawer(); },
        onPressed: () { Navigator.pushNamed(
                  context,
                  '/settings',
                );},
        tooltip: "home",
      ),
      // title: const Text(cAppTitle, style: cBodyText,),
      title: Text(AppLocalizations.of(context)!.cAppTitle, style: cBodyText,),
      actions: <Widget>[
        (userType == "Customer") ? 
        IconButton(
            icon: const Icon(Icons.fire_truck_sharp, color: Colors.brown,),
            tooltip: 'Rides',
            onPressed: () {
              Navigator.pushReplacementNamed(
                context,
                '/rides',
              );
            },
          )
          :
          IconButton(
            icon: const Icon(Icons.trolley, color: Colors.green,),
            tooltip: 'Bids',
            onPressed: () {
              Navigator.pushReplacementNamed(
                context,
                '/bids',
              );
            },
          ),
          IconButton(
            // icon: const Icon(Icons.email, color: Colors.blueAccent,),
            icon: Badge(label: Text(mailCount.toString()), textColor: Colors.white, backgroundColor: Colors.red,
            child: const Icon(Icons.email, color: Colors.blueAccent)),
            tooltip: 'Inbox',
            onPressed: () {
              Navigator.pushReplacementNamed(
                context,
                '/inbox',
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.account_box, color: Colors.blueGrey,),
            tooltip: 'settings',
            onPressed: () {
              Navigator.pushReplacementNamed(
                context,
                '/settings',
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.dark_mode_outlined, color: Colors.grey),
            tooltip: 'toggle brightness',
            onPressed: () {
              isBright = !isBright;
              widget.handleBrightnessChange(isBright);
            },
          ),
          PopupMenuButton(
          initialValue: 1,
          tooltip: 'toggle language',
          onSelected: (item) {
            switch (item) { // Your Enum Value which you have passed
                case 1:
                  widget.setLocale(const Locale.fromSubtags(languageCode: 'en'));
                  break;
                case 2:
                  widget.setLocale(const Locale.fromSubtags(languageCode: 'es'));
                  break;
            }
          },
          itemBuilder: (BuildContext context) => <PopupMenuEntry>[
            const PopupMenuItem(
              value: 1,
              child: Text('English'),
            ),
            const PopupMenuItem(
              value: 2,
              child: Text('Spanish', style: cNavText,),
            ),
          ],
        ),
          // IconButton(
          //   icon: const Icon(Icons.language, color: Colors.green),
          //   tooltip: 'language',
          //   onPressed: () {
          //     isBright = !isBright;
          //     widget.handleBrightnessChange(isBright);
          //   },
          // ),
        ],
      );
  }