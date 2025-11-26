import 'package:dio/dio.dart';
import 'package:google_maps_app/features/google_map/data/models/get_perdicitions_result/get_perdicitions_result.dart';
import 'package:google_maps_app/features/google_map/data/models/get_perdicitions_result/result.dart';

class PlacesPeridicationsRemoteDataSource {
  Dio dio = Dio();
  Future<List<Result>> getPerdications({required String place}) async {
    Response response = await dio.get(
      'https://places-api.foursquare.com/autocomplete?query=$place',
      queryParameters: {
        'query': place,
        'limit': 7,
      },
      options: Options(
        headers: {
          'X-Places-Api-Version': '2025-06-17',
          'authorization':
              'Bearer 5SXQXCBGTZV5FSMZCLFXBMOKQYR0YTH5USOKPUPHTNPXBYP5',
        },
      ),
    );
    GetPerdicitionsResult getPerdicitionsResult =
        GetPerdicitionsResult.fromJson(response.data);
    return getPerdicitionsResult.results ?? [];
  }
}
