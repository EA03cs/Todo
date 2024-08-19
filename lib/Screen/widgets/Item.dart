import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:todos/Screen/EditScreen.dart';

import '../../Models/getTodo.dart';
import '../create.dart';

class Item extends StatefulWidget {
  const Item({super.key, required this.title, required this.desc, required this.id});
  final String title;
  final String desc;
  final String id;

  @override
  State<Item> createState() => _ItemState();
}

class _ItemState extends State<Item> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      width: 100,
      decoration: BoxDecoration(
        color: const Color(0xff404454),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0,horizontal: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.title,style: const TextStyle(color: Colors.white,fontSize: 20),),
            const SizedBox(
              height: 5,
            ),
            Text(widget.desc,style: const TextStyle(color: Colors.grey),),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(DateFormat.yMMMMEEEEd().format(DateTime.now()),style: const TextStyle(color: Colors.grey),),
                Row(
                  children: [
                    IconButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> EditScreen(id: widget.id, currentTitle:  widget.title, currentDescription: widget.desc,)));
                    }, icon:const Icon(Icons.edit,color: Color(0xff308484),)),
                    IconButton(onPressed: (){
                      setState(() {
                        deleteTodo(widget.id);
                      });
                      }, icon: const Icon(Icons.delete,color: Colors.red,)),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<Items>deleteTodo(String id) async {
    final response = await http.delete(Uri.parse('https://api.nstack.in/v1/todos/$id'));
    if (response.statusCode == 200) {
      print('Todo deleted successfully');
    } else {
      print('Failed to delete todo');
    }
    return Items.fromJson(jsonDecode(response.body));
  }
}
