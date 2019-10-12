import 'package:flutter/material.dart';

class ElementWidget extends StatelessWidget {

  final double height;
  final double width;
  final double padding;
  final Color backgroundColor;
  final Color color;

  const ElementWidget({Key key, this.height, this.width, this.color, this.padding, this.backgroundColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: this.height,
      width: this.width,
      decoration: BoxDecoration(
        color: Colors.blue, 
        border: Border.all(
          color: Colors.white,
          width: this.width / 20
        )
      ),
    );
  }
}