import 'package:flutter/material.dart';

class MainContainer extends StatelessWidget {
  const MainContainer({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: child,
        ),
        Hero(
          tag: 'ads_container',
          child: Container(
            color: Colors.blue,
            height: 50.0,
            width: double.infinity,
          ),
        ),
      ],
    );
  }
}
