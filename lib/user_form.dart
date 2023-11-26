import 'package:flutter/material.dart';
import 'package:orm/container_all.dart';
import 'package:orm/field_form.dart';
import 'package:orm/user.dart';
import 'package:orm/user_provider.dart';

class UserForm extends StatefulWidget {
  const UserForm({super.key});

  @override
  State<UserForm> createState() => __UserFormStateState();
}

class __UserFormStateState extends State<UserForm> {

  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();
  String title = 'Create user';

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = UserProvider.of(context) as UserProvider;
    int? index;

    if(userProvider.indexUser != null) {
      index = userProvider.indexUser;
      controllerName.text = userProvider.userSelected!.name;
      controllerEmail.text = userProvider.userSelected!.email;
      controllerPassword.text = userProvider.userSelected!.password;
      setState(() {
        title = 'Edit user';
      });
    }

    GlobalKey<FormState> _key = GlobalKey<FormState>();

    void save() {
      final isValidate = _key.currentState?.validate();

      if(isValidate == false) {
        return;
      }

      _key.currentState?.save();
      User user = User(
        name: controllerName.text, 
        email: controllerEmail.text, 
        password: controllerPassword.text
      );
      
      if(index != null) {
        // Edit user
        userProvider.users[index] = user;
      } else {
        // Add user
        int usersLength = userProvider.users.length;
        userProvider.users.insert(usersLength, user);
      }
      Navigator.popAndPushNamed(context, '/list');

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
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: 1,
          itemBuilder: (BuildContext context, indexBuilder) => 
          Center(
            child: Form(
              key: _key,
              child: Column(
                children: [
                  FieldForm(
                    label: 'Name', 
                    isPassword: false, 
                    controller: controllerName,
                    isEmail: false
                  ),
                  FieldForm(
                    label: 'Email', 
                    isPassword: false, 
                    controller: controllerEmail,
                    isEmail: true
                  ),
                  FieldForm(
                    label: 'Password', 
                    isPassword: true, 
                    controller: controllerPassword,
                    isEmail: false
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () {
                        save();
                      }, 
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Theme.of(context).primaryColor),
                        foregroundColor: MaterialStateProperty.all(Colors.white)
                      ),
                      child: const Text("Salvar"),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}