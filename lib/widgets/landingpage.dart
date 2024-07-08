import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/img.jpeg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(onPressed: (){}, 
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                  backgroundColor: Colors.grey[800],
                  
                ),
                child: Text('Get Started', style: TextStyle(fontSize: 20, color: Colors.white),)),
                SizedBox(height: 50,),
                 Text('Welcome to Hadith App', style: TextStyle(fontSize: 30, color: Colors.white),),
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}