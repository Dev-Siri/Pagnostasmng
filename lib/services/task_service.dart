import "dart:convert";

import "package:flutter/foundation.dart";
import "package:pagnostasmng/models/task.dart";
import "package:shared_preferences/shared_preferences.dart";

class TaskService {
  static const tasksKey = "tasks";

  List<TaskModel> _decodeTasks(String jsonTasks) {
    final List decodedTasks = jsonDecode(jsonTasks);
    final tasks = decodedTasks
        .map((decodedTask) => TaskModel.fromJson(decodedTask))
        .toList();

    return tasks;
  }

  String _encodeTasks(List<TaskModel> tasks) {
    final jsonTasks = jsonEncode(tasks);

    return jsonTasks;
  }

  Future<List<TaskModel>> getTasks() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final storedTasks = sharedPreferences.getString(tasksKey);

    if (storedTasks == null) return [];

    final tasks = await compute(_decodeTasks, storedTasks);

    return tasks;
  }

  Future<void> createTask({required String task}) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    var storedTasks = sharedPreferences.getString(tasksKey) ?? "[]";

    final tasks = await compute(_decodeTasks, storedTasks);

    tasks.add(TaskModel(
      task: task,
      completed: false,
    ));

    final newTasksEncoded = await compute(_encodeTasks, tasks);
    sharedPreferences.setString(tasksKey, newTasksEncoded);
  }

  Future<void> deleteTask({required String task}) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    var storedTasks = sharedPreferences.getString(tasksKey) ?? "[]";

    final tasks = await compute(_decodeTasks, storedTasks);

    tasks.removeWhere((decodedTask) => decodedTask.task == task);

    final newTasksEncoded = await compute(_encodeTasks, tasks);
    sharedPreferences.setString(tasksKey, newTasksEncoded);
  }

  Future<void> taskToggleCompletion({required String task}) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    var storedTasks = sharedPreferences.getString(tasksKey) ?? "[]";

    final tasks = await compute(_decodeTasks, storedTasks);

    int index = tasks.indexWhere((decodedTask) => decodedTask.task == task);

    if (index != -1) {
      tasks[index].completed = !tasks[index].completed;
    }

    final newTasksEncoded = await compute(_encodeTasks, tasks);
    sharedPreferences.setString(tasksKey, newTasksEncoded);
  }
}
