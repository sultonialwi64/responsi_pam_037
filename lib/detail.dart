import 'package:flutter/material.dart';
import 'category.dart';

class MealDetailsPage extends StatelessWidget {
  final Map<String, dynamic> mealDetails;

  MealDetailsPage({required this.mealDetails});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(mealDetails['strMeal'] ?? 'Meal Details'),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.black, Colors.blue],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.network(
              mealDetails['strMealThumb'] ?? '',
              height: 200,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 16),
            Text(
              mealDetails['strMeal'] ?? '',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(mealDetails['strInstructions'] ?? ''),
            // ... tambahkan tampilan rincian lainnya sesuai kebutuhan
          ],
        ),
      ),
    );
  }
}
