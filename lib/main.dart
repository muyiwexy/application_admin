import 'package:application_admin/pages/home_page.dart';
import 'package:application_admin/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'controller/app_controllers.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<ClientProvider>(create: (_) => ClientProvider()),
      ChangeNotifierProvider<DatabaseProvider>(create: (context) {
        final client = Provider.of<ClientProvider>(context, listen: false);
        return DatabaseProvider(client.client);
      }),
      ChangeNotifierProvider<AccountProvider>(create: (context) {
        final client = Provider.of<ClientProvider>(context, listen: false);
        return AccountProvider(client.client);
      }),
    ],
    child: const MainApp(),
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
      routes: {
        '/home': (context) => const Homepage(),
      },
    );
  }
}
