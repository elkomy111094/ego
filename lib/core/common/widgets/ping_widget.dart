import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:gap/gap.dart';
import 'package:ego/app/sizes.dart';

import '../../localization/loc_keys.dart';

class ServerStatusWidget extends StatefulWidget {
  const ServerStatusWidget({super.key});

  @override
  State<ServerStatusWidget> createState() => _ServerStatusWidgetState();
}

class _ServerStatusWidgetState extends State<ServerStatusWidget>
    with SingleTickerProviderStateMixin {
  int? pingTime;
  bool isLoading = false;
  String? errorMessage;

  final String pingUrl = 'http://104.248.165.230:5000/api/v1/system-status/ping';

  late AnimationController _controller;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    measurePing();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.3).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> measurePing() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    final dio = Dio();
    final stopwatch = Stopwatch()..start();

    try {
      final response = await dio.get(
        pingUrl,
        options: Options(receiveTimeout: const Duration(seconds: 5)),
      );
      stopwatch.stop();

      if (response.statusCode == 200) {
        setState(() {
          pingTime = stopwatch.elapsedMilliseconds;
          isLoading = false;
        });
      } else {
        setState(() {
          errorMessage = 'Unexpected status code';
          isLoading = false;
        });
      }
    } catch (e) {
      stopwatch.stop();
      setState(() {
        errorMessage = 'Error: ${e.runtimeType}';
        isLoading = false;
      });
    }
  }

  

  
  
  @override
  Widget build(BuildContext context) {
    final isOnline = errorMessage == null && pingTime != null;
    final isOffline = errorMessage != null;
    final colorScheme = Theme.of(context).colorScheme;
    final textColor = Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black;

    final statusColor = isOffline
        ? Colors.red
        : isOnline
        ? Colors.green
        : Colors.grey;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
       
        boxShadow: [
          BoxShadow(
            color: statusColor.withOpacity(0.15),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: w16, vertical: h12),
      child: Container(
        height: h20,
        child: Row(
          children: [
            // دائرة متحركة بالحجم حسب الحالة
            ScaleTransition(
              scale: _pulseAnimation,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: 14,
                height: 14,
                decoration: BoxDecoration(
                  color: statusColor,
                  shape: BoxShape.circle,
                ),
              ),
            ),
        
            const SizedBox(width: 10),
        
            Text(
              Loc.server() + " : ",
              style: TextStyle(
                fontSize: 16,
                color: textColor,
              ),
            ),
        
            // الحالة
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: Text(
                isOffline
                    ? Loc.offLine()
                    : isOnline
                    ? Loc.onLine()
                    : "Loading",
                key: ValueKey(errorMessage ?? pingTime ?? "loading"),
                style: TextStyle(
                  fontSize: sp14,
                  fontWeight: FontWeight.bold,
                  color: isOffline
                      ? Colors.red
                      : isOnline
                      ? Colors.green
                      : textColor,
                ),
              ),
            ),
             Gap(w10) , 
            if (pingTime != null)
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 300),
                  opacity: 1.0,
                  child: Text(
                    '[$pingTime ms]',
                    style: TextStyle(
                      fontSize: 16,
                      color: colorScheme.primary,
                    ),
                  ),
                ),
              ),
        
            const Spacer(),
        
            if (isLoading)
              const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            else
              IconButton(
                onPressed: measurePing,
                icon: const Icon(Icons.refresh),
                tooltip: 'Retry',
                iconSize: 20,
                color: textColor,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
          ],
        ),
      ),
    );
  }
}
