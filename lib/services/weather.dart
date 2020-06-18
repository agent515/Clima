import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';

const apiKey = '44cdfb6aaf8b8ccf97434246ac09f188';
const openWeatherMapUrl = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {

  Future<dynamic> getWeatherDataForTheCity(cityName) async {
      NetworkHelper networkHelper = NetworkHelper('$openWeatherMapUrl?q=$cityName&appid=$apiKey&units=metric');
      print('$openWeatherMapUrl?q=$cityName&appid=$apiKey&units=metric');
      var weatherData = await networkHelper.getData();
      return weatherData;
  }

  Future<dynamic> getWeatherData() async{
    Location location = new Location();
    await location.getCurrentPosition();
    if(location.longitude == null || location.latitude == null){
      return null;
    }
    NetworkHelper networkHelper = NetworkHelper('$openWeatherMapUrl?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric');
//        NetworkHelper networkHelper = NetworkHelper('https://samples.openweathermap.org/data/2.5/weather?lat=35&lon=139&appid=b6907d289e10d714a6e88b30761fae22');
    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
