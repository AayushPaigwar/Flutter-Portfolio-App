import 'package:flutter/material.dart';
import 'package:neopop/neopop.dart';

class NeoPop extends StatelessWidget {
  const NeoPop({super.key});

  @override
  Widget build(BuildContext context) {
    return NeoPopTiltedButton(
      isFloating: true,
      onTapUp: () {},
      decoration: const NeoPopTiltedButtonDecoration(
        color: Color.fromRGBO(255, 235, 52, 1),
        plunkColor: Color.fromRGBO(255, 235, 52, 1),
        shadowColor: Color.fromRGBO(36, 36, 36, 1),
        showShimmer: true,
      ),
      child: const Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 70.0,
          vertical: 15,
        ),
        child: Text(
          'Resume',
        ),
      ),
    );
  }
}
