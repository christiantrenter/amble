import 'package:amble/screens/create_account.dart';
import 'package:amble/screens/login_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/init_screen.dart';
import 'screens/home_screen.dart';
import 'screens/login_page.dart';
import 'screens/create_account.dart';

void main() {
  runApp(AmbleApp());
}

class AmbleApp extends StatelessWidget {
  Future<String?> getLoginStatus() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('loginStatus');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Amble',
      theme: ThemeData(
        primarySwatch: Colors.grey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => FutureBuilder<String?>(
          future: getLoginStatus(),
          builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Scaffold(body: Center(child: CircularProgressIndicator()));
            } else {
              if (snapshot.hasError) {
                return Scaffold(body: Center(child: Text('Error: ${snapshot.error}')));
              } else {
                return snapshot.data == 'loggedIn' ? HomeScreen() : InitScreen();
              }
            }
          },
        ),
        '/init': (context) => InitScreen(),
        '/home': (context) => HomeScreen(),
        '/login': (context) => LoginPage(),
        '/create_account': (context) => CreateAccountPage(),
      },
    );
  }
}
