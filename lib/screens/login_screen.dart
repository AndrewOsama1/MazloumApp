import 'package:flutter/material.dart';
import 'package:mazloum_app/provider/login_provider.dart';
import 'package:mazloum_app/screens/credit_card_screen.dart';
import 'package:mazloum_app/screens/profile_screen.dart';
import 'package:mazloum_app/services/login_service.dart';
import 'package:mazloum_app/widgets/mazloum_app_bar.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
   LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
   if(context.watch<LoginProvider>().cookie.isEmpty) {
     return SafeArea(
       child: Scaffold(
         appBar: MazloumAppBar(isDetailed: true,hasBack: true, title: '',),
           body: Column(
           mainAxisAlignment: MainAxisAlignment.start,
           crossAxisAlignment: CrossAxisAlignment.center,
           children: [
             Padding(
               padding: const EdgeInsets.all(8.0),
               child: SizedBox(child: Image.asset("images/logo.png")),
             ),
             Padding(
               padding: const EdgeInsets.all(8.0),
               child: Text("Login with your email & password"),
             ),
             Padding(
               padding: EdgeInsets.all(10),
               child: TextField(
                 controller: emailController,
                 decoration: InputDecoration(
                   border: OutlineInputBorder(),
                   labelText: 'Email',
                   hintText: 'Email',
                 ),
               ),
             ),
             Padding(
               padding: EdgeInsets.all(10),
               child: TextField(
                 controller: passwordController,
                 decoration: InputDecoration(
                   border: OutlineInputBorder(),
                   labelText: 'Password',
                   hintText: 'Password',
                 ),
               ),
             ),
             Padding(
               padding: const EdgeInsets.all(8.0),
               child: Row(children: [
                 Switch.adaptive(value: false, onChanged: (value) {}),
                 Text("Remember me"),
                 Spacer(),
                 Text("Forgot password",
                     style: TextStyle(decoration: TextDecoration.underline)),
               ],),
             ),
             Container(
               width: 300,
               padding: const EdgeInsets.all(10),
               child: ElevatedButton(
                 onPressed: () {
                   print(emailController.text);
                   print(passwordController.text);
                   LoginService().login(
                       emailController.text, passwordController.text);
                 },
                 //icon data for elevated button
                 child: const Text("Login"), //label text
                 style: ElevatedButton.styleFrom(
                     primary: Colors.black //elevated btton background color
                 ),
               ),
             )
           ])),
     );
   } else{
     return ProfileScreen();
   }



  }
}