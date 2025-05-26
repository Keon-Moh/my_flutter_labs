import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lab 3',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Lab 3'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  const MyHomePage({super.key, required this.title});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // First row: centered text
            Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Text(
                      "Browse Categories",
                      style:
                      TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 50),
                    Text(
                      "Not sure about exactly which recipe you're looking for? Do a search, or dive into our most popular categories",
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),

            // By Meat title
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                "By Meat",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),

            // By Meat images (stacked with centered text + overlay)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                stackedCategoryImage("images/Beef.jpg", "Beef"),
                stackedCategoryImage("images/Chicken.jpg", "Chicken"),
                stackedCategoryImage("images/Pork.jpg", "Pork"),
                stackedCategoryImage("images/Seafood.jpg", "Seafood"),
              ],
            ),

            // By Course title
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Text(
                "By Course",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),

            // By Course images (image + label below)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                belowCategoryImage("images/MainDishes.jpg", "Main Dishes"),
                belowCategoryImage("images/Salad.jpg", "Salad Recipes"),
                belowCategoryImage("images/SideDishes.jpg", "Side Dishes"),
                belowCategoryImage("images/Crockpot.jpg", "Crockpot"),
              ],
            ),

            // By Dessert title
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Text(
                "By Dessert",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),

            // By Dessert images (image + label below)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                belowCategoryImage("images/IceCream.jpg", "Ice Cream"),
                belowCategoryImage("images/Brownies.jpg", "Brownies"),
                belowCategoryImage("images/Pies.jpg", "Pies"),
                belowCategoryImage("images/Cookies.jpg", "Cookies"),
              ],
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  // Image with centered text + overlay, circular
  Widget stackedCategoryImage(String imagePath, String label) {
    return SizedBox(
      width: 120,
      height: 120,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CircleAvatar(
            radius: 60,
            backgroundImage: AssetImage(imagePath),
          ),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 24,
              shadows: [
                Shadow(
                  blurRadius: 3,
                  color: Colors.black87,
                  offset: Offset(0, 0),
                ),
              ],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  // Image with label below, no overlay
  Widget belowCategoryImage(String imagePath, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(
          radius: 60,
          backgroundImage: AssetImage(imagePath),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
