import 'package:flutter/material.dart';

class ReklamItem extends StatelessWidget {
  final String imageUrl;
  const ReklamItem({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        // border: Border.all(
        //   width: 0.5,
        //   color: Colors.black26,
        // ),
        //shape: BoxShape.circle,
        //color: Colors.yellow,
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
