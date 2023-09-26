import 'package:flutter/material.dart';

class RegText extends StatelessWidget {
  const RegText({
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
            "Already have an account?",
            style: TextStyle(
              color: Colors.grey[700],
            ),
          ),
          const Text(
            "Login now",
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
