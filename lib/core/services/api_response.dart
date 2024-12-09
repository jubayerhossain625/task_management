class APIResponse {
  final bool success;
  final Map<String, dynamic>? data;
  final String? errorMessage;
  final int? statusCode;

  APIResponse({
    required this.success,
    this.data,
    this.errorMessage,
    this.statusCode,
  });

  factory APIResponse.success(Map<String, dynamic> data) {
    return APIResponse(success: true, data: data);
  }

  factory APIResponse.error(String message, {int? statusCode}) {
    return APIResponse(
      success: false,
      errorMessage: message,
      statusCode: statusCode,
    );
  }
}
