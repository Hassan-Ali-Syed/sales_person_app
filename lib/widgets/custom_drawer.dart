import 'package:flutter/material.dart';
import 'package:sales_person_app/constants/constants.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    super.key,
    this.logOutOnTap,
  });
  final void Function()? logOutOnTap;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        backgroundColor: AppColors.backgroundColor,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: AppColors.grey,
              ),
              child: Center(
                child: Text(
                  'Drawer Header',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                  ),
                ),
              ),
            ),
            ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('Log Out'),
                onTap: logOutOnTap),
          ],
        ),
      ),
    );
  }
}
