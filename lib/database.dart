import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'shopping_dao.dart';
import 'shopping_item.dart';

part 'database.g.dart'; // Generated code will be placed here

@Database(version: 1, entities: [ShoppingItem])
abstract class AppDatabase extends FloorDatabase {
  ShoppingDao get shoppingDao;
}