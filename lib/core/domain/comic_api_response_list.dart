class ComicApiResponseList<T> {
  final String? error;
  final int? limit;
  final int? offset;
  final int? numberOfPageResults;
  final int? numberOfTotalResults;
  final int? statusCode;
  final List<T> results;
  final String? version;

  ComicApiResponseList({
    this.error,
    this.limit,
    this.offset,
    this.numberOfPageResults,
    this.numberOfTotalResults,
    this.statusCode,
    required this.results,
    this.version,
  });

  factory ComicApiResponseList.fromJson(
      Map<String, dynamic> json, T Function(dynamic) fromJson) {
    return ComicApiResponseList<T>(
      error: json['error'],
      limit: json['limit'],
      offset: json['offset'],
      numberOfPageResults: json['number_of_page_results'],
      numberOfTotalResults: json['number_of_total_results'],
      statusCode: json['status_code'],
      results: (json['results'] as List<dynamic>)
          .map((data) => fromJson(data))
          .toList(),
      version: json['version'],
    );
  }

  copyWith({
    String? error,
    int? limit,
    int? offset,
    int? numberOfPageResults,
    int? numberOfTotalResults,
    int? statusCode,
    List<T>? results,
    String? version,
  }) {
    return ComicApiResponseList<T>(
      error: error ?? this.error,
      limit: limit ?? this.limit,
      offset: offset ?? this.offset,
      numberOfPageResults: numberOfPageResults ?? this.numberOfPageResults,
      numberOfTotalResults: numberOfTotalResults ?? this.numberOfTotalResults,
      statusCode: statusCode ?? this.statusCode,
      results: results ?? this.results,
      version: version ?? this.version,
    );
  }
}
