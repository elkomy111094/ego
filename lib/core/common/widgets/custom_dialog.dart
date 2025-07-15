// file: lib/presentation/widgets/custom_dialog.dart

import 'package:flutter/material.dart';
import 'dart:ui'; // For BackdropFilter
import 'package:google_fonts/google_fonts.dart';
import 'package:ego/core/common/widgets/misc/divider.dart'; // For custom fonts

// Enum to define dialog status
enum DialogStatus { success, error, warning, info }

class CustomDialog extends StatefulWidget {
  final String title;
  final String message;
  final Widget? content;
  final String? confirmText;
  final String? cancelText;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;
  final DialogStatus status;

  const CustomDialog({
    Key? key,
    required this.title,
    required this.message,
    this.content,
    this.confirmText,
    this.cancelText,
    this.onConfirm,
    this.onCancel,
    this.status = DialogStatus.info,
  }) : super(key: key);

  @override
  _CustomDialogState createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<double> _iconBounce;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );
    _iconBounce = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.bounceOut),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Determine icon and color based on status
  IconData _getIcon() {
    switch (widget.status) {
      case DialogStatus.success:
        return Icons.check_circle_rounded;
      case DialogStatus.error:
        return Icons.error_rounded;
      case DialogStatus.warning:
        return Icons.warning_rounded;
      case DialogStatus.info:
        return Icons.info_rounded;
    }
  }

  Color _getStatusColor(BuildContext context) {
    switch (widget.status) {
      case DialogStatus.success:
        return Theme.of(context).colorScheme.primary;
      case DialogStatus.error:
        return Theme.of(context).colorScheme.error;
      case DialogStatus.warning:
        return Colors.amber.shade700;
      case DialogStatus.info:
        return Theme.of(context).colorScheme.secondary;
    }
  }

  LinearGradient _getButtonGradient(BuildContext context) {
    final color = _getStatusColor(context);
    return LinearGradient(
      colors: [
        color.withOpacity(0.7),
        color,
      ],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: _buildDialogContent(context),
        ),
      ),
    );
  }

  Widget _buildDialogContent(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 600;
    final statusColor = _getStatusColor(context);

    return Container(
      constraints: BoxConstraints(
        maxWidth: isSmallScreen ? screenWidth * 0.9 : 400,
        minWidth: isSmallScreen ? screenWidth * 0.8 : 320,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface.withOpacity(0.85),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ScaleTransition(
                  scale: _iconBounce,
                  child: Icon(
                    _getIcon(),
                    size: isSmallScreen ? 48 : 56,
                    color: statusColor,
                    semanticLabel: '${widget.status.toString().split('.').last} icon',
                  ),
                ),
                TDivider(), 
                /*Text(
                  widget.title,
                  style: GoogleFonts.poppins(
                    fontSize: isSmallScreen ? 22 : 26,
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).colorScheme.onSurface,
                    letterSpacing: 0.2,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),*/
                const SizedBox(height: 12),
                widget.content ??
                    Text(
                      widget.message,
                      style: GoogleFonts.poppins(
                        fontSize: isSmallScreen ? 15 : 16,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                        height: 1.5,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (widget.cancelText != null)
                      TextButton(
                        onPressed: widget.onCancel ?? () => Navigator.of(context).pop(),
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                          foregroundColor: Theme.of(context).colorScheme.onSurfaceVariant,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: BorderSide(
                              color: Theme.of(context).colorScheme.outline.withOpacity(0.3),
                            ),
                          ),
                        ),
                        child: Text(
                          widget.cancelText!,
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    if (widget.cancelText != null) const SizedBox(width: 12),
                    if (widget.confirmText != null)
                      MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTapDown: (_) {
                            // Simulate button press effect
                            setState(() {
                              _controller.reverse().then((_) => _controller.forward());
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: _getButtonGradient(context),
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: statusColor.withOpacity(0.3),
                                  blurRadius: 8,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: ElevatedButton(
                              onPressed: widget.onConfirm ?? () => Navigator.of(context).pop(),
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: Text(
                                widget.confirmText!,
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context).colorScheme.onPrimary,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Helper function to show the dialog
Future<void> showCustomDialog({
  required BuildContext context,
  required String title,
  required String message,
  String? confirmText,
  String? cancelText,
  VoidCallback? onConfirm,
  VoidCallback? onCancel,
  DialogStatus status = DialogStatus.info,
}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: true,
    barrierColor: Colors.black.withOpacity(0.5),
    builder: (context) => CustomDialog(
      title: title,
      message: message,
      confirmText: confirmText,
      cancelText: cancelText,
      onConfirm: onConfirm,
      onCancel: onCancel,
      status: status,
    ),
  );
}
