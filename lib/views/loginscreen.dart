// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/views/homepage.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  final _formKey = GlobalKey<FormState>(); //definition of the form 
  bool _showpassword = false;
  TextEditingController emailcontrol = TextEditingController();
  TextEditingController passwordcontrol = TextEditingController();
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [

              /* Code for the Logo Image*/
              Container(
                width: 500,
                height:350,
                child: Image.asset("assets/Logo.png"),
              ),

              /*Code for Email Input*/ 
              TextFormField(
                controller: emailcontrol,  //This returns the email written by user in emailcontrol
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if(value!.isNotEmpty && value!.contains("@")){}
                  else {
                    return "Please enter a valid email.";
                  }
                },
              ),
              SizedBox(height: 10,),
             
                 /*Code for password Input*/
                TextFormField(
                  controller: passwordcontrol,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                    suffixIcon: IconButton(
                      onPressed: (){setState(() {
                            _showpassword = !_showpassword;
                          });},
                            icon: Icon(_showpassword ? Icons.visibility : Icons.visibility_off,  // ternary operator 
                          color: Colors.grey,  ))
                  ),
                  obscureText: !_showpassword,

                  //the validator is to check for the conditions for the password input 
                  validator: (value) {
                    if(value!.length>8||value!.length==8){}
                    else {
                      return "Password must be 8 digits at least.";
                    }
                  },
                  
                ),

              /*Code for Log in Button */
              SizedBox(height: 30,),
               Center(
                child: SizedBox(
                  width: 300,
                  height: 50,
                  child:
                  ElevatedButton(
                    onPressed: () async {
                      
                      if (_formKey.currentState!.validate()) {
                        bool success = await firebaselogin(emailcontrol.text, passwordcontrol.text);
                       if(success) {final SharedPreferences prefs = await SharedPreferences.getInstance();
                        await prefs.setString('Email', emailcontrol.text);
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) =>  Homepage(),
                          ),
                        );
                       }else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Input Invalid'))
                        );

                       }
                     }},
                      child: Text(
                        'Log In',
                        //textAlign: TextAlign.center ,
                        ),
                    )
                  ),
                  ),
              
              /*Code for forgot password button*/
              SizedBox(height: 15,),
              Text(
                'Forgot password? Tap me',
                style: TextStyle(fontSize: 17,color: Colors.grey),
              ),
              SizedBox(height: 40,),

              /*code for the sign up button*/
              Center(
              child: SizedBox(
                width: 300,
                height: 50,
                child: TextButton(
                  onPressed: () {
                    // Add your sign-up logic here
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 206, 206, 206)),
                    foregroundColor: MaterialStateProperty.all<Color>(const Color.fromARGB(255, 69, 69, 69)),
                    
                    ),
                  
                  child: Text(
                    'No account? Sign up',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ),
         
          ], 
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton( onPressed: () {  },
      child: Icon(Icons.help),),
    );
  }
 Future<bool> firebaselogin(String email , String password) async {
  try {
  final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
    email: email,
    password: password,
  );
  if(credential.user!=null){
    return true;
  }
} on FirebaseAuthException catch (e) {
  if (e.code == 'user-not-found') {
    print('No user found for that email.');
  } else if (e.code == 'wrong-password') {
    print('Wrong password provided for that user.');
  }
} 
return false;

}
}