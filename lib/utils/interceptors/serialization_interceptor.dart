import 'package:dio/dio.dart';

/// This serializer removes the id attribute in a post from th eobject in the body
class SerializationInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (options.method == "POST") {
      if (options.data is Map) {
        options.data.removeWhere((key, value) => key == "id");
      }
    }
    super.onRequest(options, handler);
  }
}
