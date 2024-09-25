import 'package:flutter/material.dart';
class additional_info extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const additional_info({super.key, required this.icon,required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return   Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Icon(icon,size: 32,),
            const SizedBox(height: 8,),
            Text(label),
            const SizedBox(height: 8,),
            Text(value,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 16),)
          ],
        ),
      ),
    );
  }
}
