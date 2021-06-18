import 'dart:convert';

import 'package:path/path.dart';
import 'package:shopping/Model/databse_model.dart';
import 'package:shopping/Model/product_model.dart';
import 'package:sqflite/sqflite.dart';

class DatabseHelper {
  DatabseHelper._();

  static final DatabseHelper db = DatabseHelper._();

  Database? _database;

  final String tbName = "ProductList";
  final String qrCode = "QRCode";
  final String option = "Option";
  final String product = "Product";

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await init();
    return _database!;
  }

  init() async {
    String path = await getDatabasesPath();
    path = join(path, 'product.db');

    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      // here my requirement is only qrcode and option for searching purpose
      // so expect qrcode and option i will store all the data in Map encoded String
      // TODO: in-case if you need any other relationship on other data please make column for that

      await db.execute(
          '''CREATE TABLE $tbName ($qrCode TEXT , $option TEXT, $product TEXT)''');
    });
  }

  Future addProductInDB(List<Product> productList) async {
    final db = await database;
    Batch batch = db.batch();

    await db.delete(tbName);
    productList.forEach((pro) {
      batch.insert(
        tbName,
        {
          qrCode: pro.qrCode,
          option: pro.option,
          product: jsonEncode(pro.toMap())
        },
      );
    });
    await batch.commit(continueOnError: true);
  }

  Future<List<Product>> getProductfromSearch(String value) async {
    final db = await database;
    List<Product> productList = [];
    List<Map<String, dynamic>> maps = await db.rawQuery(
        'SELECT * FROM $tbName WHERE $option LIKE "%$value%" OR $qrCode LIKE "%$value%"');

    if (maps.length > 0) {
      final data = DatabaseResponse().fromList(maps);

      data.forEach((element) {
        productList.add(element.product!);
      });
    }

    return productList;
  }
}
