class ErrorResponseModel {
  final int statusCode;
  final String? error;
  final String? message;

  const ErrorResponseModel(
      {required this.statusCode, required this.message, required this.error});

  factory ErrorResponseModel.fromJson(Map<String, dynamic> json) =>
      ErrorResponseModel(
        statusCode: int.parse(json['statusCode']),
        error: json['error'],
        message: json['message'],
      );
}
