import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../Fonctions/FirestoreHelper.dart';
import '../model/Message.dart';
import '../model/Utilisateur.dart';
import '../modelView/messageBubble.dart';

class Messagecontroller extends StatefulWidget{
  Utilisateur id;
  Utilisateur idPartner;
  Messagecontroller(@required Utilisateur this.id,@required Utilisateur this.idPartner);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MessagecontrollerState();
  }

}

class MessagecontrollerState extends State<Messagecontroller> {
  late Animation animation;
  late AnimationController controller;
  late ControlsDetails defilementController;

  @override
  void dispose() {
    //controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirestoreHelper().fire_message.orderBy(
            'envoiMessage', descending:
        true).snapshots(),
        builder: (BuildContext context, AsyncSnapshot <QuerySnapshot>snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          }
          else {
            List<DocumentSnapshot>documents = snapshot.data!.docs;
            return ListView.builder(
                reverse: true,
                itemCount: documents.length,
                itemBuilder: (BuildContext ctx, int index) {
                  Message discussion = Message(documents[index]);
                  if ((discussion.from == widget.id.id &&
                      discussion.to == widget.idPartner.id) ||
                      (discussion.from == widget.idPartner.id &&
                          discussion.to == widget.id.id)) {
                    return messageBubble(
                      widget.id.id, widget.idPartner, discussion);
                  }
                  else {
                    return Container();
                  }
                }
            );
          }
        }
    );
  }
}