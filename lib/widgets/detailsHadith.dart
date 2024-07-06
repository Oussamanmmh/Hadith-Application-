import 'package:flutter/material.dart';

class DetailsHadith extends StatelessWidget {
  const DetailsHadith({Key? key, required this.id});
  final String id; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 90,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Text("Details Hadith"),
      ),
      body: Center(
        child: Text("Details Hadith $id"),
      ),
    );
  }
}