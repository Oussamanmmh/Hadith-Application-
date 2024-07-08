import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:animated_toggle_switch/animated_toggle_switch.dart'; // Add this line to import the package
import 'package:hadith_app/options/languages.dart';
import 'package:hadith_app/widgets/modeModel.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  List<bool> isSelected = [true, false];
@override
  void initState() {
    super.initState();
  }
// late  bool  mode ;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          appBar: AppBar(
            toolbarHeight: 90,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                color: Theme.of(context).colorScheme.onSecondary,
              ),
            ),
            title: const Text("Settings"),
          ),
          body: Column(
            children: [
              ListTile(
                title: const Text("Language"),
                trailing:  

                   

                    CupertinoSlidingSegmentedControl(
                  groupValue: Provider.of<LanguageModel>(context).getSelect,
                  children: const {
                    0: Text('English'),
                    1: Text('Arabic'),
                    2: Text('French'),
                  },
                  onValueChanged: (value )  {
                 
                   
                    setState(() {
                     Provider.of<LanguageModel>(context, listen: false)
                        .changeLanguage(value!);
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
                  height: 45,
                  child: LiteRollingSwitch(
                    width: 120,

                    onTap: () {
                     Provider.of<ModeModel>(context, listen: false).changeMode();

                      print("the mode now is : " + Provider.of<ModeModel>(context , listen: false).getmode.toString());
                    },
                    onDoubleTap: () {
                      // Add your onDoubleTap logic here
                    },
                    onSwipe: () {
                      // Add your onSwipe logic here
                    },
                    //initial value
                    value: Provider.of<ModeModel>(context).getmode,
                    textOn: 'light',
                    textOff: 'dark',
                    colorOn: Colors.grey,
                    colorOff: Colors.black,
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
          )
          );
          
    
  }
}
