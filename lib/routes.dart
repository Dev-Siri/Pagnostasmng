import "package:flutter/material.dart";
import "package:pagnostasmng/screens/home.dart";
import "package:pagnostasmng/screens/login.dart";

final Map<String, WidgetBuilder> routes = {
  "/": (context) => const Home(),
  "/login": (context) => const Login(),
};
