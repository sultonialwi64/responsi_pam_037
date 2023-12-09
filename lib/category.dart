import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'main.dart';

class CategoryDetailsPage extends StatefulWidget {
  final String categoryName;

  CategoryDetailsPage({required this.categoryName});

  @override
  _CategoryDetailsPageState createState() => _CategoryDetailsPageState();
}

class _CategoryDetailsPageState extends State<CategoryDetailsPage> {
  List<dynamic> meals = [];

  @override
  void initState() {
    super.initState();
    fetchMeals();
  }

  Future<void> fetchMeals() async {
    final response = await http.get(
        Uri.parse('${baseApiUrl}filter.php?c=${widget.categoryName}'));

    if (response.statusCode == 200) {
      setState(() {
        meals = json.decode(response.body)['meals'];
      });
    } else {
      throw Exception('Failed to load meals');
    }
  }

  Future<void> fetchMealDetails(String mealId) async {
    final response =
    await http.get(Uri.parse('${baseApiUrl}lookup.php?i=$mealId'));

    if (response.statusCode == 200) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MealDetailsPage(
            mealDetails: json.decode(response.body)['meals'][0],
          ),
        ),
      );
    } else {
      throw Exception('Failed to load meal details');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meals in ${widget.categoryName}'),
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
        child: meals.isEmpty
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
          itemCount: meals.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text(meals[index]['strMeal']),
              onTap: () {
                fetchMealDetails(meals[index]['idMeal']);
              },
            );
          },
        ),
      ),
    );
  }
}