import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:animated_toggle_switch/animated_toggle_switch.dart'; // Add this line to import the package
import 'package:lite_rolling_switch/lite_rolling_switch.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  List<bool> isSelected = [true, false];
  int select = 0;
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
              trailing: 
              ///selecte language,
              
                CupertinoSlidingSegmentedControl(
                groupValue: select,
                children: const {
                  0: Text('English'),
                  1: Text('Arabic'),
                  3: Text('French'),
                },
                onValueChanged: (value) {
                  setState(() {
                  // Add your logic here based on the selected value
                  print(value);
                  select = value as int;

                  });
                },
                ),
            ),
            SizedBox(
              height: 10,
            ),
            ListTile(
              title: const Text("Theme"),
              trailing: Container(
                height:45,
                child: LiteRollingSwitch(
                  width: 120,
                
                  
                  onTap: () {
                    // Add your onTap logic here
                  },
                  onDoubleTap: () {
                    // Add your onDoubleTap logic here
                  },
                  onSwipe: () {
                    // Add your onSwipe logic here
                  },
                  //initial value
                  value: true,
                  textOn: 'light',
                  textOff: 'dark',
                  colorOn: Colors.blue,
                  colorOff: Colors.red,
                  iconOn: Icons.light_mode,
                  iconOff: Icons.dark_mode,
                  textSize: 16.0,
                  onChanged: (bool state) {
                    //Use it to manage the different states
                    print('Current State of SWITCH IS: $state');
                  },
                ),
              ),
            ),
             SizedBox(
              height: 10,
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
        ));
  }
}
