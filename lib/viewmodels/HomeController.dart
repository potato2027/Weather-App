import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/models/WeatherData.dart';
class HomeController extends GetxController
{
  String search = "Rawalpindi";
  String cityName = "";
  RxString dateShown = "".obs;
  RxDouble humidityShown = 0.0.obs;
  RxDouble windSpeed = 0.0.obs;
  RxDouble maxTemperature = 0.0.obs;
  RxDouble minTemperature = 0.0.obs;
  RxDouble temperature = 0.0.obs;
  List<WeatherData> weatherData = [];
  String getWeekDay(int day)
  {
    if(day == 1){
      return "Monday";
    }
    else if(day == 2){
      return "Tuesday";
    }
    else if(day == 3){
      return "Wednesday";
    }
    else if(day == 4){
      return "Thursday";
    }
    else if(day == 5){
      return "Friday";
    }
    else if(day == 6){
      return "Saturday";
    }
    else{
      return "Sunday";
    }
  }
  Future getWeatherData() async
  {
    final results = await http.get(
        Uri.parse("https://api.weatherbit.io/v2.0/history/daily?city=${search}&key=bcc12dfd1e4b41b185356cca8f4654a8&include=daily&start_date=2023-09-14&end_date=2023-09-21"),
        headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8'
      },
    );
    if(results.statusCode == 200){
      weatherData = [];
      final data = jsonDecode(results.body);
      cityName = data["city_name"];
      for(int i = data["data"].length - 1; i >= 0; i--) {
          weatherData.add(WeatherData.fromJson(data["data"][i]));
      }
      dateShown.value = weatherData[0].date;
      humidityShown.value = weatherData[0].humidity;
      windSpeed.value = weatherData[0].windSpeed;
      maxTemperature.value = weatherData[0].maxTemperature;
      minTemperature.value = weatherData[0].minTemperature;
      temperature.value = weatherData[0].temperature;

    }
    else{
      Get.snackbar("Error", "Cannot Connect To Service");
    }
  }

  void changeDay(int index)
  {
    dateShown.value = weatherData[index].date;
    humidityShown.value = weatherData[index].humidity;
    windSpeed.value = weatherData[index].windSpeed;
    maxTemperature.value = weatherData[index].maxTemperature;
    minTemperature.value = weatherData[index].minTemperature;
    temperature.value = weatherData[index].temperature;
  }


}
