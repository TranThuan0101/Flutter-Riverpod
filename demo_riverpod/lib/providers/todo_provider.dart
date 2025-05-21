import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/todo.dart';
import 'package:uuid/uuid.dart';

final todoListProvider = StateNotifierProvider<TodoNotifier, List<Todo>>((ref) {
  return TodoNotifier();
});

class TodoNotifier extends StateNotifier<List<Todo>> {
  TodoNotifier() : super([]);

  void add(String title) {
    final newTodo = Todo(id: const Uuid().v4(), title: title);
    state = [...state, newTodo];
  }

  void remove(String id) {
    state = state.where((todo) => todo.id != id).toList();
  }
}
