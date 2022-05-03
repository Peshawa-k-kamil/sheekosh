class HttpException implements Exception {
  final String message;

  HttpException(this.message);

  @override
  String toString() {
    return message; //my own tostring
    // return super.toString();  Instance of HttpException . this default
  }
}
