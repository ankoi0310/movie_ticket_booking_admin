class BaseException implements Exception {
  final String message;
  final String? cause;
  final int statusCode;

  BaseException(this.message, this.statusCode, {this.cause});
}
