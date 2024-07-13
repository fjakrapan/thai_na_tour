import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:thai_na_tour/services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final _email = TextEditingController();
  final _password = TextEditingController();

  @override
  void initState() {
    super.initState();
    AuthService.checkLogin().then((loggedIn) {
      if (loggedIn) {
        Navigator.pushReplacementNamed(context, '/home');
      }
    });
  }

  Future<void> login() async {
    bool loggedIn = await AuthService.login(_email.text, _password.text);
    if (loggedIn) {
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(children: [
          Text('โปรดเข้าสู่ระบบ'),
          TextFormField(
            controller: _email,
            decoration: InputDecoration(
              labelText: 'อีเมล',
            ),
          ),
          TextFormField(
            controller: _password,
            decoration: InputDecoration(
              labelText: 'รหัสผ่าน',
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              login();
            },
            child: Text('เข้าสู่ระบบ'),
          ),
        ]),
      ),
    );
  }
}
