import 'package:flutter/material.dart';
import 'package:orm/container_all.dart';
import 'package:orm/user.dart';
import 'package:orm/user_provider.dart';

class UserList extends StatefulWidget {
  const UserList({super.key});

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  
  @override
  Widget build(BuildContext context) {

    UserProvider userProvider = UserProvider.of(context) as UserProvider;
    List<User> users = userProvider.users;

    int usersLength = users.length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('User list'),
        leading: BackButton(
          onPressed: () {
            userProvider.indexUser = null;
            Navigator.popAndPushNamed(context, '/create');
          },
        ),
      ),
      body: ContainerAll(
        child: ListView.builder(
          itemCount: usersLength,
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
                      userProvider.userSelected = users[indexBuilder];
                      userProvider.indexUser = indexBuilder;
                      Navigator.popAndPushNamed(context, '/create');
                    },
                    icon: const Icon(Icons.edit),
                  ),
                  IconButton(
                    onPressed: () {
                      userProvider.userSelected = users[indexBuilder];
                      userProvider.indexUser = indexBuilder;
                      Navigator.popAndPushNamed(context, '/view');
                    },
                    icon: const Icon(Icons.visibility, color: Colors.blue),
                  ),
                  IconButton(
                    onPressed: () {
                      userProvider.indexUser = null;
                      userProvider.users.removeAt(indexBuilder);
                      Navigator.popAndPushNamed(context, '/list');
                    },
                    icon: const Icon(Icons.delete, color: Colors.red),
                  )
                ],
              ),
              title: Text(users[indexBuilder].name),
            ),
          )
        ),
      ),
    );
  }
}