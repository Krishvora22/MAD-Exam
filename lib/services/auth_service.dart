import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AuthService {
  static const String baseUrl = 'http://localhost:3000/api';
  static const String mongoUri = 'mongodb+srv://Darshan_2205:dav1234@dav.vc6oc.mongodb.net/LVSMACHINEANDTOOLS?retryWrites=true&w=majority&authSource=admin';
  static const String jwtSecret = '3e7f1b8c-9c2a-4d6e-8b5a-2f4c1e7a9d3f';

  Future<String?> getStoredToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<void> storeToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  Future<User> register(String name, String email, String password) async {
    try {
      // Make sure API endpoint path is correct
      final response = await http.post(
        Uri.parse('$baseUrl/register'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'name': name,
          'email': email,
          'password': password,
        }),
      );

      print('Registration response status: ${response.statusCode}');
      print('Registration response body: ${response.body}');
      
      if (response.statusCode == 201) {
        final data = json.decode(response.body);
        
        // Store token if it exists
        if (data['token'] != null) {
          await storeToken(data['token']);
        }
        
        // Create a user object even if user data is missing
        if (data['user'] != null) {
          return User.fromJson(data['user']);
        } else {
          // Create a minimal user with the data we have
          return User(
            id: DateTime.now().toString(),
            name: name,
            email: email,
            createdAt: DateTime.now().toString(),
          );
        }
      } else {
        throw Exception('Registration failed: ${response.body}');
      }
    } catch (e) {
      print('Registration error: $e');
      throw Exception('Registration failed: $e');
    }
  }

  Future<User> login(String email, String password) async {
    try {
      print('Attempting login with email: $email');
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'email': email,
          'password': password,
        }),
      );

      print('Login response status: ${response.statusCode}');
      print('Login response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        
        if (data['token'] != null) {
          await storeToken(data['token']);
        }
        
        if (data['user'] != null) {
          return User.fromJson(data['user']);
        } else {
          // Create a minimal user if data is missing
          return User(
            id: DateTime.now().toString(),
            name: 'User',
            email: email,
            createdAt: DateTime.now().toString(),
          );
        }
      } else {
        throw Exception('Invalid credentials');
      }
    } catch (e) {
      print('Login error: $e');
      throw Exception('Invalid credentials');
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }

  Future<bool> isLoggedIn() async {
    final token = await getStoredToken();
    return token != null;
  }
}