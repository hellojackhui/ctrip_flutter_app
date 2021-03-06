import 'dart:async';
import 'package:ctrip_flutter_app/model/search_model.dart';
import 'package:dio/dio.dart';


const SEARCH_URL = 'https://m.ctrip.com/restapi/h5api/searchapp/search?source=mobileweb&action=autocomplete&contentType=json&keyword=';

class SearchDao {
  static Future<SearchModel> fetch(String keyword) async {
    Response response = await Dio().get(SEARCH_URL + keyword);
    if (response.statusCode == 200) {
      SearchModel model = SearchModel.fromJson(response.data);
      model.keyword = keyword;
      return model;
    } else {
      throw Exception('Failed to load search');
    }
  }
}