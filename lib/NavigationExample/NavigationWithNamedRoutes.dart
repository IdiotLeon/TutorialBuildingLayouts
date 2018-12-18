import 'package:flutter/material.dart';

class AppNavigationWithNameRoutes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Named Routes Demo',
        // Start the app with the "/" route. In our case, the app will start
        // on the FirstScreen Widget
        initialRoute: '/',
        routes: {
          // When we navigate to the "/" route, build the FirstScreen Widget
          '/': (context) => FirstScreen(),
          // When we navigate to the "/second" route, build the SecondScreen Widget
          '/second': (context) => SecondScreen(),
        });
  }
}

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('First Screen'),
      ),
      body: Center(
          child: RaisedButton(
        onPressed: () {
          // To navigate to second screen when tapped!
          Navigator.pushNamed(context, '/second');
        },
        child: Text('Launch Screen'),
      )),
    );
  }
}

class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Second Screen"),
        ),
        body: Center(
            child: RaisedButton(
          onPressed: () {
            // To navigate back to the first screen
            // by popping the current route off the stack
            Navigator.pop(context);
          },
          child: Text("Go back!"),
        )));
  }
}
