import 'package:chatapp_with_firebase/extensions/extensions.dart';
import 'package:chatapp_with_firebase/themes/theme_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.color.surface,
      appBar: AppBar(title: Text('Settings Page')),
      body: Row(
        children: [
          Text('Dark Mode'),
          CupertinoSwitch(
            value:
                Provider.of<ThemeProvider>(context, listen: false).isDarkMode,
            onChanged:
                (value) =>
                    Provider.of<ThemeProvider>(
                      context,
                      listen: false,
                    ).toggleTheme(),
          ),
        ],
      ),
    );
  }
}
