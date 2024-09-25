import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/additionalinformation.dart';
import 'package:weather_app/secret.dart';
import 'hourly_forecast.dart';
import 'package:http/http.dart' as http;

class main_screen extends StatefulWidget {
  const main_screen({super.key});

  @override
  State<main_screen> createState() => _main_screenState();
}

class _main_screenState extends State<main_screen> {
  //double temp=0;
  late final Future<Map<String,dynamic>> weather;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    weather=getCurrentWeather();
  }

  final String cityName = "Rajkot";

  Future<Map<String, dynamic>> getCurrentWeather() async {
    try {
      final result = await http.get(Uri.parse(
          'http://api.openweathermap.org/data/2.5/forecast?q=$cityName&APPID=$openWeatherApiKey'));
      //print(result.body);
      
      final data=jsonDecode(result.body);
      if(data['cod']!='200'){
          throw "An unexpected error occured";
      }
      return data;
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Weather App",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {

              });
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body:FutureBuilder(
        future: getCurrentWeather() ,
        builder: (context, snapshot) {
          if(snapshot.connectionState==ConnectionState.waiting){
            return const Center(child:  CircularProgressIndicator.adaptive());
          }
          if(snapshot.hasError){
            return Center(child: Text(snapshot.error.toString()));
          }
          // Fetching data from aip.......................

          final data=snapshot.data!;
          final currentWeatherData=data['list'][0];
          final currentTemp= currentWeatherData['main']['temp']-273.15;
          final currentSky=currentWeatherData['weather'][0]['main'];
          final currentHumidity=currentWeatherData['main']['humidity'];
          final currentSpeed=currentWeatherData['wind']['speed'];
          final currentPressure=currentWeatherData['main']['pressure'];

          //converting data into string
          final String convertedTemp=currentTemp.toStringAsFixed(2);


          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(cityName,style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
                  SizedBox(
                    width: double.infinity,
                    child: Card(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              children: [
                                Text(
                                  "${convertedTemp}°C",
                                  style: const TextStyle(
                                      fontSize: 32, fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                Icon(
                                  currentSky=='Clouds' || currentSky=='Rain'?
                                  Icons.cloud:Icons.sunny,
                                  size: 64,
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                 Text(
                                  currentSky,
                                  style: const TextStyle(fontSize: 20),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Hourly Forecast",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
            
                  SizedBox(
                    height: 120,
                    child: ListView.builder(
                      itemCount: 5,
                      scrollDirection: Axis.horizontal,
            
                      itemBuilder:(context, index) {
                        final hourData=data['list'][index+1];
                        final converTedHourData=hourData['main']['temp']-273.15;
                        final String converTedHourDataString= converTedHourData.toStringAsFixed(2);
                        final timee=DateTime.parse(hourData['dt_txt']);
                           return hourlyForecast(
                               time: DateFormat.j().format(timee),
                               icon: hourData['weather'][0]['main']=='Clouds' || hourData['weather'][0]['main']=='Rain'?Icons.cloud:Icons.sunny,
                               temprature: converTedHourDataString+"°C");
                        },
                    ),
                  ),
            
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Additional Information",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                   Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      additional_info(
                        icon: Icons.water_drop,
                        label: "Humidity",
                        value: currentHumidity.toString(),
                      ),
                      additional_info(
                        icon: Icons.air,
                        label: "Wind Speed",
                        value: currentSpeed.toString(),
                      ),
                      additional_info(
                        icon: Icons.beach_access,
                        label: "Pressure",
                        value: currentPressure.toString(),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
