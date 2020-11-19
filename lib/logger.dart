import 'package:logger/logger.dart' as logger;

class Logger {
  Logger._() {
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

  logger.Logger _logger;

  factory Logger() {
    return Logger._();
  }

  /// Log a message at level [Level.verbose].
  void v(dynamic message, [dynamic error, StackTrace stackTrace]) {
    _logger?.v(message, error, stackTrace);
  }

  /// Log a message at level [Level.debug].
  void d(dynamic message, [dynamic error, StackTrace stackTrace]) {
    _logger?.d(message, error, stackTrace);
  }

  /// Log a message at level [Level.info].
  void i(dynamic message, [dynamic error, StackTrace stackTrace]) {
    _logger?.i(message, error, stackTrace);
  }

  /// Log a message at level [Level.warning].
  void w(dynamic message, [dynamic error, StackTrace stackTrace]) {
    _logger?.w(message, error, stackTrace);
  }

  /// Log a message at level [Level.error].
  void e(dynamic message, [dynamic error, StackTrace stackTrace]) {
    _logger?.e(message, error, stackTrace);
  }

  /// Log a message at level [Level.wtf].
  void wtf(dynamic message, [dynamic error, StackTrace stackTrace]) {
    _logger?.wtf(message, error, stackTrace);
  }
}
