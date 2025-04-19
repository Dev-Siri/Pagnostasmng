import "package:google_fonts/google_fonts.dart";
import "package:flutter/material.dart";
import "package:pagnostasmng/routes.dart";
import "package:pagnostasmng/services/task_service.dart";
import "package:pagnostasmng/services/user_service.dart";
import "package:provider/provider.dart";

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<UserService>(create: (_) => UserService()),
        Provider<TaskService>(create: (_) => TaskService()),
      ],
      builder: (_, __) => const StateWrapper(),
    );
  }
}

class StateWrapper extends StatefulWidget {
  const StateWrapper({super.key});

  @override
  State<StateWrapper> createState() => _StateWrapperState();
}

class _StateWrapperState extends State<StateWrapper> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: context.read<UserService>().user,
      builder: (context, snapshot) {
        return MaterialApp(
          title: "Pagnostasmng",
          routes: routes,
          initialRoute: snapshot.data == null &&
                  snapshot.connectionState == ConnectionState.done
              ? "/login"
              : "/",
          theme: ThemeData(
            useMaterial3: true,
            textTheme: GoogleFonts.spaceGroteskTextTheme(),
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.transparent,
              background: const Color.fromARGB(255, 255, 255, 204),
            ),
          ),
        );
      },
    );
  }
}
