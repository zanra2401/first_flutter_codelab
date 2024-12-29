import 'package:flutter/material.dart';
import '../components/app_bar.dart';
import '../components/main_body_homepage.dart';

class HomePage extends StatelessWidget {

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: Header(),
      body: TaskList(),
    );
  }
}