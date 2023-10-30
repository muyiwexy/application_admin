import 'package:application_admin/controller/app_controllers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  DatabaseProvider? databaseProvider;
  @override
  void initState() {
    databaseProvider = Provider.of(context, listen: false);
    databaseProvider!.getDocument();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: Center(
        child: ElevatedButton(
            onPressed: () {
              for (var element in databaseProvider!.documentModel!) {
                print(element.token);
                databaseProvider!.sendNotification(element.token!);
              }
            },
            child: const Text("Send Push Notification")),
      ),
    );
  }
}
