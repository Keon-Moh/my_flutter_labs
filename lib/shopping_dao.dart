import 'package:floor/floor.dart';
import 'shopping_item.dart';

@dao
abstract class ShoppingDao {
  @Query('SELECT * FROM ShoppingItem')
  Future<List<ShoppingItem>> findAllShoppingItems();

  @Query('SELECT * FROM ShoppingItem')
  Stream<List<ShoppingItem>> findAllShoppingItemsAsStream(); // Add this

  @insert
  Future<void> insertShoppingItem(ShoppingItem shoppingItem);

  @delete
  Future<void> deleteShoppingItem(ShoppingItem shoppingItem);
}