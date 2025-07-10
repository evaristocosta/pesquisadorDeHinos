import 'package:flutter/material.dart';

class Carregando extends StatelessWidget {
  const Carregando({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
      child: SizedBox(
        child: CircularProgressIndicator(),
        height: 75.0,
        width: 75.0,
      ),
    ));
  }
}
