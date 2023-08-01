import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/cubit/todo_cubit_cubit.dart';

class taskscreen extends StatefulWidget {
  const taskscreen({super.key});

  @override
  State<taskscreen> createState() => _taskscreenState();
}

class _taskscreenState extends State<taskscreen> {
  @override


  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocProvider(
        create: (context) => TodoCubitCubit(),
        child: BlocConsumer<TodoCubitCubit, TodoCubitState>(
          listener: (context, state) {
            // TODO: implement listener
            if(state is TodoCubitLoading){print("Loading");}
          },
          builder: (context, state) {
            return state is TodoCubitLoading? Center(child: CircularProgressIndicator())
            :state is TodoCubitSuccess? ListView.builder(
            itemCount: context.watch<TodoCubitCubit>().tasks.length,
            itemBuilder: (BuildContext context , int index ){  
             return ListTile(title: Text(context.watch<TodoCubitCubit>().tasks[index].title??""));
        },
        ): Center(child: Text("error"),) ;
          },
        ),
      )

    );
  }
}

/*isLoading?Center(child: CircularProgressIndicator(),)
      : ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (BuildContext context , int index ){  
          return ListTile(title: Text(tasks[index].title??""));
        },
        )*/