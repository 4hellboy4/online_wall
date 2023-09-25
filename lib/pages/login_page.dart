import 'package:flutter/material.dart';
import 'package:wall_online/widgets/login_text/login_text.dart';
import 'package:wall_online/widgets/my_button/my_button.dart';
import 'package:wall_online/widgets/my_text_field/my_text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Icon(
                Icons.lock,
                size: 100,
              ),
              const SizedBox(height: 20),
              Text(
                "Welcome back, you've been missed!",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey[900],
                ),
              ),
              const SizedBox(height: 20),
              MyTextField(
                controller: _email,
                hintText: "Email",
                obscureText: false,
              ),
              const SizedBox(height: 20),
              MyTextField(
                controller: _password,
                hintText: "Password",
                obscureText: true,
              ),
              const SizedBox(height: 20),
              MyButton(
                name: "Sign In",
                onTap: () {},
              ),
              const SizedBox(height: 15),
              const LoginText(),
            ],
          ),
        ),
      ),
    );
  }
}
