import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../Models/model.dart';
import 'widgets/showSnackBar.dart';

class CreateScreen extends StatefulWidget {
  const CreateScreen({super.key});

  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFF2B2F3A),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Align(
                    alignment: Alignment.topLeft,
                    child: Icon(Icons.arrow_back_ios_new, color: Colors.white),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                TextField(
                  style: const TextStyle(color: Colors.white),
                  controller: titleController,
                  decoration: const InputDecoration(
                    labelText: 'Title',
                    labelStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  style: const TextStyle(color: Colors.white),
                  controller: descriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Description',
                    labelStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    postTodo();
                  },
                  child: const Text('Create Task'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<setTodo> postTodo() async {
    final response = await http.post(
      Uri.parse('https://api.nstack.in/v1/todos'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "title": titleController.text,
        "description": descriptionController.text,
        "is_completed": false
      }),
    );

    if (response.statusCode == 201) {
      final todo = setTodo.fromJson(jsonDecode(response.body));
      showSnackBar(context, 'Todo created successfully', Colors.green);

      Navigator.pop(context, todo);
    } else {
      showSnackBar(context, 'Failed to create todo', Colors.red);
    }
    return setTodo.fromJson(jsonDecode(response.body));
  }
}
