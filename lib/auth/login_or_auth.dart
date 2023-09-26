import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wall_online/pages/login_page.dart';
import 'package:wall_online/pages/register_page.dart';
import 'package:wall_online/provider/log_or_reg_toggle.dart';

class LoginOrAuth extends StatelessWidget {
  const LoginOrAuth({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool toggle =
        Provider.of<ToggleProvider>(context, listen: true).toggle;

    if (!toggle) {
      return const LoginPage();
    } else {
      return const RegisterPage();
    }
  }
}
