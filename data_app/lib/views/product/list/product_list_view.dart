import 'package:data_app/views/product/list/components/my_alert_dialog.dart';
import 'package:data_app/views/product/list/product_list_view_store.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../controller/product_controller.dart';
import '../../../domain/product/product.dart';

class ProductListView extends ConsumerWidget {
  const ProductListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print("나 그러짐");
    final pm = ref.watch(productListViewStore);
    final pc = ref.read(productController);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          pc.insert(Product(id: 0, name: '호박', price: 6000));
        },
      ),
      appBar: AppBar(title: Text("product_list_page")),
      body: _buildListView(pm, pc),
    );
  }

  Widget _buildListView(List<Product> pm, ProductController pc) {
    if (!(pm.length > 0)) {
      return Center(
        child: Image.asset(
          "assets/image/loading.gif",
        ),
      );
    } else {
      return ListView.builder(
        itemCount: pm.length,
        itemBuilder: (context, index) => ListTile(
          key: ValueKey(pm[index].id),
          onTap: () {
            pc.deleteById(pm[index].id);
          },
          onLongPress: () {
            pc.updateById(pm[index].id, Product(id: 0, name: '감', price: 999));
          },
          leading: Icon(Icons.account_balance_wallet),
          title: Text(
            "${pm[index].name}",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text("${pm[index].price}"),
        ),
      );
    }
  }
}
