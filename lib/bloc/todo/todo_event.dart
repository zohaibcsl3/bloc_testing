import 'package:equatable/equatable.dart';

abstract class ToDoEvent extends Equatable {
  const ToDoEvent();
}

class AddTaskEvent extends ToDoEvent {
  @override
  List<Object?> get props => [];
}

class DeleteTaskEvent extends ToDoEvent {
  @override
  List<Object?> get props => [];
}
