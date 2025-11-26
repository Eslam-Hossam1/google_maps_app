import 'result.dart';

class GetPerdicitionsResult {
  List<Result>? results;

  GetPerdicitionsResult({this.results});

  factory GetPerdicitionsResult.fromJson(Map<String, dynamic> json) {
    return GetPerdicitionsResult(
      results: (json['results'] as List<dynamic>?)
          ?.map((e) => Result.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'results': results?.map((e) => e.toJson()).toList(),
      };
}
