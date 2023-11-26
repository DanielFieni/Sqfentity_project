import 'package:flutter/material.dart';
import 'package:orm/user_form.dart';
import 'package:orm/user_list.dart';
import 'package:orm/user_provider.dart';
import 'package:orm/user_view.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return UserProvider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'ORM For Flutter',
        home: const UserForm(),
        routes: {
          '/create': (_) => const UserForm(), 
          // List of the users
          '/list': (_) => const UserList(),
          // Edit user
          '/view': (_) => UserView(),
        },
      ),
    );
  }
}
