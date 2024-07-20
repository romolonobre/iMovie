import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:imovie_app/app/commons/app_services/env.dart';

class APIRequest {
  //Get Request
  final String baseUrl = Env.apiBaseUrl;
  final Map<String, String> requestHeaders = {
    'Authorization': Env.token,
    'accept': 'application/json',
  };
  @protected
  Future<http.Response?> get(
    String endpoint, {
    Map<String, String>? headers,
  }) {
    return http.get(
      Uri.parse("$baseUrl$endpoint"),
      headers: requestHeaders,
    );
  }

  @protected
  Future<http.Response?> post(
    String endpoint, {
    Map<String, String>? headers,
    Map<String, dynamic>? body,
  }) {
    log(json.encode(body));
    return http.post(
      Uri.parse("$baseUrl$endpoint"),
      headers: requestHeaders,
      body: json.encode(body),
    );
  }
}
