import '../../../core/utils/getAppCurrentVersion.dart';

abstract class SplashState {}

class SplashInitial extends SplashState {}

class SplashLoading extends SplashState {}

class SplashNavigate extends SplashState {
  final AppUpdateStatus updateStatus;
  final bool isInMaintenance;
  final bool termsAccepted;

  SplashNavigate({
    required this.updateStatus,
    required this.isInMaintenance,
    required this.termsAccepted,
  });
}
