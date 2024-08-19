import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../Models/model.dart';
import 'widgets/showSnackBar.dart';

class EditScreen extends StatefulWidget {
  final String id;
  final String currentTitle;
  final String currentDescription;

  const EditScreen({
    super.key,
    required this.id,
    required this.currentTitle,
    required this.currentDescription,
  });

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;

  @override
  void initState() {
    super.initState();
    // Initialize the controllers with the current data
    titleController = TextEditingController(text: widget.currentTitle);
    descriptionController = TextEditingController(text: widget.currentDescription);
  }

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
                    editTodo(widget.id);
                  },
                  child: const Text('Save'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<setTodo> editTodo(String id) async {
    final response = await http.put(
      Uri.parse('https://api.nstack.in/v1/todos/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "title": titleController.text,
        "description": descriptionController.text,
        "is_completed": false,
      }),
    );

    if (response.statusCode == 201) {
      final todo = setTodo.fromJson(jsonDecode(response.body));
      showSnackBar(context, 'Todo edited successfully', Colors.green);

      Navigator.pop(context, todo);
    } else {
      showSnackBar(context, 'Failed to edit todo', Colors.red);
    }
    return setTodo.fromJson(jsonDecode(response.body));
  }
}
