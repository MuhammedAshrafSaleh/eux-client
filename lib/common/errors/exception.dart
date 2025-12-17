class ServerException implements Exception {}

class AuthFireBaseExceptiom implements Exception {
  final String? message;

  AuthFireBaseExceptiom({required this.message});
}

class EmptyCacheException implements Exception {}

class OfflineException implements Exception {}
