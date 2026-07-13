import 'dart:async';
import 'dart:convert';
import 'dart:typed_data'; // <-- ADD THIS IMPORT
import 'package:http/http.dart' as http;

class MockHttpClient implements http.Client {
  String responseToReturn = '';
  int statusCodeToReturn = 200;
  Uri? lastCalledUrl;
  Map<String, String>? lastCalledHeaders;
  String? lastCalledBody;

  @override
  Future<http.Response> get(Uri url, {Map<String, String>? headers}) async {
    lastCalledUrl = url;
    lastCalledHeaders = headers;
    return http.Response(responseToReturn, statusCodeToReturn);
  }

  @override
  Future<http.Response> post(Uri url, {Map<String, String>? headers, Object? body, Encoding? encoding}) async {
    lastCalledUrl = url;
    lastCalledHeaders = headers;
    lastCalledBody = body as String?;
    return http.Response('{"data": {}}', 201);
  }

  @override
  Future<http.Response> put(Uri url, {Map<String, String>? headers, Object? body, Encoding? encoding}) async {
    lastCalledUrl = url;
    lastCalledHeaders = headers;
    lastCalledBody = body as String?;
    return http.Response('', 200);
  }

  @override
  Future<http.Response> delete(Uri url, {Map<String, String>? headers, Object? body, Encoding? encoding}) async {
    lastCalledUrl = url;
    lastCalledHeaders = headers;
    return http.Response('', 204);
  }

  @override
  Future<Uint8List> readBytes(Uri url, {Map<String, String>? headers}) => throw UnimplementedError(); // <-- CORRECTED TYPE

  // --- Other methods ---
  @override
  Future<http.Response> head(Uri url, {Map<String, String>? headers}) => throw UnimplementedError();
  @override
  Future<http.Response> patch(Uri url, {Map<String, String>? headers, Object? body, Encoding? encoding}) => throw UnimplementedError();
  @override
  Future<String> read(Uri url, {Map<String, String>? headers}) => throw UnimplementedError();
  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) => throw UnimplementedError();
  @override
  void close() {}
}