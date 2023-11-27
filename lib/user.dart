class User {
  String name;
  String email;
  String password;
  bool isDeleted;

  User({
    required this.name,
    required this.email,
    required this.password,
    this.isDeleted = false,
  });

}