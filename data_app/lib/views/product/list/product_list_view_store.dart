import 'package:data_app/domain/product/product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/product/product_http_repository.dart';

final productListViewStore =
    StateNotifierProvider<ProductListViewStore, List<Product>>((ref) {
  return ProductListViewStore([], ref)..initViewModel();
});

class ProductListViewStore extends StateNotifier<List<Product>> {
  Ref _ref;
  ProductListViewStore(super.state, this._ref);

  void initViewModel() async {
    print("실행됨");
    state = await _ref.read(productHttpRepository).findAll();
  }

  void onRefresh(List<Product> products) {
    state = products;
  }

  void addProduct(Product productRespDto) {
    state = [...state, productRespDto];
  }

  void removeProduct(int id) {
    state = state.where((product) => product.id != id).toList();
  }

  void updateProduct(Product productRespDto) {
    state = state.map((product) {
      if (product.id == productRespDto.id) {
        return productRespDto;
      } else {
        return product;
      }
    }).toList();
  }
}
