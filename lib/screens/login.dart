import "package:flutter/material.dart";
import "package:neubrutalism_ui/neubrutalism_ui.dart";
import "package:pagnostasmng/services/user_service.dart";
import "package:provider/provider.dart";

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _nameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    await context.read<UserService>().setUser(_nameController.text);

    Navigator.pushReplacementNamed(context, "/");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Who are you?",
              style: TextStyle(fontSize: 44, fontWeight: FontWeight.bold),
            ),
            const Center(
              child: Text(
                "We need to know only your name to show you your correct tasks & personalize the experience",
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: NeuSearchBar(
                searchController: _nameController,
                hintText: "Name",
                searchBarColor: Theme.of(context).colorScheme.background,
                searchBarIcon: const Icon(Icons.person),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  NeuTextButton(
                    onPressed: _login,
                    buttonColor: Theme.of(context).colorScheme.background,
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("Let's go!"),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
