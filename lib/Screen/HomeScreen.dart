import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:todos/Screen/widgets/Builder.dart';
import '../Models/getTodo.dart';
import 'create.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color(0xffff7460),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CreateScreen()),
            );
          },
          child: const Icon(Icons.add),
        ),
        backgroundColor: const Color(0xFF2B2F3A),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Welcome Back!',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
              const Text(
                'Elsayed Atef',
                style: TextStyle(
                    fontSize: 26,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 50,
                    width: 310,
                    decoration: BoxDecoration(
                      color: const Color(0xffff7460),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    alignment: Alignment.centerLeft,
                    // Move text to the left
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    // Optional: Add padding to the text
                    child: Text(
                      DateFormat.yMMMMEEEEd().format(DateTime.now()),
                      style: const TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Today Task's",style: TextStyle(color: Colors.white,fontSize: 30,fontWeight: FontWeight.w400),),
                ],
              ),
               const SizedBox(
                height: 10,
               ),

              const SizedBox(
                height: 20,
              ),
              const ItemOfTodos(),
            ],
          ),
        ),
      ),
    );
  }

}
