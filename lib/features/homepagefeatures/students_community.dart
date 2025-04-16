import 'package:flutter/material.dart';
class StudentsCommunity extends StatelessWidget {
  const StudentsCommunity({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // backgroundColor: Colors.green.shade300,
          title: Text("Students Community",style: TextStyle(fontWeight: FontWeight.w600),)),
      body: Center(child: Text("Welcome to our students Community", style: TextStyle(fontSize: 24))),
    );
  }
}
