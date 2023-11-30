import 'package:flutter/material.dart';
import 'package:orm/fab_vertical_delegate.dart';
import 'package:orm/main.dart';
import 'package:orm/model/model.dart';

class FavMenuButton extends StatefulWidget {
  const FavMenuButton({super.key});

  @override
  State<FavMenuButton> createState() => _FavMenuButtonState();
}

class _FavMenuButtonState extends State<FavMenuButton> with SingleTickerProviderStateMixin{
  final actionButtonColor = Colors.blueGrey[700];

  late AnimationController animationController;
  final menuIsOpen = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200)
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    menuIsOpen.dispose();
    super.dispose();
  }

  toogleMenu() {
    menuIsOpen.value ? animationController.reverse() : animationController.forward();
    menuIsOpen.value = !menuIsOpen.value;
  }

  addAllUser() async {
    List<User> users = [];
    users.add(User.withFields("Danieldsadasd", "Daniel@gmail.com", "123456", false));
    users.add(User.withFields("João", "ghJoão@gmail.com", "45612dhs", false));
    users.add(User.withFields("Maria", "qMaria@gmail.com", "093383cjhsdkjf", false));
    users.add(User.withFields("Flamengo", "campeaoBrasileiro@gmail.com", "jdsadkalak", false));
    users.add(User.withFields("Jonas", "Jonas@gmail.com", "dkasjdlkasdj", false));
    users.add(User.withFields("Gabigol", "gabigol@gamil.com", "Ojdkljasdlsajo", false));
    users.add(User.withFields("Pele", "pele@gmail.co", "kjkljdasopop", false));
    users.add(User.withFields("Diego Showza", "showza@gmail.com", "Jadjsadl", false));
    users.add(User.withFields("CR7", "ronado@gmail.com", "jkdjaskldj3213", false));
    users.add(User.withFields("Toni Kross", "kross@gmail.com", "Jkdjaskldj", false));
    await User.saveAll(users);
  }

  deleteAllUser() async {
    await User().select().delete();
  }

  // Load Users order by name
  loadUserOrderByName() async {
    List<User> users = await User().select().orderBy("name").top(5).toList();
    return users;
  }

  @override
  Widget build(BuildContext context) {
    return Flow(
      clipBehavior: Clip.none,
      delegate: FabVerticalDelegate(animationController: animationController),
      children: [
        FloatingActionButton(
          child: AnimatedIcon(
            icon: AnimatedIcons.menu_close,
            progress: animationController,
          ),
          onPressed: () => toogleMenu(),
        ),
        FloatingActionButton(
          onPressed: () {
            Navigator.popAndPushNamed(context, '/create');
          },
          backgroundColor: actionButtonColor,
          child: const Icon(Icons.person_add),
        ),
        FloatingActionButton(
          onPressed: () {
            addAllUser();
            Navigator.popAndPushNamed(context, '/list');
          },
          backgroundColor: actionButtonColor,
          child: const Icon(Icons.people),
        ),
        FloatingActionButton(
          onPressed: () {
            deleteAllUser();
            Navigator.popAndPushNamed(context, '/list');
          },
          backgroundColor: actionButtonColor,
          child: const Icon(Icons.delete),
        ),
        // FloatingActionButton(
        //   onPressed: () async {
        //     List<User> users = await loadUserOrderByName();
        //     Navigator.popAndPushNamed(context, '/list', arguments: {"loadUsers": users});
        //   },
        //   backgroundColor: actionButtonColor,
        //   child: const Icon(Icons.money_off_csred_rounded
        // )),
      ],
    );
  }
}