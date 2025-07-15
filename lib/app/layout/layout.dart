import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:ego/app/get_it/get_it.dart';
import 'package:ego/core/common/services/dialog/dialog_service.dart';

import 'package:ego/core/common/widgets/misc/scaffold_wrapper.dart';
import 'package:ego/core/localization/loc_keys.dart';

class Layout extends StatefulWidget {
  final bool termsAndConditionsDialogAcceptedState;

  const Layout({super.key, this.termsAndConditionsDialogAcceptedState = false});

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  late final DialogService _dialogService = di<DialogService>();
  bool _dialogShown = false; // لحماية من التكرار
   PersistentTabController _controller = PersistentTabController(initialIndex: 0);
   
   int selectedIndex = 0;
   
  static const _systemUiOverlayStyle = SystemUiOverlayStyle(
    statusBarColor: Colors.white,
    statusBarIconBrightness: Brightness.light,
    statusBarBrightness: Brightness.light,
    systemNavigationBarColor: Colors.white,
    systemNavigationBarIconBrightness: Brightness.dark,
    systemNavigationBarDividerColor: Colors.white,
  );

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(_systemUiOverlayStyle);


    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_dialogShown && mounted && !widget.termsAndConditionsDialogAcceptedState) {
        _dialogShown = true;


      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: ScaffoldWrapper(
        child: PersistentTabView(
          handleAndroidBackButtonPress: false,
          stateManagement: true,
          screenTransitionAnimation: ScreenTransitionAnimation.none(),
          controller: _controller,
          tabs: [
            PersistentTabConfig(
              screen:  Container(),
              item: ItemConfig(
                title: Loc.quotes(),
                inactiveIcon: const Icon(Icons.swap_vert_outlined),
                icon: const Icon(Icons.swap_vert),
              ),
            ),
            PersistentTabConfig(
              screen: Container(),
              item: ItemConfig(
                title: Loc.charts(),
                inactiveIcon: const Icon(Icons.candlestick_chart_outlined),
                icon: const Icon(Icons.candlestick_chart),
              ),
            ),
            PersistentTabConfig(
              screen: Container(),
              item: ItemConfig(
                title: Loc.trade(),
                inactiveIcon: const Icon(Icons.trending_up_outlined),
                icon: const Icon(Icons.trending_up),
              ),
            ),
            PersistentTabConfig(
              screen: Container(),
              item: ItemConfig(
                title: Loc.historyTitle(),
                inactiveIcon: const Icon(Icons.history_outlined),
                icon: const Icon(Icons.history),
              ),
            ),
            PersistentTabConfig(
              screen: Container(),
              item: ItemConfig(
                title: Loc.exposure(),
                inactiveIcon: const Icon(Icons.list),
                icon: const Icon(Icons.list),
              ),
            ),
          ],
          navBarBuilder: (config) => Style1BottomNavBar(
            navBarDecoration: NavBarDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              padding: const EdgeInsets.symmetric(vertical: 12), // 👈 تمت إضافة البادينج هنا
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).colorScheme.shadow.withOpacity(0.1),
                  blurRadius: 1,
                  offset: const Offset(0, -1),
                ),
              ],
            ),
            navBarConfig: config,
          ),
        )



        ,
      ),
    );
  }
}

