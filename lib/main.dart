import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'connectivity.dart';
import 'home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => ConnectivityProvider(),
            child: MyHomePage(
              title: 'OAOKART',
            ),
          ),
        ],
        child: MaterialApp(
            title: 'OAOKART',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: MyHomePage(
              title: 'OAOKART',
            )));
  }
}
