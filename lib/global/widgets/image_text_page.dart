import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ImageTextPage extends StatelessWidget {
  const ImageTextPage({super.key, required this.imageAsset, this.message});
  final String imageAsset;
  final String? message;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [

        SvgPicture.asset(imageAsset,width: size.width,height: size.width,),
        if(message != null)
        const SizedBox(
          height: 30,
        ),
        if(message != null)
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            message!,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }
}