import 'dart:convert';

import 'package:http/http.dart' as http;

class THttpHelper{
    static const String _baseURL = 'google.com';

// helper method to make GET request
    static Future<Map<String, dynamic>> get(String endpoint ) async {
       final response  = await http.get(Uri.parse('$_baseURL/$endpoint'));
       return _handleResponse(response);
    }

// helper method to make POST request
    static Future<Map<String, dynamic>> post(String endpoint, Map<String, String> data ) async {
       final response  = await http.post(
         Uri.parse('$_baseURL/$endpoint'),
          headers: {'Content_Type':'application/json'},
          body: json.encode(data),
       );
       return _handleResponse(response);
    }


// helper method to make POST request
    static Future<Map<String, dynamic>> put(String endpoint, Map<String, String> data ) async {
       final response  = await http.post(
         Uri.parse('$_baseURL/$endpoint'),
          headers: {'Content_Type':'application/json'},
          body: json.encode(data),
       );
       return _handleResponse(response);
    }



// helper method to make DELETE request
  static Future<Map<String, dynamic>> delete(String endpoint ) async {
    final response  = await http.post(Uri.parse('$_baseURL/$endpoint'));
    return _handleResponse(response);
  }


// handle the HTTP response
  static Map<String, dynamic> _handleResponse(http.Response response){
      if (response.statusCode == 200 ){
        return json.decode(response.body);
  }
      else{
        throw Exception('Failed to load data: ${response.statusCode}');
  }
    }
}