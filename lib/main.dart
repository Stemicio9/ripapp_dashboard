import 'package:flutter/material.dart';
import 'package:ripapp_dashboard/constants/route_constants.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  String initialRoute = "/";
  WidgetsFlutterBinding.ensureInitialized();
  runApp( MyApp(initialRoute: initialRoute));
}

class MyApp extends StatelessWidget {

  final String initialRoute;

  const MyApp({super.key,required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      supportedLocales: const [
        Locale('it'),
        Locale('en')
      ],
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.

        primarySwatch: Colors.blue,
      ),
      routes: RouteConstants.route(context) ,
      initialRoute: initialRoute,
    );
  }
}


