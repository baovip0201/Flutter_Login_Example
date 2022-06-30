import 'package:flutter/material.dart';
import 'package:flutter_login_api/pages/home_page.dart';
import 'package:flutter_login_api/pages/login_page.dart';
import 'package:flutter_login_api/pages/register_page.dart';
import 'package:flutter_login_api/service/api_service.dart';
import 'package:flutter_login_api/service/shared_service.dart';

Widget defalut_home = const LoginPage();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  bool _result = await SharedService.isLoggedIn();
  if (_result) {
    defalut_home = const HomePage();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/': (context) => defalut_home,
        '/home': (context) => const HomePage(),
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
      },
    );
  }
}
