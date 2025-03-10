import 'package:chatapp_with_firebase/extensions/extensions.dart';
import 'package:chatapp_with_firebase/pages/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: context.color.surface,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // Logo
            Column(
              children: [
                DrawerHeader(
                  child: Icon(
                    Icons.chat_bubble_outline,
                    size: 80,
                    color: context.color.primary,
                  ),
                ),

                // Home List Tile
                ListTile(
                  leading: Icon(Icons.home, color: context.color.onSurface),
                  title: Text(
                    "Home",
                    style: TextStyle(color: context.color.onSurface),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    // Navigate to home
                  },
                ),

                // Settings List Tile
                ListTile(
                  leading: Icon(Icons.settings, color: context.color.onSurface),
                  title: Text(
                    "Settings",
                    style: TextStyle(color: context.color.onSurface),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SettingsPage()),
                    );
                    // Navigate to settings
                  },
                ),
              ],
            ),
            Spacer(),

            // Logout List Tile
            ListTile(
              leading: Icon(Icons.logout, color: context.color.onSurface),
              title: Text(
                "Logout",
                style: TextStyle(color: context.color.onSurface),
              ),
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pop(context);
              },
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
