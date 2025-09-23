

class Result<Type> {
  final bool isSuccessful;
  final Exception? failure;
  final Type? value;

  Result.protected({required this.isSuccessful, this.failure, this.value});

  factory Result.success(Type value) =>
      Result.protected(isSuccessful: true, value: value);

  factory Result.fail(Exception failure) =>
      Result.protected(isSuccessful: false, failure: failure);
}
