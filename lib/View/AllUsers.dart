import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/Fonctions/FirestoreHelper.dart';
import 'package:flutter_application_2/View/MessageView.dart';
import 'package:flutter_application_2/library/lib.dart';
import 'package:flutter_application_2/model/Utilisateur.dart';
import 'package:flutter_application_2/modelView/ImageRound.dart';

class AllUsers extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    //TODO: inplement createState
    return AllUsersState();
  }
}

class AllUsersState extends State<AllUsers>{
  @override
  Widget build(BuildContext context){
    //TODO: implement build
    return bodyPage();
  }

  Widget bodyPage(){
    return StreamBuilder<QuerySnapshot>(
      stream: FirestoreHelper().fireUser.snapshots(),
        builder: (context, snapshot){
          if(!snapshot.hasData){
            return const Center(
              child: CircularProgressIndicator(),
            );
          }else{
            List documents = snapshot.data!.docs;
            return ListView.builder(
              itemCount: documents.length,
              itemBuilder: (context, index){
                Utilisateur users = Utilisateur(documents[index]);
                if(users.id == User.id){
                  return Container();
                }else{


                  //InkWell pour renvoyer vers la page de conversation
                  return InkWell(
                    child: Card(
                        elevation: 5.0,
                        color: Colors.grey,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        child: ListTile(
                          leading: ImageRound(image: users.image, size: 60),
                          title: Text("${users.prenom} ${users.prenom}"),
                          subtitle: Text(users.email),
                        )

                    ),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context){
                            return MessageView(user: users);
                          }
                      ));
                    },
                  );
                }
              }
            );
          }
        }
    );
  }
}