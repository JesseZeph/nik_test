class NetworkResponse {
  final bool status;
  final bool? success;
  final String message;
  final dynamic data;
  NetworkResponse({
    required this.status,
    this.success,
    required this.message,
    required this.data,
  });

  factory NetworkResponse.fromMap(Map<String, dynamic> map) {
    return NetworkResponse(
      status: map['success'] ?? false,
      success: map['success'],
      message: map['message'] ?? '',
      data: map['data'],
    );
  }

  @override
  String toString() =>
      'NetworkResponse(status: $status, message: $message, data: $data)';
}
