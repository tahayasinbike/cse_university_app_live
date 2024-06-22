// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class SayilarSlider extends StatelessWidget {
  const SayilarSlider({
    super.key,
    required this.sayi,
    required this.subTitle,
  });
  final String sayi;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: 
        SizedBox(
          child: ListTile(
           title: Row(
            
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            
            Text(sayi,style: Theme.of(context).textTheme.displayMedium,),
            Text(subTitle,style: Theme.of(context).textTheme.displayMedium,)
           ]), 
          ),
        )
        
        /* Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white, width: 2),
            borderRadius: const BorderRadius.only(bottomRight: Radius.circular(10), bottomLeft: Radius.circular(10)),
          ),
          height: 100,
          width: 300,
          child: Center(
            child: ListTile(
              title: Text(
                sayi,
                style: Theme.of(context).textTheme.displayMedium,
              ),
              subtitle: Text(
                subTitle,
                style: Theme.of(context).textTheme.displaySmall,
              ),
            ),
          ),
        ) */);
  }
}
