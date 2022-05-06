import 'package:flutter/material.dart';

class ImageRound extends StatefulWidget{
  String? image;
  double? size;
  ImageRound({required this.image, this.size});
  @override
  State<StatefulWidget> createState(){
    return ImageRoundState();
  }
}

class ImageRoundState extends State<ImageRound>{
  @override
  Widget build(BuildContext context){
    return bodyPage();
  }

  Widget bodyPage(){
    return Container(
      height: widget.size ?? 40,
      width: widget.size ?? 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          image: (widget.image == null) ? const NetworkImage("https://t4.ftcdn.net/jpg/04/70/29/97/360_F_470299797_UD0eoVMMSUbHCcNJCdv2t8B2g1GVqYgs.jpg") : NetworkImage(widget.image!),
          fit: BoxFit.fill
        )
      )
    );
  }
}