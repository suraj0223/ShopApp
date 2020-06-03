class HttpException implements Exception {
  final String exceptionMsg;

  HttpException(this.exceptionMsg);

  @override
   String toString() {
    if (exceptionMsg == null) return "Exception";
    return "Exception: $exceptionMsg";
  }

}