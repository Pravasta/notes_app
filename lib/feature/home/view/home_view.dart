import 'package:flutter/material.dart';
import 'package:notes_app/core/utils/app_assets.dart';
import 'package:notes_app/main.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  static const RouteSettings routeSettings = RouteSettings(name: '/home');

  @override
  Widget build(BuildContext context) {
    Widget emptyContent() {
      return Column(
        spacing: 20,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('${AppAssets.imagesPath}empty.png', scale: 3.5),
          Text('Empty notes', style: appTextTheme(context).displayMedium),
          Text(
            'Once you create notes, it will appear here\nSo, let\'s create one now!',
            style: appTextTheme(context).titleMedium,
            textAlign: TextAlign.center,
          ),
        ],
      );
    }

    Widget content() {
      return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemBuilder: (context, index) {
          return Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Title', style: appTextTheme(context).titleMedium),
                Text('Content', style: appTextTheme(context).bodyMedium),
              ],
            ),
          );
        },
      );
    }

    return Scaffold(
      body: Padding(padding: const EdgeInsets.all(20.0), child: content()),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }
}
