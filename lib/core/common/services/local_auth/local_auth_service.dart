import 'package:app_settings/app_settings.dart';
import 'package:local_auth/local_auth.dart';
import 'package:flutter/services.dart';
import 'package:ego/app/get_it/get_it.dart';
import 'package:url_launcher/url_launcher.dart';

class LocalAuthService {
  final LocalAuthentication _localAuth = LocalAuthentication();

  // Check if biometric authentication is available
  Future<bool> isBiometricAvailable() async {
    try {
      return await _localAuth.canCheckBiometrics;
    } on PlatformException catch (e) {
      print("Error checking biometrics availability: $e");
      return false;
    }
  }

  // Get available biometrics types (e.g., face, fingerprint)
  Future<List<BiometricType>> getAvailableBiometrics() async {
    try {
      return await _localAuth.getAvailableBiometrics();
    } on PlatformException catch (e) {
      print("Error getting biometrics: $e");
      return [];
    }
  }

  // Authenticate using biometrics
  Future<bool> authenticateWithBiometrics({String? promptMessage}) async {
    bool authenticated = false;
    try {
      // Check if biometric authentication is available

      // Start the biometric authentication
      authenticated = await _localAuth.authenticate(
        localizedReason: promptMessage ?? 'Please authenticate to continue.',
        options: const AuthenticationOptions(
          biometricOnly: false,
          sensitiveTransaction: true,
        ),
      );
    } on PlatformException catch (e) {
      logger.e(e);
      if (e.code == "NotAvailable") {
        redirectToSecuritySettings();
      }
    }

    return authenticated;
  }

  // Authenticate using device PIN/Password
  Future<bool> authenticateWithDevicePassword({String? promptMessage}) async {
    bool authenticated = false;
    try {
      authenticated = await _localAuth.authenticate(
        localizedReason: promptMessage ?? 'Please authenticate to continue.',
        options: const AuthenticationOptions(
          useErrorDialogs: true,
          stickyAuth: true,
        ),
      );
    } on PlatformException catch (e) {
      logger.e(e);
      if (e.code == "NotAvailable") {
        redirectToSecuritySettings();
      }
    }
    return authenticated;
  }

  // Check if the device supports authentication
  Future<bool> canAuthenticate() async {
    bool canAuth = false;
    try {
      canAuth = await _localAuth.canCheckBiometrics ||
          await _localAuth.isDeviceSupported();
    } on PlatformException catch (e) {
      logger.e(e);
    }

    return canAuth;
  }

  //? Redirect user to the OS settings for enabling security (PIN/Password)
  void redirectToSecuritySettings() {
    AppSettings.openAppSettings(
      type: AppSettingsType.lockAndPassword,
      asAnotherTask: true,
    );
  }
}
