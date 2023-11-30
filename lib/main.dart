import 'dart:async';

import 'package:flutter/material.dart';
import 'package:orm/container_all.dart';
import 'package:orm/fav_menu_button.dart';
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
  
  // Order by name ASC
  // users = await User().select().orderBy("name").toList();

  // Order by name DESC
  // users = await User().select().orderByDesc("name").toList();

  // Order by five top user by name
  // users = await User().select().orderBy("name").top(5).toList();

  

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
      home: Scaffold(
        appBar: AppBar(
          title: const Text('ORM For Flutter'),
        ),
        body: _body(),
        floatingActionButton: const FavMenuButton(),
      ),
      routes: {
        '/create': (_) => const UserFormModel(),
        '/list': (_) => const MainApp(),
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
                        if(context.mounted) Navigator.popAndPushNamed(context, '/create');
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
                        if(context.mounted) Navigator.popAndPushNamed(context, '/view');
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
