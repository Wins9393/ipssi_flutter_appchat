import 'package:flutter/material.dart';
import '../model/Message.dart';
import '../model/Utilisateur.dart';

class messageBubble extends StatelessWidget{
  Message message;
  Utilisateur partenaire;
  String monId;
  Animation? animation;
  messageBubble(
      @required String this.monId,
      @required Utilisateur this.partenaire,
      @required Message this.message,
      {Animation? this.animation}
      );
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.all(10),
      child: Row(
        children: widgetBubble(message.from == monId),
      ),
    );
  }
  List< Widget> widgetBubble(bool moi){
    CrossAxisAlignment alignment = (moi)?
    CrossAxisAlignment.end:CrossAxisAlignment.start;
    Color colorBubble =(moi)? Colors.green: Colors.blue;
    Color textcolor =Colors.white;
    return <Widget>[
      Expanded(
        child: Column(
          crossAxisAlignment: alignment,
          children: [
            Card(
              elevation: 5.0,
              shape: RoundedRectangleBorder(borderRadius:
              BorderRadius.circular(10)),
              color: colorBubble,
              child: Container(

                padding: EdgeInsets.all(/*animation?.value*/ 8),
                child: Text(message.texte,style: TextStyle(color: textcolor),),
              ),
            ),
          ],
        ),
      )
    ];
  }
}
