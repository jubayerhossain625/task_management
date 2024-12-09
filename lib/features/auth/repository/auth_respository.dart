import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:task_management/util/app_constants.dart';
import '../../../core/services/api_client_implemnt.dart';
import '../model/loginresponsemodel.dart';
import '../model/otp_verify_response_model.dart';
import '../model/register_response_model.dart';

class AuthRepository {
  final clientApi = APIClintImpl();

  Future<LoginResponseModel?>login(body)async{
    dynamic response = await clientApi.post(AppConstants.loginUri, data: jsonEncode(body));
    return response!=null?LoginResponseModel.fromJson(response):null;
  }
  Future<OtpVerifyResponseModel?>verify(body)async{
    dynamic response = await clientApi.post(AppConstants.activateUserUri, data: jsonEncode(body));
    return response!=null?OtpVerifyResponseModel.fromJson(response):null;
  }


  Future<RegisterResponseModel?> register(
      Map<String, String> body,
      List<Map<String, String>>? files,
      ) async {
    try {
      // Create the multipart request
      var uri = Uri.parse('http://206.189.138.45:8052/user/profile');
      var request = http.MultipartRequest('POST', uri);

      // Add fields to the request
      body.forEach((key, value) {
        request.fields[key] = value;
      });

      // Add files to the request
      if (files != null && files.isNotEmpty) {
        for (var file in files) {
          var filePath = file['file'];
          if (filePath != null && filePath.isNotEmpty) {
            request.files.add(
              await http.MultipartFile.fromPath(
                'file', // Field name expected by the server
                filePath,
              ),
            );
          }
        }
      }

      request.headers.addAll({
        'Content-Type': 'multipart/form-data', // Explicitly set multipart content type if needed
      });

      // Send the request
      var streamedResponse = await request.send();

      // Parse the response
      if (streamedResponse.statusCode == 200) {
        var response = await http.Response.fromStream(streamedResponse);
        return RegisterResponseModel.fromJson(jsonDecode(response.body));
      } else {
        var response = await http.Response.fromStream(streamedResponse);
        print("Error Response: ${response.body}");
        return RegisterResponseModel(
            message: "Something went wrong: ${response.reasonPhrase}");
      }
    } catch (e) {
      print("Error: $e");
      return RegisterResponseModel(message: "Error occurred: $e");
    }
  }



}