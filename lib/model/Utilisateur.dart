import 'package:cloud_firestore/cloud_firestore.dart';

class Utilisateur {
  late String _uid; // Variable privé
  late String nom;
  late String prenom;
  late String email;
  String? image;
  DateTime? dateNaissance;

  // Getter pour la variable privé
  String get id {
    return _uid;
  }

  // Setter pour la variable privé (exemple)
  /*
   set(String uid){
    return _uid = uid;
  }
  */

  // Constructeur
  Utilisateur(DocumentSnapshot snapshot) {
    _uid = snapshot.id;
    Map<String, dynamic> map = snapshot.data() as Map<String, dynamic>;
    nom = map['NOM'];
    prenom = map['PRENOM'];
    image = map['IMAGE'];
    email = map['MAIL'];
    Timestamp? timestamp = map["NAISSANCE"];
    dateNaissance = timestamp?.toDate();
  }

  // Methodes
  Map<String,dynamic> toMap() {
    Map <String,dynamic> map;
    return map ={
      'NOM':nom,
      'PRENOM':prenom,
      'IMAGE':image,
      'MAIL':email,
      'NAISSANCE':dateNaissance,
    };
  }
}
