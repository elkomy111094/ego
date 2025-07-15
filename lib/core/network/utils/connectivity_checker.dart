import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fpdart/fpdart.dart';

import 'package:logger/logger.dart';

import '../../errors/failures.dart';

/// Network connectivity checker
class ConnectivityChecker {
  final Logger _logger;

  ConnectivityChecker({Logger? logger}) : _logger = logger ?? Logger();

  Future<Either<Failure, bool>> isConnected() async {
    try {
      final connectivityResult = await Connectivity().checkConnectivity();
      final isConnected = connectivityResult != ConnectivityResult.none;
      _logger.d('Connectivity check: $isConnected');
      return Right(isConnected);
    } catch (e) {
      _logger.e('Connectivity check failed: $e');
      return Left(ConnectivityFailure('Failed to check connectivity: $e'));
    }
  }

  Stream<bool> onConnectivityChanged() {
    return Connectivity()
        .onConnectivityChanged
        .map((result) => result != ConnectivityResult.none)
        .distinct();
  }
}
