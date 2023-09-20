import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/models/WeatherData.dart';
import 'package:untitled/viewmodels/HomeController.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(0, 12, 123, 1),
      body: GetBuilder<HomeController>(
        builder: (homeController) {
          return FutureBuilder(
            future: homeController.getWeatherData(),
            builder: (context, snapshot) {
              if(snapshot.connectionState == ConnectionState.done) {
                return Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.08),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: TextField(
                          onSubmitted: (value) {
                            homeController.search = value;
                            homeController.update();
                          },
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.search),
                            hintText: 'Search City',
                            filled: true,
                            fillColor: Colors.grey[200], // Background color
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0), // Rounded border
                              borderSide: BorderSide.none, // Hide the border
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 30, top: 40),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Obx(() {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("${homeController.temperature.value.round()}°", style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 80
                                  )),
                                  const Padding(
                                    padding: EdgeInsets.only(top: 6.0),
                                    child: Text("Partly Cloudy", style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16
                                    )),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 6.0),
                                    child: Text(homeController.cityName, style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16
                                    )),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 6.0),
                                    child: Text(homeController.dateShown.value, style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16
                                    )),
                                  )
                                ],
                              );
                            }
                          ),
                          Image.asset("assets/CloudPicture.png")
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 40.0),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.4,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Card(
                              elevation: 20,
                              semanticContainer: true,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              color: const Color.fromRGBO(0, 13, 79, 1),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)
                              ),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 28, left: 30, right: 30),
                                    child: Container(
                                        height: MediaQuery.of(context).size.height * 0.05,
                                        decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.all(Radius.circular(10)),
                                            color: Color.fromRGBO(124, 136, 197, 1)
                                        ),
                                        child: Obx(() {
                                            return Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Text("${homeController.humidityShown.value} %", style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 14
                                                )),
                                                Text("${homeController.windSpeed.value} km/h", style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 14
                                                )),
                                                Text("${homeController.maxTemperature.value}° / ${homeController.minTemperature.value}°", style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 14
                                                ))
                                              ],
                                            );
                                          }
                                        )
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 30),
                                      child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: homeController.weatherData.length,
                                          itemBuilder: (context, index) {
                                            return Padding(
                                              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                                              child: GestureDetector(
                                                onTap: () {
                                                  homeController.changeDay(index);
                                                },
                                                child: Container(
                                                  height: MediaQuery.of(context).size.height * 0.08,
                                                  decoration: const BoxDecoration(
                                                      borderRadius: BorderRadius.all(Radius.circular(10)),
                                                      color: Color.fromRGBO(124, 136, 197, 1)
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets.symmetric(horizontal: 5),
                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                      children: [
                                                        Text(homeController.getWeekDay(DateTime.parse(homeController.weatherData[index].date).weekday), style: const TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 14
                                                        )),
                                                        Text("${homeController.weatherData[index].temperature.round()}°", style: const TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 14
                                                        )),
                                                        Image.asset("assets/MiniCloud.png"),
                                                        Text("${homeController.weatherData[index].humidity}%", style: const TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 14
                                                        ))
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          }
                                      ),
                                    ),
                                  )
                                ],
                              )
                          ),
                        ),
                      ),
                    )
                  ],
                );
              }
              else{
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }
          );
        }
      ),
    );
  }
}
