import 'package:dio/dio.dart';

class SerializationInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    //print("serializer");
    ////print(options.data.toString());
    if (options.method == "POST") {
      // only if a body exists
      // //print(options.data);
      //log("über mir typ");
      if (options.data is Map) {
        //print(options.data.runtimeType);
        //print("intercepter //print");
        options.data.removeWhere((key, value) => key == "id");
      }
    }

    //print(options.path);
    //print(options.data);
    super.onRequest(options, handler);
  }
}
