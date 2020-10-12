import 'package:flutter/material.dart';

class MyLogin extends StatelessWidget{
  @override
  Widget build(BuildContext context){
   return Scaffold(
     body:Column(
       mainAxisAlignment: MainAxisAlignment.center,
       children: [
         Text(
           'Welcome',
           style: Theme.of(context).textTheme.headline1,
         ),
         TextFormField(
           decoration: InputDecoration(
             hintText: 'Username',
           ),
         ),
         TextFormField(
           decoration: InputDecoration(
             hintText: 'Password',
           ),
         ),
         SizedBox(),
         RaisedButton(
           color: Colors.yellow,
           child: Text('ENTER'),
           onPressed: () {
             Navigator.pushReplacementNamed(context, '/catalog');
           },
         )
       ],
     ),
   );
  }
}