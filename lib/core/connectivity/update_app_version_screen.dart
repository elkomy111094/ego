import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:ego/core/common/services/router/app_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../app/layout/layout.dart';
import '../localization/loc_keys.dart';

class UpdateAppVersionScreen extends StatefulWidget {
  final bool force;
  final String updateUrl;

  const UpdateAppVersionScreen({
    Key? key,
    this.force = false,
    this.updateUrl = 'https://your.app.store.link',
  }) : super(key: key);

  @override
  State<UpdateAppVersionScreen> createState() => _UpdateAppVersionScreenState();
}

class _UpdateAppVersionScreenState extends State<UpdateAppVersionScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _launchUpdateUrl() async {
    final uri = Uri.parse(widget.updateUrl);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(Loc.errorLaunchUrl()),
          backgroundColor: Theme.of(context).colorScheme.error,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  void _skipUpdate() {
    if (!widget.force) {
      AppRouter.push(screen: Layout());
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
           
          ),
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ScaleTransition(
                    scale: _pulseAnimation,
                    child: Lottie.asset(
                      'assets/lottie/update.json',
                      width: 180,
                      height: 180,
                      repeat: false,
                    ),
                  ),
                  SizedBox(height: 30.h),
                  Text(
                    Loc.updateAvailableTitle(),
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontSize: 20.sp,
                      color: colorScheme.onPrimaryContainer,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          blurRadius: 6,
                          color: colorScheme.shadow.withOpacity(0.4),
                          offset: const Offset(1, 2),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    Loc.updateAvailableMessage(),
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontSize: 15.sp,
                      color: colorScheme.onPrimaryContainer.withOpacity(0.8),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 30.h),
                  ElevatedButton.icon(
                    onPressed: _launchUpdateUrl,
                    icon: Icon(Icons.system_update_alt, color: colorScheme.onPrimaryContainer,),
                    label: Text(
                      Loc.updateNow(),
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold, 
                          color: colorScheme.onPrimaryContainer,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorScheme.primary,
                      padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 14.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32.r),
                      ),
                      elevation: 10,
                      shadowColor: colorScheme.shadow,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  if (!widget.force)
                    ElevatedButton.icon(
                      onPressed: _skipUpdate,
                      icon: Icon(Icons.skip_next, color: colorScheme.onPrimaryContainer,),
                      label: Text(
                        Loc.skip(),
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: colorScheme.onPrimaryContainer,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        padding: EdgeInsets.symmetric(horizontal: 28.w, vertical: 12.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32.r),
                          side: BorderSide(color: colorScheme.onPrimaryContainer,),
                        ),
                        elevation: 0,
                        shadowColor: colorScheme.shadow,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
