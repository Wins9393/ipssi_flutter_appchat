import 'package:flutter/material.dart';
import 'package:flutter_application_2/Fonctions/FirestoreHelper.dart';
import 'package:flutter_application_2/View/AllUsers.dart';
import 'package:flutter_application_2/View/Parametres.dart';
import 'package:flutter_application_2/main.dart';

class Dashboard extends StatefulWidget {
  @override
  State<Dashboard> createState() => DashboardState();
}

class DashboardState extends State<Dashboard> {
  int selected = 0;
  PageController controller = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Dashboard"),
          actions: [
            IconButton(
                onPressed: (){
                  FirestoreHelper().deconnexion();
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context){
                        return const MyHomePage(title: '');
                      }
                  ));
            }, icon: const Icon(Icons.exit_to_app, color: Colors.red)
            )
          ]),
        body: bodyPage(),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: selected,
          onTap: (newValue) {
            setState(() {
              selected = newValue;
              controller.jumpToPage(newValue);
            });
          },
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.person), label: "Utilisateurs"),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: "Paramètres")
          ],
        )
    );
  }

  Widget bodyPage() {
    //controller.animateToPage(selection,
    //  duration: Duration(seconds: 1), curve: Curves.elasticOut);
    return PageView(
      onPageChanged: (value){
        setState(() {
          selected = value;
        });
      },
      children: [
        //Afficher tous les utilisateurs
        AllUsers(),

        //Créer une page de profil
        Parametres()
      ],
      controller: controller,
    );
  }
}
