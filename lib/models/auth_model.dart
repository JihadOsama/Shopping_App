class AuthRequest {
  final String email;
  final String password;
  final String? name;
  final String? phone;

  AuthRequest({
    required this.email,
    required this.password,
    this.name,
    this.phone,
  });
}

class AuthResponse {
  final bool status;
  final String message;

  AuthResponse({required this.status, required this.message});
  factory AuthResponse.fromJson(Map<String, dynamic> data) {
    return AuthResponse(status: data['statusCode'], message: data['message']);
  }
}