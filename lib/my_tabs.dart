import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppTabs extends StatelessWidget {
  final Color color;
  final String text;
  const AppTabs({ Key? key, required this.color, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width:108,
      height: 50,
      child: Text(
        this.text, style: TextStyle(color:Colors.white, fontSize: 20),

      ),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: this.color,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 7,
              offset: Offset(0,0),
            )
          ]
      ),
    );
  }
}
