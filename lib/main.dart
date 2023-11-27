import 'package:flutter/material.dart';
import 'package:orm/container_all.dart';
import 'package:orm/model/model.dart';
import 'package:orm/user_form.dart';
import 'package:orm/user_list.dart';
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

  loadData() async {
    users = await User().select().toList();
    setState(() {});
  }

  userAdd(String userName) async {
    User user = User();
    user.name = userName;
    await user.save();

    loadData();
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
          '/create': (_) => const UserForm(), 
          // List of the users
          '/list': (_) => const UserList(),
          // Edit user
          '/view': (_) => UserView(),
        },
      ),
    );
  }

  _body() {
    // UserProvider userProvider = UserProvider.of(context) as UserProvider;
    return Scaffold(
      appBar: AppBar(
        title: const Text('User list'),
        leading: BackButton(
          onPressed: () {
            // userProvider.indexUser = null;
            Navigator.popAndPushNamed(context, '/create');
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
              userAdd("Daniel");
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
                    onPressed: () {
                      // userProvider.userSelected = users[indexBuilder];
                      // userProvider.indexUser = indexBuilder;
                      Navigator.popAndPushNamed(context, '/create');
                    },
                    icon: const Icon(Icons.edit),
                  ),
                  IconButton(
                    onPressed: () {
                      // userProvider.userSelected = users[indexBuilder];
                      // userProvider.indexUser = indexBuilder;
                      Navigator.popAndPushNamed(context, '/view');
                    },
                    icon: const Icon(Icons.visibility, color: Colors.blue),
                  ),
                  IconButton(
                    onPressed: () {
                      // userProvider.indexUser = null;
                      // userProvider.users.removeAt(indexBuilder);
                      Navigator.popAndPushNamed(context, '/list');
                    },
                    icon: const Icon(Icons.delete, color: Colors.red),
                  )
                ],
              ),
              title: Text(users[indexBuilder].name ?? ""),
            ),
          )
        ),
      ),
    );
  }

}
