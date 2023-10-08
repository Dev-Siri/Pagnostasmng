import "package:flutter/material.dart";
import "package:neubrutalism_ui/neubrutalism_ui.dart";
import "package:pagnostasmng/models/task.dart";

class TaskTile extends StatelessWidget {
  final TaskModel task;
  final VoidCallback onDelete;
  final VoidCallback onToggleCompletion;

  const TaskTile({
    super.key,
    required this.task,
    required this.onDelete,
    required this.onToggleCompletion,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: FractionallySizedBox(
        widthFactor: 1,
        child: NeuContainer(
          color: Theme.of(context).colorScheme.background,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Text(
                    task.task,
                    style: TextStyle(
                      decoration: task.completed
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                ),
                Row(
                  children: <Widget>[
                    IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: onToggleCompletion,
                      icon: const Icon(Icons.check),
                    ),
                    IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: onDelete,
                      icon: const Icon(Icons.delete),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
