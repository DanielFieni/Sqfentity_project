import 'package:flutter/material.dart';
import 'package:orm/container_all.dart';
import 'package:orm/field_form.dart';
import 'package:orm/user_provider.dart';

// ignore: must_be_immutable
class UserView extends StatelessWidget {
  UserView({super.key});

  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();
  String title = 'Show user';

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = UserProvider.of(context) as UserProvider;
    int? index;

    if(userProvider.indexUser != null) {
      index = userProvider.indexUser;
      controllerName.text = userProvider.userSelected!.name;
      controllerEmail.text = userProvider.userSelected!.email;
      controllerPassword.text = userProvider.userSelected!.password;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(8)
              )
            ),
            margin: const EdgeInsets.all(8),
            child: TextButton(
              onPressed: () {
                Navigator.popAndPushNamed(context, '/list');
              } ,
              child: const Text('User List'),
            ),
          )
        ],
      ),
      body: ContainerAll(
        child: Center(
          child: Column(
            children: [
              FieldForm(
                label: 'Name', 
                isPassword: false, 
                controller: controllerName, 
                isForm: false,
                isEmail: false
              ),
              FieldForm(
                label: 'Email', 
                isPassword: false, 
                controller: controllerEmail, 
                isForm: false,
                isEmail: true
              ),
              FieldForm(
                label: 'Password', 
                isPassword: false, 
                controller: controllerPassword, 
                isForm: false,
                isEmail: false
              ),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () {
                    Navigator.popAndPushNamed(context, '/create');
                  }, 
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Theme.of(context).primaryColor),
                    foregroundColor: MaterialStateProperty.all(Colors.white)
                  ),
                  child: const Text("Edit"),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () {
                    userProvider.indexUser = null;
                    userProvider.users.removeAt(index!);
                    Navigator.popAndPushNamed(context, '/create');
                  }, 
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.red),
                    foregroundColor: MaterialStateProperty.all(Colors.white)
                  ),
                  child: const Text("Delete"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}