import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('SPACE FLIGHT NEWS'),
      ),
      body: ListView.builder(
        itemCount: menuItems.length,
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 10,
        ),
        itemBuilder: (context, index) {
          var item = menuItems[index];
          return _buildMenuItem(item);
        },
      ),
    );
  }

  Widget _buildMenuItem(MenuItemModel item) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ListPage(title: item.title),
          ),
        );
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: SizedBox(
                  height: 200,
                  child: SvgPicture.asset(item.img),
                ),
              ),
              const SizedBox(height: 5),
              Text(
                item.title.toUpperCase(),
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              Text(item.description),
            ],
          ),
        ),
      ),
    );
  }
}
