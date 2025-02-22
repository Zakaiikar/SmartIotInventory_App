import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductList extends StatefulWidget {
  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Fetch products and categories from Firestore
  Stream<QuerySnapshot> _fetchProducts() {
    return _firestore.collection('products').snapshots();
  }

  // Fetch categories from Firestore for mapping product category names
  Future<Map<String, String>> _fetchCategories() async {
    final categoriesSnapshot = await _firestore.collection('categories').get();
    return Map.fromIterable(
      categoriesSnapshot.docs,
      key: (doc) => doc.id,
      value: (doc) => doc['name'] ?? 'Unnamed',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product List'),
      ),
      body: FutureBuilder<Map<String, String>>(
        future: _fetchCategories(),
        builder: (context, categorySnapshot) {
          if (categorySnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (categorySnapshot.hasError) {
            return Center(child: Text('Error fetching categories: ${categorySnapshot.error}'));
          }

          return StreamBuilder<QuerySnapshot>(
            stream: _fetchProducts(),
            builder: (context, productSnapshot) {
              if (productSnapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (productSnapshot.hasError) {
                return Center(child: Text('Error fetching products: ${productSnapshot.error}'));
              }
              if (!productSnapshot.hasData || productSnapshot.data!.docs.isEmpty) {
                return Center(child: Text('No products found'));
              }

              final products = productSnapshot.data!.docs;

              // Group products by category
              Map<String, List<Map<String, dynamic>>> groupedProducts = {};
              for (var product in products) {
                final categoryId = product['CategoryId'];
                if (!groupedProducts.containsKey(categoryId)) {
                  groupedProducts[categoryId] = [];
                }
                groupedProducts[categoryId]!.add(product.data() as Map<String, dynamic>);
              }

              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Two columns
                  childAspectRatio: 1, // Adjust aspect ratio as needed
                ),
                itemCount: groupedProducts.keys.length,
                itemBuilder: (context, index) {
                  final categoryId = groupedProducts.keys.elementAt(index);
                  final categoryName = categorySnapshot.data![categoryId] ?? 'Unknown Category';
                  
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            categoryName,
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 10),
                          Expanded(
                            child: ListView.builder(
                              itemCount: groupedProducts[categoryId]!.length,
                              itemBuilder: (context, subIndex) {
                                final product = groupedProducts[categoryId]![subIndex];
                                return ListTile(
                                  title: Text(product['Name']),
                                  subtitle: Text('Quantity: ${product['Quantity']}'),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}