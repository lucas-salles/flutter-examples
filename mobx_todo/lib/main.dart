import 'package:flutter/material.dart';
import 'package:mobx_todo/screens/login_screen.dart';
import 'package:mobx_todo/stores/login_store.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider<LoginStore>(
      create: (_) => LoginStore(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primaryColor: Colors.deepPurpleAccent,
          primarySwatch: Colors.deepPurple,
          textSelectionTheme: TextSelectionThemeData(
            cursorColor: Colors.deepPurpleAccent,
          ),
          scaffoldBackgroundColor: Colors.deepPurpleAccent,
        ),
        debugShowCheckedModeBanner: false,
        home: LoginScreen(),
      ),
    );
  }
}
