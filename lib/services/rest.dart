import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'session_service.dart';

class RestService {
  final String _baseUrl;

  // Additional feature to this class, include a SessionService
  //  directly into this class.
  //  So that, we don't have to explicitly specify the headers
  //  (for the purposes of to include the acccess token),
  //  in every single call to the REST service.

  // The way it works, is basically mimicking the cookies feature
  //  in a web browser.
  // When each request call is made, this class firstly checks
  //  is there any session available, if so, read the token
  //  from the session and include it together to the request

  final SessionService _session;

  RestService({@required String baseUrl, bool enableSession = false})
      : _baseUrl = baseUrl,
        _session = enableSession ? SessionService() : null;

  Future<void> openSession(token) async {
    if (_session == null) return;
    await _session.setToken(token);
  }

  Future<void> closeSession() async {
    if (_session == null) return;
    await _session.setToken(null);
  }

  Future<Map<String, String>> get _defaultHeaders async {
    final headers = {'Content-Type': 'application/json'};

    if (_session != null) {
      //_session != null if enableSession is True

      final token = await _session.getToken();

      if (token != null) {
        headers['Authorization'] = 'Bearer $token';
      }
    }
    return headers;
  }

// The original code for the request methods, i.e. GET, POST, PUT, etc
//  share a common structure. Thus, we can refactor them into a method,
//   i.e. _httpRequest()

  _httpRequest(Function fn, String endpoint,
      {dynamic data,
      Map<String, String> headers,
      Encoding encoding,
      int successCode = 200}) async {
    if (headers == null) {
      headers = await _defaultHeaders;
    }

    if (data != null) data = jsonEncode(data);

    final uri = Uri.parse('$_baseUrl/$endpoint');
    final response = await fn(uri, headers, data, encoding);

    if (response.statusCode == successCode) {
      return jsonDecode(response.body);
    }
    throw response;
  }

// Send a GET request to retrieve data from a REST server
  get(String endpoint, {Map<String, String> headers}) => _httpRequest(
      (uri, headers, _data, _encoding) => http.get(uri, headers: headers),
      endpoint,
      headers: headers);

  // Send a POST request to add a new in the REST server
  post(String endpoint,
          {dynamic data, Map<String, String> headers, Encoding encoding}) =>
      _httpRequest(
          (uri, headers, data, encoding) => http.post(
                uri,
                headers: headers,
                body: data,
                encoding: encoding,
              ),
          endpoint,
          headers: headers,
          data: data,
          encoding: encoding,
          successCode: 201);

  // Send a PUT request to add a new in the REST server
  put(String endpoint,
          {dynamic data, Map<String, String> headers, Encoding encoding}) =>
      _httpRequest(
          (uri, headers, data, encoding) => http.put(
                uri,
                headers: headers,
                body: data,
                encoding: encoding,
              ),
          endpoint,
          headers: headers,
          data: data,
          encoding: encoding);

// Send a PATCH request to add a new in the REST server
  patch(String endpoint,
          {dynamic data, Map<String, String> headers, Encoding encoding}) =>
      _httpRequest(
          (uri, headers, data, encoding) => http.patch(
                uri,
                headers: headers,
                body: data,
                encoding: encoding,
              ),
          endpoint,
          headers: headers,
          data: data,
          encoding: encoding);

// Send a DELETE request to add a new in the REST server
  delete(String endpoint,
          {dynamic data, Map<String, String> headers, Encoding encoding}) =>
      _httpRequest(
          (uri, headers, data, encoding) => http.patch(
                uri,
                headers: headers,
                body: data,
                encoding: encoding,
              ),
          endpoint,
          headers: headers,
          data: data,
          encoding: encoding);
}

// Original code - before refactoring
// Send a GET request to retrieve data from a REST server
// Future get(String endpoint, {Map<String, String> headers}) async {
//   if (headers == null) {
//     headers = await _defaultHeaders;
//   }

//   final response =
//       await http.get(Uri.parse('$_baseUrl/$endpoint'), headers: headers);

//   if (response.statusCode == 200) {
//     return jsonDecode(response.body);
//   }
//   throw response;
// }

// Send a POST request to add a new in the REST server
// Future post(String endpoint,
//     {dynamic data, Map<String, String> headers, Encoding encoding}) async {
//   if (headers == null) headers = {'Content-Type': 'application/json'};
//   if (data != null) data = jsonEncode(data);

//   final response = await http.post(Uri.parse('$_baseUrl/$endpoint'),
//       headers: headers, body: data, encoding: encoding);

//   if (response.statusCode == 201) {
//     return jsonDecode(response.body);
//   }
//   throw response;
// }

// Send a PUT request to update an existing data in the REST server.
// Future put(String endpoint,
//     {dynamic data, Map<String, String> headers, Encoding encoding}) async {
//   if (headers == null) headers = {'Content-Type': 'application/json'};
//   if (data != null) data = jsonEncode(data);

//   final response = await http.put(Uri.parse('$_baseUrl/$endpoint'),
//       headers: headers, body: data, encoding: encoding);

//   if (response.statusCode == 200) {
//     return jsonDecode(response.body);
//   }
//   throw response;
// }

// Send a PATCH request to update parts of an existing data in the REST server.
// Future patch(String endpoint,
//     {dynamic data, Map<String, String> headers, Encoding encoding}) async {
//   if (headers == null) headers = {'Content-Type': 'application/json'};
//   if (data != null) data = jsonEncode(data);

//   final response = await http.patch(Uri.parse('$_baseUrl/$endpoint'),
//       headers: headers, body: data, encoding: encoding);

//   if (response.statusCode == 200) {
//     return jsonDecode(response.body);
//   }
//   throw response;
// }

// Send a DELETE request to remove an existing data from the REST server.
// Future delete(String endpoint,
//     {dynamic data, Map<String, String> headers, Encoding encoding}) async {
//   if (headers == null) headers = {'Content-Type': 'application/json'};
//   if (data != null) data = jsonEncode(data);
//   final response = await http.delete(Uri.parse('$_baseUrl/$endpoint'),
//       body: data, headers: headers, encoding: encoding);

//   if (response.statusCode == 200) {
//     return;
//   }
//   throw response;
// }
