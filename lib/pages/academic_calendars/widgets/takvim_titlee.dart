import 'package:cse_university_app/utils/custom_colors.dart';
import 'package:flutter/material.dart';

Expanded takvimTitle(BuildContext context, Widget takvim, String titlee) {
  return Expanded(
      child: InkWell(
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => takvim,
              )),
          child: BolumlerContainer(bolum: titlee)));
}

// ignore: must_be_immutable
class BolumlerContainer extends StatelessWidget {
  String bolum;
  BolumlerContainer({
    super.key,
    required this.bolum,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: CustomColors.transparent,
            border: Border.all(color: Colors.white)),
        width: double.infinity,
        child: Center(
          child: FittedBox(
            child: Text(bolum,
                style: Theme.of(context)
                    .textTheme
                    .displayMedium
                    ?.copyWith(fontWeight: FontWeight.bold)),
          ),
        ),
      ),
    );
  }
}
