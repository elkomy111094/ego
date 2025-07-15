import 'package:ego/app/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ego/core/connectivity/update_app_version_screen.dart';
import 'package:ego/core/connectivity/mintainance_screen.dart';
import 'package:ego/core/common/services/dialog/dialog_manager.dart';
import 'package:ego/core/common/services/router/app_router.dart';

import 'package:ego/features/splash/bloc/splash_state.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../app/layout/layout.dart';
import '../../../core/utils/getAppCurrentVersion.dart';
import '../bloc/splash_bloc.dart';

class SplashPage extends StatelessWidget {
  final Widget dialogChild;

  const SplashPage({super.key, required this.dialogChild});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SplashCubit()..initialize(),
      child: BlocListener<SplashCubit, SplashState>(
        listener: (context, state) {
          if (state is SplashNavigate) {
            if (state.isInMaintenance) {
              AppRouter.push(screen: const InMaintenanceScreen());
              return;
            }

            switch (state.updateStatus) {
              case AppUpdateStatus.forceUpdate:
                AppRouter.push(screen: UpdateAppVersionScreen(force: true));
                break;
              case AppUpdateStatus.optionalUpdate:
                AppRouter.push(screen: UpdateAppVersionScreen(force: false));
                break;
              case AppUpdateStatus.upToDate:
              default:
                AppRouter.push(
                  screen: DialogManager(
                    child: Layout(
                      termsAndConditionsDialogAcceptedState: state.termsAccepted,
                    ),
                  ),
                );
            }
          }
        },
        child: const _SplashView(),
      ),
    );
  }
}

class _SplashView extends StatelessWidget {
  const _SplashView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        
        child: Stack(
          children: [
            Positioned(
                top: -250,
                right: -200,
                child: Container(width: h500, height: h500,decoration: BoxDecoration(

                    shape: BoxShape.circle,
                    color: Color(
                    0x11008995)),)),
            Positioned(
                bottom: -250,
                left: -200,
                child: Container(width: h500, height: h500,decoration: BoxDecoration(

                    shape: BoxShape.circle,
                    color: Color(
                        0x11008995)),)),
            const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GlowingWidget(),
                  SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}



class GlowingWidget extends StatefulWidget {
  const GlowingWidget({super.key});
  @override
  State<GlowingWidget> createState() => _GlowingWidgetState();
}

class _GlowingWidgetState extends State<GlowingWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _color1;
  late Animation<Color?> _color2;
  bool showGlow = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    )..repeat(reverse: true);

    _color1 = ColorTween(
      begin: Colors.cyanAccent,
      end: Colors.blueAccent,
    ).animate(_controller);

    _color2 = ColorTween(
      begin: Colors.purpleAccent,
      end: Colors.tealAccent,
    ).animate(_controller);

    Future.delayed(const Duration(seconds: 1), () {
      setState(() => showGlow = true);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) => AnimatedContainer(
        duration: const Duration(seconds: 1),
        height: showGlow ?300 : 300,
        width: showGlow ? 300 : 300,
        decoration: BoxDecoration(
          shape: BoxShape.circle,

          image: const DecorationImage(
            image: AssetImage("assets/images/logo.png"),
            fit: BoxFit.fill,
          ),

        ),
      ),
    );
  }
}
