import 'package:flutter/material.dart';
import '../lib/presentation/GameScreen.dart.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
} 
class HomePageState extends State<HomePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>(); 
  final TextEditingController player1Controller = TextEditingController();
  final TextEditingController player2Controller = TextEditingController(); 
  @override
  Widget build(BuildContext context) { 
    return Scaffold( 
      
      backgroundColor:Colors.deepPurple[50],
      appBar: AppBar(
        centerTitle:true,
        backgroundColor: Colors.deepPurple[500],        
        title:const Text(
             'Tic Tac Toe Game' ,
              style: TextStyle(
                fontSize: 20,
                color:Colors.white,
                fontStyle: FontStyle.italic, 
              ),
            ),
         leading: IconButton(
           onPressed:(){},
          icon: const Icon(Icons.menu,color:Colors.white,size:30.0),
           
         ),
                     
        ),
     
      body: Form(
        key: _formKey, 
        child: Column( 
          mainAxisAlignment: MainAxisAlignment.center,
          children: [ 
            const Text( "Enter your Names", 
                       style: TextStyle( 
                         fontSize: 30, 
                         fontWeight: FontWeight.bold, 
                         color: Colors.deepPurple,
                         fontStyle: FontStyle.italic, 
                       ), 
                      ),
            const SizedBox(height: 20),
            Padding( 
              padding: const EdgeInsets.all(15),
              child: TextFormField(
                controller: player1Controller, 
                style:const TextStyle(color: Colors.black),
                decoration: const InputDecoration( 
                  focusedBorder: OutlineInputBorder( 
                    borderSide: BorderSide(color: Colors.deepPurple),
                  ),
                  focusedErrorBorder: OutlineInputBorder( 
                    borderSide: BorderSide(color: Colors.red),
                  ), enabledBorder: OutlineInputBorder( 
                    borderSide: BorderSide(color: Colors.deepPurple), 
                  ), errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ), 
                  hintText: "Player 1 Name", 
                  hintStyle: TextStyle(color: Colors.black),
                ), 
                validator: (value) { 
                  if (value == null || value.isEmpty) { 
                    return "Please Enter player 1 name";
                  } 
                  return null; 
                }, ), ),
           const SizedBox(height: 20),
            Padding( padding: const EdgeInsets.all(15), 
              child: TextFormField( controller: player2Controller,
          style:const TextStyle(color: Colors.black), 
        decoration: const InputDecoration( 
          focusedBorder: OutlineInputBorder( 
          borderSide: BorderSide(color: Colors.deepPurple), 
          ),
          focusedErrorBorder: OutlineInputBorder( 
            borderSide: BorderSide(color: Colors.red), ),
          enabledBorder: OutlineInputBorder( 
            borderSide: BorderSide(color: Colors.deepPurple), ), 
          errorBorder: OutlineInputBorder( 
            borderSide: BorderSide(color: Colors.red),
          ), hintText: "Player 2 Name",
          hintStyle: TextStyle(color: Colors.black), ),
                                   validator: (value) { 
                                     if (value == null || value.isEmpty) { 
                                       return "Please Enter player 2 name";
                                     } 
                                     return null;
                                   }, ), ),
            const SizedBox(height: 20), 
            InkWell( onTap: () {
              if (_formKey.currentState!.validate()) { 
                Navigator.push( context, MaterialPageRoute(
                  builder: (context) => GameScreen( 
                    player1: player1Controller.text, 
                    player2: player2Controller.text, 
                  ), 
                ), ); 
              }
            },
                      child: Container(
                                     decoration: BoxDecoration( 
                                       color: Colors.deepPurple[500],
                                       borderRadius: BorderRadius.circular(10), 
                                     ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 12, 
                          horizontal: 17), 
                        child: const Text( "Start Game", 
                                          style: TextStyle( 
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                     color: Colors.white,
                                          ), 
                                         ), ), ),
          ], ), ), ); 
  } } 