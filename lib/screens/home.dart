import "package:flutter/material.dart";
import "package:neubrutalism_ui/neubrutalism_ui.dart";
import "package:pagnostasmng/models/task.dart";
import "package:pagnostasmng/services/task_service.dart";
import "package:pagnostasmng/services/user_service.dart";
import "package:pagnostasmng/widgets/feature_card.dart";
import "package:pagnostasmng/widgets/task_tile.dart";
import "package:provider/provider.dart";

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _createTaskController = TextEditingController();

  String _user = "";
  List<TaskModel> _tasks = [];

  @override
  void initState() {
    _fillUser();
    _fetchTasks();
    super.initState();
  }

  @override
  void dispose() {
    _createTaskController.dispose();
    super.dispose();
  }

  Future<void> _fetchTasks() async {
    final tasks = await context.read<TaskService>().getTasks();

    setState(() => _tasks = tasks);
  }

  Future<void> _createTask() async {
    await context
        .read<TaskService>()
        .createTask(task: _createTaskController.text);

    setState(
      () => _tasks.add(
        TaskModel(
          task: _createTaskController.text,
          completed: false,
        ),
      ),
    );

    _createTaskController.text = "";
  }

  Future<void> _deleteTask(String task) async {
    await context.read<TaskService>().deleteTask(task: task);

    setState(() => _tasks.removeWhere((stateTask) => stateTask.task == task));
  }

  Future<void> _taskToggleCompletion(String task) async {
    await context.read<TaskService>().taskToggleCompletion(task: task);

    setState(() {
      int index = _tasks.indexWhere((decodedTask) => decodedTask.task == task);

      if (index != -1) {
        _tasks[index].completed = !_tasks[index].completed;
      }
    });
  }

  Future<void> _fillUser() async {
    final ctxUser = await context.read<UserService>().user;

    if (ctxUser != null) return setState(() => _user = ctxUser);

    Navigator.pushReplacementNamed(context, "/login");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 300,
              margin: const EdgeInsets.only(top: 50),
              child: ListView(
                scrollDirection: Axis.horizontal,
                addAutomaticKeepAlives: false,
                children: [
                  const FeatureCard(
                    label: "Create a task",
                    icon: Icons.task_alt,
                  ),
                  FeatureCard(
                    label: "Organize your tasks",
                    icon: Icons.checklist,
                    color: Theme.of(context).colorScheme.background,
                    textColor: Colors.black,
                  ),
                  const FeatureCard(
                    label: "Never forget things again",
                    icon: Icons.emoji_events_rounded,
                    color: Colors.pink,
                    textColor: Colors.white,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 30),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "Hi $_user!",
                          style: const TextStyle(fontSize: 22),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: FractionallySizedBox(
                      widthFactor: 1,
                      child: NeuSearchBar(
                        searchController: _createTaskController,
                        searchBarColor:
                            Theme.of(context).colorScheme.background,
                        searchBarIcon: const Icon(Icons.add),
                        hintText: "Create a task",
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      NeuTextButton(
                        buttonColor: Theme.of(context).colorScheme.background,
                        onPressed: _createTask,
                        child: const Padding(
                          padding: EdgeInsets.all(8),
                          child: Text("Create"),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 200, // Limit the height of the list view
                    child: ListView.builder(
                      itemCount: _tasks.length,
                      itemBuilder: (BuildContext context, int index) {
                        final task = _tasks[index];

                        return TaskTile(
                          task: task,
                          onDelete: () => _deleteTask(task.task),
                          onToggleCompletion: () =>
                              _taskToggleCompletion(task.task),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
