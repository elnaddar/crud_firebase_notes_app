import 'package:flutter/material.dart';
import '/pages/pages.dart';

final Map<String, Widget Function(BuildContext)> routes = {
  "/": (BuildContext context) => const HomePage(),
};
