import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../app/sizes.dart';

String getAssetImage(String assetName) => 'assets/images/$assetName';

String getAssetAnime(String assetName) => 'assets/anims/$assetName';

String getAssetIcon(String assetName) => 'assets/icons/$assetName';
Widget getAssetIconWidget(String assetName) {
  return SvgPicture.asset(
    'assets/icons/$assetName',
    width: double.infinity,
    height: h20,
  );
}
