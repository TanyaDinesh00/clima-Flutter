import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';

const apiKey = '4393ffda89198f97b150ea71bcfb490e';
const openingRL = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {
  Future<dynamic> getCityWeather(String cityName) async {
    print("Fetching Location");
    Location location = Location();
    await location.getCurrentLocation();

    NetworkHelper networkHelper =
        NetworkHelper('$openingRL?q=$cityName&appid=$apiKey&units=metric');

    var weatherData = await networkHelper.getData();

    String city = weatherData['name'];
    String sky = weatherData['weather'][0]['main'];

    print('City: $city, Sky; $sky');

    return weatherData;
  }

  Future<dynamic> getLocationWeather() async {
    print("Fetching Location");
    Location location = Location();
    await location.getCurrentLocation();

    NetworkHelper networkHelper = NetworkHelper(
        '$openingRL?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric');

    var weatherData = await networkHelper.getData();

    String city = weatherData['name'];
    String sky = weatherData['weather'][0]['main'];

    print('City: $city, Sky; $sky');

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
