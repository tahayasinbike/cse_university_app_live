import 'package:flutter/material.dart';

class AppbarIstun extends StatelessWidget {
  const AppbarIstun({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Align(
          alignment: const Alignment(-0.35, 0),
          child: Image.asset(
            "assets/white.png",
          )),
    );
  }
}
