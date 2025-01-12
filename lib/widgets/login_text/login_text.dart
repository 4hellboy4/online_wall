import 'package:flutter/material.dart';

class LoginText extends StatelessWidget {
  const LoginText({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Not a member?",
            style: TextStyle(
              color: Colors.grey[700],
            ),
          ),
          const Text(
            "Register now",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          )
        ],
      ),
    );
  }
}
