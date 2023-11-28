import 'dart:async';

import 'package:flutter/material.dart';
import 'package:orm/container_all.dart';
import 'package:orm/model/model.dart';
import 'package:orm/user_form_model.dart';
import 'package:orm/user_provider.dart';
import 'package:orm/user_view.dart';

void main() {
  runApp(const MainApp());
}

// ignore: must_be_immutable
class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  List<User> users = [];

  // Load users
  loadData() async {
    users = await User().select().toList();
    setState(() {});
  }

  // Delete user
  userDelete(index) async {
    await User().select().id.equals(index).delete();
    loadData();
  }

  // Load a especific user
  Future<User?> getUserFromDatabase(index) async {
    User? user = await User().select().id.equals(index).toSingle();
    return user;
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return UserProvider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'ORM For Flutter',
        home: _body(),
        routes: {
          '/create': (_) => const UserFormModel(), 
          // List of the users
          '/list': (_) => const MainApp(),
          // Edit user
          '/view': (_) => UserView(),
        },
      ),
    );
  }

  _body() {
  return Builder(
    builder: (BuildContext context) {
      UserProvider userProvider = UserProvider.of(context) as UserProvider;
      return Scaffold(
        appBar: AppBar(
          title: const Text('User list'),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.popAndPushNamed(context, '/create');
              },
              icon: const Icon(Icons.add),
            )
          ],
        ),
        body: ContainerAll(
          child: ListView.builder(
            itemCount: users.length,
            itemBuilder: (BuildContext contextBuilder, indexBuilder) => 
            Container(
              decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(width: 0.4))
              ),
              child: ListTile(
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () async {
                        User? userFromDatabase = await getUserFromDatabase(users[indexBuilder].id);
                        userProvider.nameUser = userFromDatabase?.name;
                        userProvider.emailUser = userFromDatabase?.email;
                        userProvider.passwordUser = userFromDatabase?.password;
                        userProvider.indexUser = userFromDatabase?.id;
                        Navigator.popAndPushNamed(context, '/create');
                      },
                      icon: const Icon(Icons.edit),
                    ),
                    IconButton(
                      onPressed: () async {
                        User? userFromDatabase = await getUserFromDatabase(users[indexBuilder].id);
                        userProvider.nameUser = userFromDatabase?.name;
                        userProvider.emailUser = userFromDatabase?.email;
                        userProvider.passwordUser = userFromDatabase?.password;
                        userProvider.indexUser = userFromDatabase?.id;
                        Navigator.popAndPushNamed(context, '/view');
                      },
                      icon: const Icon(Icons.visibility, color: Colors.blue),
                    ),
                    IconButton(
                      onPressed: () {
                        userProvider.indexUser = null;
                        userDelete(users[indexBuilder].id);
                      },
                      icon: const Icon(Icons.delete, color: Colors.red),
                    )
                  ],
                ),
                title: // User Id
                Text(
                  users[indexBuilder].name ?? '',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
            )
          ),
        ),
      );
    },
  );
}


}
