import 'dart:developer';

import 'package:dio/dio.dart';

class DynamicTimeoutInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (options.data is FormData) {
      FormData formData = options.data;
      int totalFileSize = 0;

      for (var fileEntry in formData.files) {
        MultipartFile file = fileEntry.value;
        totalFileSize += file.length;
      }

      options.receiveTimeout =
          Duration(milliseconds: calculateTimeout(totalFileSize));
    }
    super.onRequest(options, handler);
  }

  int calculateTimeout(int fileSize) {
    // Example logic to calculate timeout based on file size
    log("Total File of Sent : ${fileSize}");
    int baseTimeout = 30000; // 30 seconds
    int additionalTimeout = (fileSize / 1024).ceil() * 1000; // 1 second per KB
    return baseTimeout + additionalTimeout;
  }
}
