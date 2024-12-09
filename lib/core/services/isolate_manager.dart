import 'dart:isolate';

import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:task_management/util/app_constants.dart';
import '../data/local_data/local_storage_source.dart';


class IsolateManager {
  static final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      errorMethodCount: 5,
      lineLength: 50,
      colors: true,
      printEmojis: true,
      printTime: true,
    ),
  );

  static Future<Map<String, dynamic>?> executeInIsolate({
    required String endpoint,
    required String method,
    Map<String, dynamic>? queryParameters,
    String? data,
    FormData? formData,
  }) async {
    final receivePort = ReceivePort();

    // Log request details
    _logger.i('API Request Details', error: {
      'endpoint': endpoint,
      'method': method,
      'queryParameters': queryParameters,
      'data': data,
      'formData': formData != null
          ? {
              'fields': formData.fields,
              'files': formData.files.map((f) => f.key).toList(),
            }
          : null,
    });

    final isolate = await Isolate.spawn(
      _isolateFunction,
      {
        'sendPort': receivePort.sendPort,
        'endpoint': endpoint,
        'method': method,
        'queryParameters': queryParameters,
        'data': data,
        'formData': formData,
        'baseUrl': AppConstants.baseUrl,
        'token': LocalStorage.storage!.read(AppConstants.token),
      },
    );

    final response = await receivePort.first;
    receivePort.close();
    isolate.kill();

    // Log response
    if (response is Map<String, dynamic> && response['error'] != null) {
      _logger.e('API Error Response', error: {
        'endpoint': endpoint,
        'statusCode': response['statusCode'],
        'error': response['data'],
      });

      throw DioException(
        requestOptions: RequestOptions(path: endpoint),
        error: response['error'],
        response: Response(
          requestOptions: RequestOptions(path: endpoint),
          data: response['data'],
          statusCode: response['statusCode'],
        ),
      );
    } else {
      _logger.i('API Success Response', error: {
        'endpoint': endpoint,
        'response': response,
      });
    }

    return response as Map<String, dynamic>?;
  }

  static Future<void> _isolateFunction(Map<String, dynamic> message) async {
    final SendPort sendPort = message['sendPort'];
    final String endpoint = message['endpoint'];
    final String method = message['method'];
    final String baseUrl = message['baseUrl'];
    final String? token = message['token'];

    final logger = Logger(
      printer: PrettyPrinter(
        methodCount: 0,
        errorMethodCount: 5,
        lineLength: 50,
        colors: true,
        printEmojis: true,
        printTime: true,
      ),
    );

    try {
      final dio = Dio(BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 60),
        receiveTimeout: const Duration(seconds: 60),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
      ));

      Response response;
      switch (method) {
        case 'GET':
          response = await dio.get(
            endpoint,
            queryParameters: message['queryParameters'],
          );
          break;
        case 'POST':
          response = await dio.post(
            endpoint,
            data: message['formData'] ?? message['data'],
          );
          break;
        case 'PUT':
          response = await dio.put(
            endpoint,
            data: message['formData'] ?? message['data'],
          );
          break;
        case 'DELETE':
          response = await dio.delete(
            endpoint,
            queryParameters: message['queryParameters'],
          );
          break;
        default:
          logger.e({'method': method}, error: 'Unsupported HTTP method');
          throw Exception('Unsupported method');
      }

      logger.d('Raw Response', error: {
        'statusCode': response.statusCode,
        'data': response.data,
      });

      if ([200, 201, 204].contains(response.statusCode)) {
        if (response.data['status'] != "0") {
          sendPort.send(response.data);
        } else {
          sendPort.send({
            'error': true,
            'data': response.data,
            'statusCode': response.statusCode,
          });
        }
      } else if ([401, 404, 403].contains(response.statusCode)) {
        logger.w('Authentication/Authorization Error', error: {
          'statusCode': response.statusCode,
          'data': response.data,
        });
        sendPort.send({
          'error': true,
          'data': response.data,
          'statusCode': response.statusCode,
        });
      } else {
        logger.e('API Error', error: {
          'statusCode': response.statusCode,
          'data': response.data,
        });
        sendPort.send({
          'error': true,
          'data': response.data,
          'statusCode': response.statusCode,
        });
      }
    } catch (e, stackTrace) {
      logger.e(
        'Exception in API call',
        error: {
          'error': e.toString(),
          'endpoint': endpoint,
          'method': method,
        },
        stackTrace: stackTrace,
      );
      sendPort.send({
        'error': true,
        'data': {'message': e.toString()},
        'statusCode': 500,
      });
    }
  }

  // Helper method to dispose of the logger
  static void dispose() {
    _logger.close();
  }
}
