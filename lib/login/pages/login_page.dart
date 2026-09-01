import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_4/home/pages/main_navigationbar_page.dart';
import 'package:flutter_application_4/login/pages/create_account_page.dart';
import 'package:flutter_application_4/login/pages/forgot_password_page.dart';
import 'package:flutter_application_4/login/widgets/custom_button.dart';
import 'package:flutter_application_4/login/widgets/customtextfield_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  bool hidePassword = false;
  bool loading = false;


  Future login() async{
    setState(() {
      loading = true;
    });

    try {

      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailcontroller.text.trim(), 
        password: passwordcontroller.text.trim()
      );

      if(!mounted) return;
      setState(() {
        loading = false;
      });
      showMessage("Logged in successfully");

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainNavigationbarPage()));


    } on FirebaseAuthException catch(e) {
      if(!mounted) return;
      setState(() {
        loading = false;
      });

      showMessage(e.message ?? "Login Failed");
    }
  }

  @override
  void dispose() {
    emailcontroller.dispose();
    passwordcontroller.dispose();
    super.dispose();
  }

  void showMessage(String message){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login Page"),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            CustomtextfieldWidget(
              controller: emailcontroller, 
              text: "Enter your email", 
              icon: Icons.mail
            ),
            SizedBox(height: 20,),
            CustomtextfieldWidget(
              controller: passwordcontroller, 
              text: "Enter your password",
              icon: Icons.lock,
              obscureText: hidePassword,
              showPasswordIcon: true,
              onPressed: () {
                setState(() {
                  hidePassword = !hidePassword;
                });
              },
            ),
            SizedBox(height: 20,),
            Align(
              alignment: Alignment.centerRight,
              child: InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPasswordPage()));
                },
                child: Text("Forgot Password?", style: TextStyle(color: Colors.blue),)),
            ),
            SizedBox(height: 20,),
            CustomButton(
              onpressed: login,
              text: "Login", 
              loading: loading
            ),
            SizedBox(height: 20,),
            Align(
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Are you new?  "),
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => CreateAccountPage()));
                    },
                    child: Text("Create Account", style: TextStyle(color: Colors.blue),))

                ],
              ),
            )
            
          ],
        ),
      ),
    );
  }
}