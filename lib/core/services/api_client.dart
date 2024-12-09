abstract class APIClient {
  Future<dynamic> get(String endpoint, {Map<String, dynamic>? queryParameters});
  Future<dynamic> post(String endpoint, {required String data});
  Future<dynamic> uploadFiles(String endpoint,
      {Map<String, dynamic>? data, Map<String, dynamic>? keysAndFilePaths});

  Future<dynamic> uploadFileTypesImage(String endpoint,
      {Map<String, dynamic>? data,
      List<Map<String, String>>? keysAndFilePaths});

  Future<dynamic> updateFileTypesImage(String endpoint,
      {Map<String, dynamic>? data,
      List<Map<String, String>>? keysAndFilePaths});

  Future<dynamic> delete(String endpoint,
      {Map<String, dynamic>? queryParameters}); // Added delete method

  Future<dynamic> put(String endpoint, {required String data});

  Future<dynamic> patch(String endpoint, {required String data});
}
