import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:tasks_fonibo/model.dart';
import 'package:tasks_fonibo/task_tile.dart';
import 'dart:convert';

class TasksScreen extends StatefulWidget {
  @override
  _TasksScreenState createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {

  Future<List<Task>> _getTasks() async{
    var data = await http.get('https://cdn.fonibo.com/challenges/tasks.json');
    if(data.statusCode==200) {
      var jsonData = json.decode(data.body);
      List<Task> tasks = [];
      for (var t in jsonData) {
        Task task = Task(t['id'], t['title'], t['createdAt']);
        tasks.add(task);
      }
      return tasks;
    }

  }



  @override
  Widget build(BuildContext context) {
    Color blue = Color(0xff0176E1);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {}
            ,
            icon: Icon(Icons.menu, color: blue, size: 30,),
          ),
          title: Text('task.', style: TextStyle(color: blue, fontSize: 23, fontWeight: FontWeight.bold)),
          centerTitle: true,
          shadowColor: blue.withOpacity(0.1),
          elevation: 10,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          backgroundColor: Colors.white,
          elevation: 0,
          child: Container(
            child: Icon(Icons.add, color: blue, size: 40,),
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(100),
              ),
              boxShadow: [
                BoxShadow(
                  color: blue.withOpacity(0.3),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: Offset(2, 3),
                ),
              ],
            ),
          ),
        ),
        body: Container(
          padding: EdgeInsets.all(15.0),
          child: Column(
            children: [
              Text('Tasks', style: TextStyle(fontSize: 18.0)),
              SizedBox(height: 15.0),
              FutureBuilder(
                future: _getTasks(),
                builder: (BuildContext context, AsyncSnapshot snapshot){
                  if (snapshot.data==null){
                    return Container(
                      child: Center(
                        child: Text('Loading...'),
                      ),
                    );
                  }
                  return ListView.builder(
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index){
                      DateTime createdAt = DateTime.parse(snapshot.data[index].createdAt);
                      return TaskTile(
                        title: snapshot.data[index].title,
                        createdAt: DateFormat.yMd().add_Hm().format(createdAt),
                      );
                    },
                  );
                },
              )  
            ],
          ),
        ),
      ),
    );
  }
}
