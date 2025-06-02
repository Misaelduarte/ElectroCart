import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc_app/features/home/models/home_product_data_model.dart';

class ProductRepository {
  final _col = FirebaseFirestore.instance.collection('products');

  Future<List<ProductDataModel>> fetchAll() async {
    final snap = await _col.get();
    return snap.docs
        .map((d) => ProductDataModel.fromFirestore(d.data(), d.id))
        .toList();
  }

  Stream<List<ProductDataModel>> watchAll() {
    return _col.snapshots().map((snap) => snap.docs
        .map((d) => ProductDataModel.fromFirestore(d.data(), d.id))
        .toList());
  }

  Future<void> add(ProductDataModel p) => _col.add(p.toFirestore());

  Future<void> update(ProductDataModel p) =>
      _col.doc(p.id).set(p.toFirestore());

  Future<void> delete(String id) => _col.doc(id).delete();
}
