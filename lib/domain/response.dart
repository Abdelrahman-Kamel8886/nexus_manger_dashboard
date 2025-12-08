sealed class Response<T> {
  const Response();
}

final class Loading<T> extends Response<T> {
  const Loading();
}

final class Success<T> extends Response<T> {
  final T data;
  const Success(this.data);
}

final class ErrorResponse<T> extends Response<T> {
  final String message;
  const ErrorResponse(this.message);
}
