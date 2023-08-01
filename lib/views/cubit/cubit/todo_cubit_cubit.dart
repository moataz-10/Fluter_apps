
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/todo_model.dart';
import '../../../services/todoservice.dart';

part 'todo_cubit_state.dart';

class TodoCubitCubit extends Cubit<TodoCubitState> {
  TodoCubitCubit() : super(TodoCubitInitial()){
    getTasksFromApi();
  }
   
  List<TodoModel> tasks = [];
  getTasksFromApi() async {
  try  {emit(TodoCubitLoading());
    tasks = await TodoService().getTasks();
    emit(TodoCubitSuccess());}
    catch(e){
        print("error");
        emit(TodoCubitError());
    }
    
  }
}
