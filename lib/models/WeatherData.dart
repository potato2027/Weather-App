import 'dart:core';

class WeatherData
{
  String date;
  double maxTemperature;
  double minTemperature;
  double temperature;
  double humidity;
  double clouds;
  double windDirection;
  double windSpeed;

  WeatherData(this.date, this.maxTemperature, this.minTemperature, this.temperature, this.humidity, this.clouds, this.windDirection, this.windSpeed);

  factory WeatherData.fromJson(Map<String, dynamic> data)
  {
    return WeatherData(data['datetime'] ?? "", data['max_temp'].toDouble() ?? 0.0, data['min_temp'].toDouble() ?? 0.0, data['temp'].toDouble() ?? 0.0, data['rh'].toDouble() ?? 0.0, data['clouds'].toDouble()?? 0.0, data["wind_dir"].toDouble() ?? 0.0, data["wind_spd"].toDouble() ?? 0.0);
  }

}
