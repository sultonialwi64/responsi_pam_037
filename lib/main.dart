import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'category.dart';

const String baseApiUrl = 'https://www.themealdb.com/api/json/v1/1/';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Meal Categories',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<dynamic> categories = [];

  @override
  void initState() {
    super.initState();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    final response =
    await http.get(Uri.parse('${baseApiUrl}categories.php'));

    if (response.statusCode == 200) {
      setState(() {
        categories = json.decode(response.body)['categories'];
      });
    } else {
      throw Exception('Failed to load categories');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meal Categories'),
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
        child: categories.isEmpty
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
          itemCount: categories.length,
          itemBuilder: (BuildContext context, int index) {
            return CategoryCard(
              title: categories[index]['strCategory'],
              description: categories[index]['strCategoryDescription'],
              imageUrl: categories[index]['strCategoryThumb'],
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CategoryDetailsPage(
                      categoryName: categories[index]['strCategory'],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final String title;
  final String description;
  final String imageUrl;
  final VoidCallback onTap;

  CategoryCard({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.network(
              imageUrl,
              height: 150,
              fit: BoxFit.cover,
            ),
            ListTile(
              title: Text(title),
              subtitle: Text(description),
            ),
          ],
        ),
      ),
    );
  }
}



class MealDetailsPage extends StatelessWidget {
  final Map<String, dynamic> mealDetails;

  MealDetailsPage({required this.mealDetails});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(mealDetails['strMeal'] ?? 'Meal Details'),
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
