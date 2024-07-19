import 'dart:convert';

import 'package:http/http.dart';

import 'error_handle.dart';

class TMDBApiResponse {
  final Response? response;
  bool hasError = false;
  String errorMessage = "No data returned from the API";
  dynamic data;

  TMDBApiResponse(this.response) {
    try {
      if (response == null) {
        hasError = true;
        errorMessage = "Response is null";
        return;
      }
      Map<String, dynamic> dataMap = jsonDecode(response!.body);

      if (dataMap.isEmpty) {
        hasError = true;
        errorMessage = 'No data returned from the API.';
        return;
      }

      if (dataMap.containsKey("status_message")) {
        hasError = true;
        errorMessage = dataMap["status_message"];
        return;
      }

      if (response!.statusCode >= 200 && response!.statusCode < 300) {
        data = dataMap;
        return;
      }

      hasError = true;
      errorMessage = "Error: ${response!.statusCode}, ${response!.reasonPhrase}";
    } catch (error, stackTrace) {
      Errorhandler.report(error, stackTrace, "@LoginDatasource -login");
    }
  }
}
