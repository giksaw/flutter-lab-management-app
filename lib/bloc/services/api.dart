import 'dart:convert';


import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;


class ApiResponse {
  final int statusCode;
  final dynamic body;

  ApiResponse(this.statusCode, this.body);

  String getMsg() {
    if (body is String) {
      return body;
    } else if (body is Map && body.containsKey('data')) {
      return body['data'];
    }
    return 'Unknown error';
  }
}

class Api {
  static const baseUrl = "https://ft-app-backend.onrender.com";

  static Future<ApiResponse> registerUser(Map<String, dynamic> pdata) async {
    var url = Uri.parse("$baseUrl/register");

    try {
      final res = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(pdata), // Encode pdata to JSON string
      );

      var data = jsonDecode(res.body);
      print(data);
      print(res.statusCode);

      return ApiResponse(res.statusCode, data);
    } catch (e) {
      debugPrint(e.toString());
      return ApiResponse(500, "Something went wrong");
    }
  }

  static Future<ApiResponse> login(Map<String, dynamic> pdata) async {
    var url = Uri.parse("$baseUrl/login-user");

    try {
      final res = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(pdata), // Encode pdata to JSON string
      );

      var data = jsonDecode(res.body);
      print(data);
      print(res.statusCode);

      return ApiResponse(res.statusCode, data);
    } catch (e) {
      debugPrint(e.toString());
      return ApiResponse(500, "Something went wrong");
    }
  }

  static Future<Object> addchemical(Map<String, dynamic> pdata) async {
    var url = Uri.parse("$baseUrl/add-chemical");

    try {
      final res = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(pdata), // Encode pdata to JSON string
      );

      var data = jsonDecode(res.body);
      print("ho");
      print(data);
      print(res.statusCode);

      return res.statusCode;
    } catch (e) {
      debugPrint(e.toString());
      return 400;
    }
  }

  static Future<Object> usechemical(Map<String, dynamic> pdata) async {
    var url = Uri.parse("$baseUrl/use-chemical");

    try {
      final res = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(pdata), // Encode pdata to JSON string
      );

      var data = jsonDecode(res.body);
      print("hjo");
      print(data);
      print(res.statusCode);

      return res.statusCode;
    } catch (e) {
      debugPrint(e.toString());
      return 400;
    }
  }

  static Future<Object> addstock(Map<String, dynamic> pdata) async {
    var url = Uri.parse("$baseUrl/update-chemical");

    try {
      final res = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(pdata), // Encode pdata to JSON string
      );

      var data = jsonDecode(res.body);
      print("hey");
      print(data);
      print(res.statusCode);

      return res.statusCode;
    } catch (e) {
      debugPrint(e.toString());
      return 400;
    }
  }
  static Future<Object> addreagent(Map<String, dynamic> pdata) async {
    var url = Uri.parse("$baseUrl/add-reagent");

    try {
      final res = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(pdata), // Encode pdata to JSON string
      );

      var data = jsonDecode(res.body);
      print("ho");
      print(data);
      print(res.statusCode);

      return res.statusCode;
    } catch (e) {
      debugPrint(e.toString());
      return 400;
    }
  }


  static Future<Object> usereagent(Map<String, dynamic> pdata) async {
    var url = Uri.parse("$baseUrl/use-reagent");

    try {
      final res = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(pdata), // Encode pdata to JSON string
      );

      var data = jsonDecode(res.body);
      print("ho");
      print(data);
      print(res.statusCode);

      return res.statusCode;
    } catch (e) {
      debugPrint(e.toString());
      return 400;
    }
  }
  
    static Future<Object> useexp(Map<String, dynamic> pdata) async {
    var url = Uri.parse("$baseUrl/use-experiment");

    try {
      final res = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(pdata), // Encode pdata to JSON string
      );

      var data = jsonDecode(res.body);
      print("hjo");
      print(data);
      print(res.statusCode);

      return res.statusCode;
    } catch (e) {
      debugPrint(e.toString());
      return 400;
    }
  }

    static Future<Object> resetPassword(Map<String, dynamic> pdata) async {
    var url = Uri.parse("$baseUrl/forgotpass");

    try {
      final res = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(pdata), // Encode pdata to JSON string
      );

      var data = jsonDecode(res.body);
      print("ho");
      print(data);
      print(res.statusCode);

      return res.statusCode;
    } catch (e) {
      debugPrint(e.toString());
      return 400;
    }
  }

  static Future<Object> verifyOTP(Map<String, dynamic> pdata) async {
    var url = Uri.parse("$baseUrl/resetpass");

    try {
      final res = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(pdata), // Encode pdata to JSON string
      );

      var data = jsonDecode(res.body);
      print("ho");
      print(data);
      print(res.statusCode);

      return res.statusCode;
    } catch (e) {
      debugPrint(e.toString());
      return 400;
    }
  }

   static Future<Object> addexp(Map<String, dynamic> pdata) async {
    var url = Uri.parse("$baseUrl/add-experiment");

    try {
      final res = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(pdata), // Encode pdata to JSON string
      );

      var data = jsonDecode(res.body);
      print("ho");
      print(data);
      print(res.statusCode);

      return res.statusCode;
    } catch (e) {
      debugPrint(e.toString());
      return 400;
    }
  }

}

Future<Map<String, dynamic>> getChemicalReagentExperiment() async {
  try {
    // Send a GET request to the /chemical-reagent-experiment route
    final response = await http.get(Uri.parse(
        'https://ft-app-backend.onrender.com/chemical-reagent-experiment'));

    // Check the response status code
    if (response.statusCode == 200) {
      // Decode the response body
      final data = jsonDecode(response.body) as Map<String, dynamic>;

      // Extract the relevant data
      final chemicals = data['data']['chemicals'] as List<dynamic>;
      final reagents = data['data']['reagents'] as List<dynamic>;
      final experiments = data['data']['experiments'] as List<dynamic>;

      // Return the data as a Map
      return {
        'chemicals': chemicals,
        'reagents': reagents,
        'experiments': experiments,
      };
    } else {
      // Handle error response
      final errorMessage = jsonDecode(response.body)['message'] as String;
      throw Exception('Error fetching data: $errorMessage');
    }
  } catch (e) {
    // Handle any other errors
    rethrow;
  }
}


Future<Map<String, dynamic>> getchemicals() async {
  try {
    // Send a GET request to the /chemical-reagent-experiment route
    final response = await http.get(Uri.parse(
        'https://ft-app-backend.onrender.com/chemicals-reagent'));

    // Check the response status code
    if (response.statusCode == 200) {
      // Decode the response body
      final data = jsonDecode(response.body) as Map<String, dynamic>;

      // Extract the relevant data
      final chemicals = data['data']['chemicals'] as List<dynamic>;
      final reagents = data['data']['reagents'] as List<dynamic>;
      

      // Return the data as a Map
      return {
        'chemicals': chemicals,
        'reagents': reagents,
       
      };
    } else {
      // Handle error response
      final errorMessage = jsonDecode(response.body)['message'] as String;
      throw Exception('Error fetching data: $errorMessage');
    }
  } catch (e) {
    // Handle any other errors
    rethrow;
  }
}

Future<Map<String, dynamic>> getexpirementdetails(String expName) async {
  try {
         print( "'https://ft-app-backend.onrender.com/getexperiment/$expName'");
    // Send a GET request to the /getexperiment route with the experiment name as a query parameter
    final response = await http.get(
      
      Uri.parse('https://ft-app-backend.onrender.com/getexperiment/$expName'),
    );

    // Check the response status code
    if (response.statusCode == 200) {
      // Decode the response body
      final data = jsonDecode(response.body) as Map<String, dynamic>;

      // Extract the relevant data
      if (data['status'] == 'ok' && data['experiment'] != null) {
        final experiment = data['experiment'] as Map<String, dynamic>;
        final chemicals = experiment['chemicalsUsed'] as List<dynamic>;
        final reagents = experiment['reagentsUsed'] as List<dynamic>;

        // Return the data as a Map
        return {
          'chemicalsUsed': chemicals,
          'reagentsUsed': reagents,
        };
      } else {
        // Handle error response
        final errorMessage = data['message'] as String;
        throw Exception('Error fetching data: $errorMessage');
      }
    } else {
      // Handle error response
      final errorMessage = jsonDecode(response.body)['message'] as String;
      throw Exception('Error fetching data: $errorMessage');
    }
  } catch (e) {
    // Handle any other errors
    rethrow;
  }
}



Future<Map<String, dynamic>> getstock() async {
  try {
    // Send a GET request to the /avialablestock route
    final response = await http.get(Uri.parse('https://ft-app-backend.onrender.com/avialablestock'));

    // Check the response status code
    if (response.statusCode == 200) {
      // Decode the response body
      final data = jsonDecode(response.body) as Map<String, dynamic>;

      // Extract the relevant data
      final chemicals = data['data']['chemicals'] as List<dynamic>;

      // Return the data as a Map
      return {
        'chemicals': chemicals,
      };
    } else {
      // Handle error response
      final errorMessage = jsonDecode(response.body)['message'] as String;
      throw Exception('Error fetching data: $errorMessage');
    }
  } catch (e) {
    // Handle any other errors
    rethrow;
  }
}

Future<Map<String, dynamic>> getUsageHistory() async {
  try {
    // Send a GET request to the /getstock route
    final response = await http.get(Uri.parse('https://ft-app-backend.onrender.com/gethistory'));

    // Check the response status code
    if (response.statusCode == 200) {
      // Decode the response body
      final data = jsonDecode(response.body) as Map<String, dynamic>;

      // Extract the relevant data
      final histories = (data['histories'] as List<dynamic>)
          .map((history) => {
                '_id': history['_id'],
                'chemicalname': history['chemicalname'],
                'quantity': history['quantity'],
                'batch': history['batch'],
                'date': history['date'],
                'remark': history['remark'],
                'usedAs': history['usedAs'] ?? 'Chemical',
              })
          .toList();

      // Return the data as a Map
      return {
        'status': 'ok',
        'histories': histories,
      };
    } else {
      // Handle error response
      final errorMessage = jsonDecode(response.body)['message'] as String;
      throw Exception('Error fetching data: $errorMessage');
    }
  } catch (e) {
    // Handle any other errors
    rethrow;
  }
}





Future<Map<String, dynamic>> getRecentReagent() async {
  try {
    // Send a GET request to the /getstock route
    final response =
        await http.get(Uri.parse('https://ft-app-backend.onrender.com/recently-used-chemicals'));

    // Check the response status code
    if (response.statusCode == 200) {
      // Decode the response body
      final data = jsonDecode(response.body) as Map<String, dynamic>;

      // Check if the response has the expected format
      if (data['status'] == 'success' && data.containsKey('data')) {
        // Extract the relevant data
        final reagentList = data['data'] as List<dynamic>;

        // Return the data in the desired format
        return {
        
          'data': reagentList,
        };
      } else {
        // Handle unexpected response format
        throw Exception('Unexpected response format');
      }
    } else {
      // Handle error response
      final errorMessage = jsonDecode(response.body)['message'] as String;
      throw Exception('Error fetching data: $errorMessage');
    }
  } catch (e) {
    // Handle any other errors
    rethrow;
  }
}
