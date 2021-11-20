import 'package:cloud_firestore/cloud_firestore.dart';
import 'order.dart';

class OrderDao {
  // 1
  final CollectionReference collection =
      FirebaseFirestore.instance.collection('orders');

  void saveMessage(Order order) {
    collection.add(order.toJson());
  }

  Stream<QuerySnapshot> getOrderStream() {
    return collection.snapshots();
  }
}
