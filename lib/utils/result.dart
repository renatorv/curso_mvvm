sealed class Result<T> {
  const Result();

  const factory Result.ok(T value) = OK._;
  const factory Result.error(Exception error) = Error._;
}

final class OK<T> extends Result<T> {
  final T value;
  const OK._(this.value);

  @override
  String toString() => "Result<$T>.ok($value)";
}

final class Error<T> extends Result<T> {
  final Exception error;

  const Error._(this.error);

  @override
  String toString() => "Result<$T>.error($error)";
}

// Result.ok('Resultado OK');
// Result.error(Exception('Erro no resultado'));
