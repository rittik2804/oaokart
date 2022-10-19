import 'package:flutter/material.dart';

class NoInternet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: size.height / 5,
              width: size.width / 2,
              margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/no-internet.png"),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Text(
              "No Internet Connection",
              style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.none,
                  color: Colors.red),
            ),
            Padding(
              padding: EdgeInsets.all(5),
              child: Text(
                "You are not connected to the internet.Make sure Wi-Fi or MOBILE DATA is on, Airplane Mode is Off and try again.",
                style: TextStyle(
                  fontSize: 15,
                  decoration: TextDecoration.none,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}


/*

AlertDialog(
      title: Text('No Internet'),
      content: Text('You are not connected to the internet.'),
    );

*/