import 'package:flutter/material.dart';

class hourlyForecast extends StatelessWidget {
  final String time;
  final IconData icon;
  final String temprature;
  const hourlyForecast({super.key,required this.time, required this.icon,required this.temprature});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,

      child: Container(
        width: 100,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12)
        ),
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(time,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),maxLines: 1,overflow: TextOverflow.ellipsis,),
              SizedBox(height: 8,),
              Icon(icon,size: 32,),
              SizedBox(height: 8,),
              Text(temprature),
            ],
          ),
        ),
      ),
    );
  }
}