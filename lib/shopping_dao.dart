import 'package:floor/floor.dart';
import 'shopping_item.dart';

@dao
abstract class ShoppingDao {
  @Query('SELECT * FROM ShoppingItem')
  Future<List<ShoppingItem>> findAllShoppingItems();

  @insert
  Future<void> insertShoppingItem(ShoppingItem shoppingItem);

  @delete
  Future<void> deleteShoppingItem(ShoppingItem shoppingItem);
}