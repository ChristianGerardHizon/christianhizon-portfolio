import 'package:flutter/material.dart';

class MobileDrawer extends StatelessWidget {
  final BuildContext rootContext;

  const MobileDrawer({
    super.key,
    required this.rootContext,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {},
            ),
            ExpansionTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              children: [
                ListTile(
                  leading: const Icon(Icons.person),
                  title: const Text('Account'),
                  onTap: () {},
                ),
                ListTile(
                  leading: const Icon(Icons.lock),
                  title: const Text('Privacy'),
                  onTap: () {},
                ),
              ],
            ),
            ExpansionTile(
              leading: const Icon(Icons.category),
              title: const Text('Products'),
              children: [
                ListTile(
                  leading: const Icon(Icons.list),
                  title: const Text('All Products'),
                  onTap: () {},
                ),
                ListTile(
                  leading: const Icon(Icons.star),
                  title: const Text('Featured'),
                  onTap: () {},
                ),
              ],
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {
                Navigator.pop(context);
                // handle logout logic here
              },
            ),
          ],
        ),
      ),
    );
  }
}
