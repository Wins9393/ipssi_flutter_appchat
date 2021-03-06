import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/Controller/MessageController.dart';
import 'package:flutter_application_2/library/lib.dart';
import 'package:flutter_application_2/model/Message.dart';
import 'package:flutter_application_2/modelView/ImageRound.dart';
import 'package:flutter_application_2/modelView/ZoneText.dart';
import 'package:flutter_application_2/modelView/messageBubble.dart';
import '../model/Utilisateur.dart';

class MessageView extends StatefulWidget{
  Utilisateur user;
  MessageView({required Utilisateur this.user});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MessageViewState();
  }
}

class MessageViewState extends State<MessageView>{
  Message? msg;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.user.prenom),
        actions: [
          ImageRound(
            image: widget.user.image,
          )
        ],
      ),
      body: bodyPage(),

    );
  }

  Widget bodyPage(){
    print(MediaQuery.of(context).viewInsets);
    return Stack(
      children: [
        Container(
            constraints: BoxConstraints.expand(),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage("https://images.unsplash.com/photo-1504941214544-9c1c44559ab4?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1287&q=80"),
                    fit: BoxFit.cover
                )
            )
        ),
        Positioned(
          width: MediaQuery.of(context).size.width,

          //Petit calcul pour que la conversation soit au dessus du clavier
          height: (MediaQuery.of(context).viewInsets.bottom == 0) ? MediaQuery.of(context).size.height - 140 : MediaQuery.of(context).size.height - (MediaQuery.of(context).viewInsets.bottom + 140),
          child: Messagecontroller(User, widget.user)
        ),

        Positioned(
          width: MediaQuery.of(context).size.width,
          height: 60,
          bottom: 0,
          child: ZoneText(widget.user, User),
        ),
      ],
    );
  }
}