import 'dart:convert';
import 'dart:math';

import 'package:data_app/domain/http_connector.dart';
import 'package:data_app/domain/product/product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';

//통신,파싱
final productHttpRepository = Provider<ProductHttpRepository>((ref) {
  return ProductHttpRepository(ref);
});

class ProductHttpRepository {
  Ref _ref;
  ProductHttpRepository(this._ref);

  Future<List<Product>> findAll() async {
    //print("1111");
    Response response = await _ref.read(httpConnector).get("/api/product");
    //print("5555");
    List<dynamic> dataList =
        jsonDecode(response.body)["data"]; //jsonDecode json=>map타입으로
    //print("2222");
    return dataList.map((e) => Product.fromJson(e)).toList();
  }

  //name, price만
  Future<Product> insert(Product productReqDto) async {
    String body = jsonEncode(productReqDto.toJson());
    Response response =
        await _ref.read(httpConnector).post("/api/product", body);
    Product product = Product.fromJson(jsonDecode(response.body)["data"]);
    return product;
  }

  Future<int> deleteById(int id) async {
    Response response =
        await _ref.read(httpConnector).delete("/api/product/${id}");
    return jsonDecode(response.body)["code"]; // 1성공
  }

  Future<Product> updateById(int id, Product productReqDto) async {
    String body = jsonEncode(productReqDto.toJson());
    print("repository id : ${id}");
    print("repository body : ${body}");
    Response response =
        await _ref.read(httpConnector).put("/api/product/${id}", body);
    print("11111111111111111111");
    print("${response.body}");
    Product product = Product.fromJson(jsonDecode(response.body)["data"]);
    print("2222222222222222222");
    return product;
  }
}
