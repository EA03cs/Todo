import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:todos/Models/getTodo.dart';
import 'package:todos/Screen/widgets/Item.dart';
import 'package:http/http.dart' as http;

class ItemOfTodos extends StatefulWidget {
  const ItemOfTodos({super.key});

  @override
  _ItemOfTodosState createState() => _ItemOfTodosState();
}

class _ItemOfTodosState extends State<ItemOfTodos> {
  List<Items> itemss = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchTodoData(); // Initial fetch
  }

  Future<void> fetchTodoData() async {
    if (isLoading) return;

    setState(() {
      isLoading = true;
    });

    final response =
        await http.get(Uri.parse('https://api.nstack.in/v1/todos'));

    if (response.statusCode == 200) {
      final fetchedData = getTodo.fromJson(jsonDecode(response.body));
      setState(() {
        itemss = fetchedData.items ?? [];
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      throw Exception('Failed to load tasks');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: itemss.isEmpty && isLoading
          ? const Center(child: CircularProgressIndicator())
          : itemss.isEmpty
              ? const Center(
                  child: Text(
                    'No tasks available',
                    style: TextStyle(color: Colors.white),
                  ),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: itemss.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Item(
                        title: itemss[index].title!,
                        desc: itemss[index].description!,
                        id: itemss[index].sId!,
                      ),
                    );
                  },
                ),
    );
  }
}
