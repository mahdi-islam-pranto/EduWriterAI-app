import 'package:edu_writer_ai/app_theme/colors.dart';
import 'package:flutter/material.dart';

import '../widgets/app_drawer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.background,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: AppBar(
            backgroundColor: AppColors.primary,
            elevation: 0,
            iconTheme: const IconThemeData(color: Colors.transparent),
            title: const Text("Edu Writer AI",
                style: TextStyle(color: Colors.white)),
            leading: Builder(
              builder: (context) {
                return IconButton(
                  icon: const Icon(
                    Icons.menu,
                    color: AppColors.background,
                  ),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                );
              },
            ),
          ),
        ),
        drawer: AppDrawer(),
        body: const Column(
          children: [
            Text('Hello World'),
            Card(
              color: AppColors.secondary,
              elevation: 0,
              child: Text('Hello Card'),
            )
          ],
        ));
  }
}
