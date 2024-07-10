import 'package:bareeq/global/constants/app_assets.dart';
import 'package:bareeq/global/widgets/image_text_page.dart';
import 'package:flutter/material.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});
  @override
  Widget build(BuildContext context) {
    return const ImageTextPage(imageAsset: AppAssets.loadingImageAsset);
  }
}
