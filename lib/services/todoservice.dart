import 'package:dio/dio.dart';
import 'package:test/models/todo_model.dart';

class TodoService{

  String url = "https://jsonplaceholder.typicode.com/todos";

  Future<List<TodoModel>> getTasks() async {

    List<TodoModel> tasks = [];
    Response response = await Dio().get(url);
    var data = response.data;
    data.forEach((element){
      TodoModel task = TodoModel.fromJson(element);
      tasks.add(task);
    });  
     return tasks;
  }
}