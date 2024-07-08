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
            // image: DecorationImage(
            //   image: AssetImage('assets/img.jpeg'),
            //   fit: BoxFit.cover,
            // ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text('بَلغُوا عَنِي وَلو آيةٌ', textAlign: TextAlign.center,textDirection: TextDirection.rtl,style: TextStyle(fontWeight: FontWeight.bold, fontSize: 90 ),),
                const  SizedBox(height: 100,),
                ElevatedButton(onPressed: (){
                  Navigator.pushNamed(context, '/listCathegorie');
                }, 
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  //when clicked
                  foregroundColor: Colors.white10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),

                   
                  
                ),
                child: Text('Get Started', style: TextStyle(fontSize: 20,color: Theme.of(context).colorScheme.onSecondary), )),
               const  SizedBox(height: 100,),
                Text(
                  'Welcome to Hadith App',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    fontFamily: 'Robot Slab',
                    color: Theme.of(context).colorScheme.onSecondary,
                  ),
                ),
               const SizedBox(height: 100,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}