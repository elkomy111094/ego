import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ego/core/common/widgets/picture.dart';
import 'package:ego/core/utils/get_asset_path.dart';

import '../../../app/sizes.dart';
import '../../localization/loc_keys.dart';

class NoSearchResultWidget extends StatelessWidget {
  const NoSearchResultWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: h5, vertical: w5),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Picture(getAssetIcon('search_result_icon.svg')),
            Gap(h20),
            Text(
              /*Loc.noSearchResult*/ Loc.name(),
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Gap(h5),
            Text(
              "",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Gap(
              h30,
            ),
            ElevatedButton(
              style: const ButtonStyle(
                elevation: WidgetStatePropertyAll(0),
              ),
              onPressed: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Picture(
                    getAssetIcon('chat_bubble_icon.svg'),
                  ),
                  Gap(
                    w10,
                  ),
                  Text(
                    /*Loc.askForHelpTitle*/ Loc.helpYourFriends(),
                    style: TextStyle(
                      fontSize: sp18,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
