import 'package:flutter/material.dart';
import 'database.dart';
import 'shopping_item.dart';
import 'list_page.dart'; // New file for ListPage
import 'details_page.dart'; // New file for DetailsPage

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final database = await $FloorAppDatabase.databaseBuilder('shopping_database.db').build();
  runApp(MyApp(database: database));
}

class MyApp extends StatelessWidget {
  final AppDatabase database;
  const MyApp({super.key, required this.database});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shopping List',
      home: MainPage(database: database),
    );
  }
}

class MainPage extends StatefulWidget {
  final AppDatabase database;
  const MainPage({super.key, required this.database});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  ShoppingItem? selectedItem; // Nullable selected item

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;

    Widget reactiveLayout() {
      if ((width > height) && (width > 720)) {
        // Landscape mode (tablet/desktop)
        return Row(
          children: [
            Expanded(
              flex: 1, // List takes 1/3 of width
              child: ListPage(
                database: widget.database,
                onItemSelected: (item) => setState(() => selectedItem = item),
              ),
            ),
            Expanded(
              flex: 2, // Details takes 2/3 of width
              child: DetailsPage(
                selectedItem: selectedItem,
                onDelete: (item) async {
                  await widget.database.shoppingDao.deleteShoppingItem(item);
                  setState(() => selectedItem = null);
                },
                onClose: () => setState(() => selectedItem = null),
              ),
            ),
          ],
        );
      } else {
        // Portrait mode (phone)
        return selectedItem == null
            ? ListPage(
          database: widget.database,
          onItemSelected: (item) => setState(() => selectedItem = item),
        )
            : DetailsPage(
          selectedItem: selectedItem,
          onDelete: (item) async {
            await widget.database.shoppingDao.deleteShoppingItem(item);
            setState(() => selectedItem = null);
          },
          onClose: () => setState(() => selectedItem = null),
        );
      }
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Shopping List')),
      body: reactiveLayout(),
    );
  }
}