enum Status { initial, success, failure, loading }

class BaseStatus<T> {
  final T? data;
  final String? message;
  final Status status;
  final Exception? exception;

  const BaseStatus.initial()
    : status = Status.initial,
      data = null,
      message = null,
      exception = null;
  const BaseStatus.loading({this.data})
    : status = Status.loading,
      exception = null,
      message = null;
  const BaseStatus.failure({this.data, this.message, this.exception})
    : status = Status.failure;
  const BaseStatus.success({this.data, this.message})
    : status = Status.success,
      exception = null;
}
