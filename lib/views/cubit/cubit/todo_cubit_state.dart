part of 'todo_cubit_cubit.dart';

@immutable
abstract class TodoCubitState {}

class TodoCubitInitial extends TodoCubitState {}

class TodoCubitLoading extends TodoCubitState {}

class TodoCubitSuccess extends TodoCubitState {}

class TodoCubitError extends TodoCubitState {}


