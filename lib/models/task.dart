class TaskModel {
  final String task;
  bool completed;

  TaskModel({
    required this.task,
    required this.completed,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
        task: json["task"] as String,
        completed: json["completed"] as bool,
      );

  Map<String, dynamic> toJson() {
    return {
      "task": task,
      "completed": completed,
    };
  }
}
