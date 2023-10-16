import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wall_online/provider/log_or_reg_toggle.dart';
import 'package:wall_online/widgets/my_button/my_button.dart';
import 'package:wall_online/widgets/my_text_field/my_text_field.dart';
import 'package:wall_online/widgets/register_text/reg_text.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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

  void signUp() async {
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    if (_password.text != _confirmedPassword.text) {
      Navigator.pop(context);

      displayMsg("Password don't match");
      return;
    }

    try {
      UserCredential userCreds =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _email.text,
        password: _password.text,
      );

      FirebaseFirestore.instance
          .collection("Users")
          .doc(userCreds.user!.email)
          .set({
        "name": _email.text.split("@")[0],
        "bio": "Bio is empty...",
      });
      if (context.mounted) Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      displayMsg(e.code);
    }
  }

  void displayMsg(String txt) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text(txt),
      ),
    );
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
                obscureText: false,
              ),
              const SizedBox(height: 20),
              MyTextField(
                controller: _confirmedPassword,
                hintText: "Confirm password",
                obscureText: true,
              ),
              const SizedBox(height: 20),
              MyButton(
                name: "Sign In",
                onTap: signUp,
              ),
              const SizedBox(height: 15),
              RegText(
                onTap: Provider.of<ToggleProvider>(context, listen: false)
                    .tapToggle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
