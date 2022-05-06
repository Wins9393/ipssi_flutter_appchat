import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_application_2/model/Utilisateur.dart';

class FirestoreHelper {
  // Attributs
  final auth = FirebaseAuth.instance;
  final fireUser = FirebaseFirestore.instance.collection("Users");
  final storage = FirebaseStorage.instance;

  final fire_message = FirebaseFirestore.instance.collection("Message");
  final fire_conversation = FirebaseFirestore.instance.collection('Conversations');

  // Methodes

  // fonction pour s'inscrire
  Future<Utilisateur> inscription(String prenom, String nom, String mail, String pwd) async {
    UserCredential result =
        await auth.createUserWithEmailAndPassword(email: mail, password: pwd);
    String uid = result.user!.uid;
    Map<String, dynamic> map = {"PRENOM": prenom, "NOM": nom, "MAIL": mail};
    addUser(uid, map);

    //Sauvegarde du l'utilisateur inscrit dans Myprofil
    DocumentSnapshot snapshot = await fireUser.doc(uid).get();

    return Utilisateur(snapshot);
  }

  //fonction pour se connecter
  Future<Utilisateur> Connexion(String mail, String pwd) async {
    UserCredential result =
        await auth.signInWithEmailAndPassword(email: mail, password: pwd);
    String uid = result.user!.uid;
    DocumentSnapshot snapshot = await fireUser.doc(uid).get();
    return Utilisateur(snapshot);
  }

  //créer un user dans la db
  addUser(String uid, Map<String, dynamic> map) {
    fireUser.doc(uid).set(map);
  }

  //update user
  updateUser(String uid, Map<String, dynamic> map) {
    fireUser.doc(uid).update(map);
  }

  deconnexion(){
    auth.signOut();
  }

  //Stocker l'image en bdd
  Future <String> stockageImage(String nameImage, Uint8List data) async {
    String urlChemin = "";
    //Stocker l'image
    TaskSnapshot download = await storage.ref("image/$nameImage").putData(data);
    //Récupérer le lien de l'image
    urlChemin = await download.ref.getDownloadURL();

    return urlChemin;
  }

  //Methodes pour le chat

  addMessage(Map<String,dynamic> map,String uid){
    fire_message.doc(uid).set(map);
  }

  addConversation(Map<String,dynamic> map,String uid){
    fire_conversation.doc(uid).set(map);
  }

  sendMessage(String texte,Utilisateur user,Utilisateur moi){
    DateTime date=DateTime.now();
    Map <String,dynamic>map={
      'from':moi.id,
      'to':user.id,
      'texte':texte,
      'envoiMessage':date
    };
    String idDate = date.microsecondsSinceEpoch.toString();

    addMessage(map, getMessageRef(moi.id, user.id, idDate));
    addConversation(getConversation(moi.id, user, texte, date), moi.id);
    addConversation(getConversation(user.id, moi, texte, date), user.id);
  }

  Map <String,dynamic> getConversation(String sender,Utilisateur partenaire,String texte,DateTime date){
    Map <String,dynamic> map = partenaire.toMap();
    map ['idmoi']=sender;
    map['lastmessage']=texte;
    map['envoimessage']=date;
    map['destinateur']=partenaire.id;
    return map;
  }

  String getMessageRef(String from,String to,String date){
    String resultat = "";
    List<String> liste = [from,to];
    liste.sort((a,b) => a.compareTo(b));
    for(var x in liste){
      resultat += x+"+";
    }
    resultat = resultat + date;
    return resultat;
  }
}
