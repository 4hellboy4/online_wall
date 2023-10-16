import 'package:flutter/material.dart';
import 'package:wall_online/widgets/my_tile/my_tile.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({
    Key? key,
    required this.goToProfilePage,
    required this.logoutPage,
  }) : super(key: key);

  final void Function()? goToProfilePage;
  final void Function()? logoutPage;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.grey[900],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            children: <Widget>[
              const DrawerHeader(
                child: Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 65,
                ),
              ),
              MyTile(
                  icon: Icons.home,
                  text: "H O M E",
                  onTap: () => Navigator.pop(context)),
              MyTile(
                icon: Icons.person_2,
                text: "P R O F I L E",
                onTap: goToProfilePage,
              ),
            ],
          ),
          MyTile(
            icon: Icons.exit_to_app,
            text: "L O G O U T",
            onTap: logoutPage,
          ),
        ],
      ),
    );
  }
}
