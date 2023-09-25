import 'package:flutter/material.dart';

class LoginText extends StatelessWidget {
  const LoginText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          "Not a member?",
          style: TextStyle(
            color: Colors.grey[700],
          ),
        ),
        GestureDetector(
          onTap: () => () {},
          child: const Text(
            "Register now",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
        )
      ],
    );
  }
}
