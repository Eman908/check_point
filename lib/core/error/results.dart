sealed class Results<T> {}

final class Success<T> extends Results<T> {
  final T? data;
  Success({this.data});
}

final class Failure<T> extends Results<T> {
  final String? message;
  final Exception? exception;
  Failure({this.exception, this.message});
}
