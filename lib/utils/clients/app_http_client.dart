import 'package:dio/dio.dart';

import '../interceptors/authentication_interceptor.dart';
import '../interceptors/serialization_interceptor.dart';

/// this app uses the dio http client. The Authentication ad Serialization interceptor are added here
final dio = Dio(BaseOptions(receiveDataWhenStatusError: true))
  ..interceptors.addAll([
    AuthenticationInterceptor(),
    SerializationInterceptor(),
  ]);
