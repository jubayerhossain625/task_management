

import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:task_management/util/app_constants.dart';
import '../../common/widgets/custom_toast.dart';
import '../data/local_data/local_storage_source.dart';
import 'api_client.dart';
import 'dynamic_timeout_interceptor.dart';
import 'isolate_manager.dart';

class APIClintImpl implements APIClient {
  String? token;

  @override
  Future<dynamic> get(String endpoint,
      {Map<String, dynamic>? queryParameters}) async {
    try {
      final result = await IsolateManager.executeInIsolate(
        endpoint: endpoint,
        method: 'GET',
        queryParameters: queryParameters,
      );
      return result;
    } catch (error) {
      _handleDioError(error, "Failed to load data from server!");
      return null;
    }
  }

  @override
  Future<dynamic> uploadFiles(String endpoint,
      {Map<String, dynamic>? data,
      Map<String, dynamic>? keysAndFilePaths}) async {
    try {
      FormData formData = FormData();

      if (data != null) {
        data.forEach((key, value) {
          formData.fields.add(MapEntry(key, value.toString()));
        });
      }

      if (keysAndFilePaths != null) {
        for (var entry in keysAndFilePaths.entries) {
          String fileName = entry.value.split('/').last;
          formData.files.add(MapEntry(
            entry.key,
            await MultipartFile.fromFile(entry.value, filename: fileName),
          ));
        }
      }

      final result = await IsolateManager.executeInIsolate(
        endpoint: endpoint,
        method: 'POST',
        formData: formData,
      );
      return result;
    } catch (error) {
      _handleDioError(error, "Failed to upload files!");
      return null;
    }
  }

  late Dio _dio;
  APIClintImpl() {
    BaseOptions options = BaseOptions(
      baseUrl: AppConstants.baseUrl,
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${LocalStorage.storage!.read(AppConstants.token)}'
      },
    );
    _dio = Dio(options);
    _dio.interceptors.add(DynamicTimeoutInterceptor());
    if (true) {
      _dio.interceptors.add(PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: false,
          error: true,
          compact: true,
          maxWidth: 90));
    }
  }

  Future<Map<String, dynamic>?> purifyResponse(
      Future<Response> response) async {
    String errorMessage = "Failed to load data from server!";
    Map<String, dynamic> result = {};

    try {
      final value = await response;

      // Success cases (200, 201, 204)
      if ([200, 201, 204].contains(value.statusCode)) {
        if (value.data['status'] != "0") {
          result = value.data;
        } else {
          _handleCustomErrors(value.data);
        }
      } else {
        // Handle errors for non-successful status codes
        errorMessage = value.data['message'] ?? errorMessage;
        _showErrorSnackbar(errorMessage);
        throw Exception(errorMessage);
      }
    } catch (error) {
      _handleDioError(error, errorMessage);
    }

    return result.isEmpty ? null : result;
  }

  void _handleCustomErrors(Map<String, dynamic> data) {
    if (data['statusCode'] == 400 &&
        data['message'] == "Not all products have enough stock") {
      CustomToast.showFailed(data['message']);
    } else {
      String errorMessage = data['message'] ?? "An unexpected error occurred";
      _showErrorSnackbar(errorMessage);
    }
  }

  void _handleDioError(dynamic error, String defaultMessage) {
    if (error is DioException && error.response != null) {
      final message = error.response!.data['message'] ?? defaultMessage;
      String cleanErrorMessage(String message) {
        // Find the index of the first period
        int periodIndex = message.indexOf('.');

        // If a period is found, return the substring up to that period
        return periodIndex != -1
            ? message.substring(0, periodIndex + 1)
            : message;
      }

      // Specific error handling
      switch (message) {
        case 'The phone has already been taken.':
          CustomToast.showWarning('The phone number has already been taken.');
          break;
        case "No query results for model [App\\Models\\Category].":
          CustomToast.showWarning('No brand found in this category');
          break;
        case 'The email has already been taken.':
          CustomToast.showWarning('The email address has already been taken.');
          break;
        case 'validation.phone':
          CustomToast.showWarning('Please provide a valid phone number.');
          break;
        case 'Not all products have enough stock':
          CustomToast.showFailed(message);
          break;
        case 'The store id field is required.':
          CustomToast.showWarning('Please select a store');
          break;
        case 'The email field must be a valid email address.':
          CustomToast.showWarning('Please provide a valid email address');
          break;
        case 'Invalid credentials':
          CustomToast.showFailed(message);
          break;
        case 'The selected phone is invalid.':
        case 'The selected email is invalid.':
          CustomToast.showWarning(message);
          break;
        default:
          if (message.contains('401') ||
              message.contains('404') ||
              message.contains('403') ||
              message.contains('422') ||
              message.contains('500') ||
              message.contains('501') ||
              message.contains('400') ||
              message.contains('502') ||
              message.contains('503') ||
              message.contains('The connection errored')) {
            // CustomToast.showFailed("Server error");
          } else if (message.contains('App\\Models')) {
            return;
          } else {
            CustomToast.showFailed(message);
          }
          log("---------------------default-----------------------");
          log(message);
          log("--------------------------------------------");
      }
    } else {
      log("------------------Log Error--------------------------");
      log(error.toString());
      log("--------------------------------------------");
    }
  }

  void _showErrorSnackbar(String message) {
    log("------------------Throw Error--------------------------");
    log(message);
    log("--------------------------------------------");
    CustomToast.showFailed(message);
  }


  @override
  Future<dynamic> post(String endpoint, {required String data}) async {
    return await purifyResponse(_dio.post(endpoint, data: data));
  }

  @override
  Future<dynamic> uploadFileTypesImage(String endpoint,
      {Map<String, dynamic>? data,
      List<Map<String, String>>? keysAndFilePaths}) async {
    FormData formData = FormData();

    if (data != null) {
      data.forEach((key, value) {
        formData.fields.add(MapEntry(key, value.toString()));
      });
    }

    if (keysAndFilePaths != null) {
      for (var map in keysAndFilePaths) {
        for (var entry in map.entries) {
          String key = entry.key;
          String value = entry.value;

          String fileName = value.split('/').last;
          formData.files.add(MapEntry(
            key,
            await MultipartFile.fromFile(value, filename: fileName),
          ));
        }
      }
    }
    return await purifyResponse(_dio.post(endpoint, data: formData));
  }

  @override
  Future<dynamic> updateFileTypesImage(String endpoint,
      {Map<String, dynamic>? data,
      List<Map<String, String>>? keysAndFilePaths}) async {
    FormData formData = FormData();

    // Add any additional form data fields
    if (data != null) {
      data.forEach((key, value) {
        formData.fields.add(MapEntry(key, value.toString()));
      });
    }

    // Add files to the FormData
    if (keysAndFilePaths != null) {
      for (var map in keysAndFilePaths) {
        for (var entry in map.entries) {
          String key = entry.key;
          String value = entry.value;

          String fileName = value.split('/').last;
          formData.files.add(MapEntry(
            key,
            await MultipartFile.fromFile(value, filename: fileName),
          ));
        }
      }
    }

    // Use PUT request with the constructed FormData
    return await purifyResponse(_dio.put(endpoint, data: formData));
  }

  @override
  Future<dynamic> delete(String endpoint,
      {Map<String, dynamic>? queryParameters}) async {
    return await purifyResponse(
        _dio.delete(endpoint, queryParameters: queryParameters));
  }

  @override
  Future<dynamic> put(String endpoint, {required String data}) async {
    return purifyResponse(_dio.put(endpoint, data: data));
  }

  @override
  Future<dynamic> patch(String endpoint, {required String data}) async {
    return purifyResponse(_dio.patch(endpoint, data: data));
  }
}
