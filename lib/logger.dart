import 'package:logger/logger.dart' as logger;

class Logger {
  Logger._();

  static logger.Logger _logger;

  static void initLogger() {
    _logger ??= logger.Logger(
      printer: logger.PrettyPrinter(
        methodCount: 2,
        errorMethodCount: 8,
        lineLength: 200,
        colors: false,
        printEmojis: false,
        printTime: true,
      ),
    );
  }

  /// Log a message at level [Level.verbose].
  static void v(dynamic message, [dynamic error, StackTrace stackTrace]) {
    _logger?.v(message, error, stackTrace);
  }

  /// Log a message at level [Level.debug].
  static void d(dynamic message, [dynamic error, StackTrace stackTrace]) {
    _logger?.d(message, error, stackTrace);
  }

  /// Log a message at level [Level.info].
  static void i(dynamic message, [dynamic error, StackTrace stackTrace]) {
    _logger?.i(message, error, stackTrace);
  }

  /// Log a message at level [Level.warning].
  static void w(dynamic message, [dynamic error, StackTrace stackTrace]) {
    _logger?.w(message, error, stackTrace);
  }

  /// Log a message at level [Level.error].
  static void e(dynamic message, [dynamic error, StackTrace stackTrace]) {
    _logger?.e(message, error, stackTrace);
  }

  /// Log a message at level [Level.wtf].
  static void wtf(dynamic message, [dynamic error, StackTrace stackTrace]) {
    _logger?.wtf(message, error, stackTrace);
  }
}
