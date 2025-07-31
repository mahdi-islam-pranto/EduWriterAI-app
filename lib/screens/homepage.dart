import 'package:edu_writer_ai/app_theme/theme.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: AppBar(
            backgroundColor: Colors.black,
            elevation: 0,
            iconTheme: const IconThemeData(color: Colors.transparent),
            title:
                const Text("HomePage", style: TextStyle(color: Colors.white)),
          ),
        ),
        body: Column(
          children: [
            Text('Hello World'),
          ],
        ));
  }
}
