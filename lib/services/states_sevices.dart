import 'dart:convert';

import 'package:covid_19_tracker/model/world_states_model.dart';
import 'package:covid_19_tracker/services/utilities/app_url.dart';
import 'package:http/http.dart' as http;

class StatesServices{
  Future<WorldStatesModel> fetchWorldStatesRecords() async{
    final response = await http.get(Uri.parse(AppUrl.worldStatesApi));

    if(response.statusCode == 200){
      var data = jsonDecode(response.body);
      return WorldStatesModel.fromJson(data);

    }else{
      throw Exception("Error..");
    }
  }

  Future<List<dynamic>> fetchCountriesListApi() async{
    final response = await http.get(Uri.parse(AppUrl.countriesList));
    var data;
    if(response.statusCode == 200){
       data = jsonDecode(response.body);
      return data;

    }else{
      throw Exception("Error..");
    }
  }
}