import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  List<bool> isSelected = [true, false];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 90,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text("Settings"),
      ),
      body: Column(
        children: [
          ListTile(
            title: const Text("Language"),
            trailing: const Text("English"),
          ),
          ListTile(
            title: const Text("Theme"),
            trailing: ToggleButtons(
              children: const [
                Icon(Icons.light_mode),
                Icon(Icons.dark_mode),
              ],
              isSelected: [true, false],
              onPressed: (int index) {
                setState(() {
                  for (int buttonIndex = 0; buttonIndex < isSelected.length; buttonIndex++) {
                    if (buttonIndex == index) {
                      isSelected[buttonIndex] = true;
                    } else {
                      isSelected[buttonIndex] = false;
                    }
                  }
                });
              },
            ),
          ),
          ListTile(
            title: const Text("Font Size"),
            trailing: const Text("Medium"),
          ),
          ListTile(
            title: const Text("About"),
            trailing: const Icon(Icons.arrow_forward_ios),
          ),
        ],
      )
    );
  }
}