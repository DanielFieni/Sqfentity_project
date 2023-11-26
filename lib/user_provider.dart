import 'package:flutter/material.dart';
import 'package:orm/user.dart';

// ignore: must_be_immutable
class UserProvider extends InheritedWidget {

  final Widget child;
  List<User> users = [];
  User? userSelected;
  int? indexUser;

  UserProvider({
    super.key, 
    required this.child
  }) : super(child: child);

  static UserProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<UserProvider>(); 
  }

@override
  bool updateShouldNotify(UserProvider oldWidget) {
    return true;
  }

}