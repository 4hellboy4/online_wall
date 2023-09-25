import 'package:flutter/material.dart';
import 'package:wall_online/widgets/login_text/login_text.dart';
import 'package:wall_online/widgets/my_button/my_button.dart';
import 'package:wall_online/widgets/my_text_field/my_text_field.dart';

class RegosterPage extends StatefulWidget {
  const RegosterPage({Key? key}) : super(key: key);

  @override
  _RegosterPageState createState() => _RegosterPageState();
}

class _RegosterPageState extends State<RegosterPage> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmedPassword = TextEditingController();

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _confirmedPassword.dispose();
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
                "Let's create an account for you",
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
