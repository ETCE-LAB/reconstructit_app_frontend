import 'package:dio/dio.dart';

import '../interceptors/authentication_interceptor.dart';
import '../interceptors/serialization_interceptor.dart';

final dio = Dio(BaseOptions(receiveDataWhenStatusError: true))
  ..interceptors.addAll([
    AuthenticationInterceptor(),
    SerializationInterceptor()
  ]);
