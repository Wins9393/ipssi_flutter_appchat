import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/Fonctions/FirestoreHelper.dart';
import 'package:flutter_application_2/library/lib.dart';
import 'package:flutter_application_2/modelView/ImageRound.dart';

class Parametres extends StatefulWidget {
  @override
  State<StatefulWidget> createState(){
    return ParametresState();
  }
}

class ParametresState extends State<Parametres>{
  //Variables
  String? lienImage;
  Uint8List? bytesImages;
  String? nameImage;


  //Fonctions
  RecupererImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      withData: true,
      type: FileType.image
    );
    if(result != null){
      setState(() {
        nameImage = result.files.first.name;
        bytesImages = result.files.first.bytes;
        print(nameImage);
      });
      popImage();
    }
  }

  popImage(){
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context){
          if(Platform.isAndroid){
            return AlertDialog(
              title: Text("Séléctionner comme image de profil ?"),
              content: Image.memory(bytesImages!),
              actions: [
                ElevatedButton(
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    child: const Text("Annuler")
                ),
                ElevatedButton(
                    onPressed: (){
                      //Stocker l'image dans la bdd firebase
                      FirestoreHelper().stockageImage(nameImage!, bytesImages!).then((value){
                        setState(() {
                          lienImage = value;
                          User.image = value;

                          Map<String, dynamic> map = {
                            'IMAGE': lienImage
                          };
                          FirestoreHelper().updateUser(User.id, map);
                          Navigator.pop(context);
                        });
                      });
                    },
                    child: const Text("Ok")
                )
              ],
            );
          }else{
            return CupertinoAlertDialog(
              title: Text("Séléctionner comme image de profil ?"),
              content: Image.memory(bytesImages!),
              actions: [
                ElevatedButton(
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    child: const Text("Annuler")
                ),
                ElevatedButton(
                    onPressed: (){
                      //Stocker l'image dans la bdd firebase
                      FirestoreHelper().stockageImage(nameImage!, bytesImages!).then((value){
                        setState(() {
                          lienImage = value;
                          User.image = value;

                          Map<String, dynamic> map = {
                            'IMAGE': lienImage
                          };
                          FirestoreHelper().updateUser(User.id, map);
                          Navigator.pop(context);
                        });
                      });

                    },
                    child: const Text("Ok")
                )
              ],
            );
          }
        }
    );
  }



  @override
  Widget build(BuildContext context){
    return Container(
      padding: EdgeInsets.all(20),
      child: bodyPage()
    );
  }
  
  Widget bodyPage(){
    return Column(
      children: [
        InkWell(
          child: ImageRound(image: User.image, size: 150),
          onTap: (){
            RecupererImage();
          },
        ),
        const SizedBox(height: 10),
        //Prénom
        Row(
          children: [
            Container(
                width: MediaQuery.of(context).size.width -100,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: User.prenom,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)
                    )
                  ),
                  onChanged: (newValue){
                    setState(() {
                      User.prenom = newValue;
                    });
                  },
                ),
            ),

            IconButton(
              onPressed: (){
                Map<String, dynamic> map = {
                  "PRENOM": User.prenom,
                };
                FirestoreHelper().updateUser(User.id, map);
              },
              icon: const Icon(Icons.edit),
            )
          ]
        ),
        const SizedBox(height: 10),
        //Nom
        Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width -100,
                child: TextField(
                  decoration: InputDecoration(
                      hintText: User.nom,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)
                      )
                  ),
                  onChanged: (newValue){
                    setState(() {
                      User.nom = newValue;
                    });
                  },
                ),
              ),

              IconButton(
                onPressed: (){
                  Map<String, dynamic> map = {
                    "NOM": User.nom,
                  };
                  FirestoreHelper().updateUser(User.id, map);
                },
                icon: const Icon(Icons.edit),
              )
            ]
        ),
        const SizedBox(height: 10),
        Text(User.email)
      ],
    );
  }
}