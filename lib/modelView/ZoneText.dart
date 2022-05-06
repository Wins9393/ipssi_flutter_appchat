import 'package:flutter/material.dart';
import '../Fonctions/FirestoreHelper.dart';
import '../model/Utilisateur.dart';

class ZoneText extends StatefulWidget{
  Utilisateur partenaire;
  Utilisateur moi;
  ZoneText(
      @required Utilisateur this.partenaire,
      @required Utilisateur this.moi
      );
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ZoneTextState();
  }
}
TextEditingController _textEditingController = new TextEditingController();
class ZoneTextState extends State<ZoneText>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      color: Colors.grey[300],
      padding: EdgeInsets.all(15),
      child: Row(
        children: [
          Flexible(
            child: TextField(
              controller: _textEditingController,
              decoration: InputDecoration.collapsed(
                hintText: "écrivez votre message",),
              maxLines: null,
            ),
          ),
          IconButton(icon: Icon(Icons.send), onPressed: _sendBouttonpressed)
        ],
      ),
    );
  }
  _sendBouttonpressed(){
    if(_textEditingController != null && _textEditingController.text != ""){
      String text =_textEditingController.text;
      print('enregistrement');
      FirestoreHelper().sendMessage(text, widget.partenaire,widget.moi);
      setState(() {
        _textEditingController.text = '';
      });
      FocusScope.of(context).requestFocus(new FocusNode());
      _sendMessage();
    }
  }
  _sendMessage(){
    //envoie message dans firebase
    print(_textEditingController.text);
  }
}