
class ApiError {
  final String code;
  final String description;
  final String type;

  ApiError({
    required this.code,
    required this.description,
    required this.type,
  });

  factory ApiError.fromJson(Map<String, dynamic> json) {
    return ApiError(
      code: json['code'],
      description: json['description'],
      type: json['type'],
    );
  }
}
