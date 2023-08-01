import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Homepage extends StatefulWidget {

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
     String email ="";

   Future<void> getEmail() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    email = prefs.getString('Email')??'--';
    setState(() {
    });
    }
    @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getEmail();
  }
    
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
      ),
      body: Center(
        child: Text("Welcome: $email"),

      ),
      
  );
  }
}