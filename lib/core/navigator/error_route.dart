import 'package:flutter/material.dart';

Route<dynamic> errorRoute() {
  return MaterialPageRoute(
    builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Page Not Found'),
        ),
        body: const Center(
          child: Text('ERROR: Route not found'),
        ),
      );
    },
  );
}

Widget noPage() {
  return Scaffold(
    appBar: AppBar(title: const Text('Page Not Done')),
    body: const Center(
      child: Text('Page Still In Production'),
    ),
  );
}
