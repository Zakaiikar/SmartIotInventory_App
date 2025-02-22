import 'package:flutter/material.dart';
import 'package:smartinventory/pages/ProductList.dart';
import 'package:smartinventory/pages/category.dart';
import 'package:smartinventory/pages/product.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard"),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Notifications Clicked!')),
              );
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text(
                'Menu',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: Icon(Icons.add),
              title: Text('Add Category'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Category()));
              },
            ),
            ListTile(
              leading: Icon(Icons.add_box),
              title: Text('Add Products'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Product()));
              },
            ),
            ListTile(
              leading: Icon(Icons.view_list),
              title: Text('Product List'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ProductList()));
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Welcome to Our Dashboard",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue),
            ),
            SizedBox(height: 20),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                children: [
                  _buildIconTile(
                    context,
                    Icons.category,
                    'Manage Categories',
                    () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Category()));
                    },
                  ),
                  _buildIconTile(
                    context,
                    Icons.production_quantity_limits,
                    'Manage Products',
                    () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Product()));
                    },
                  ),
                  _buildIconTile(
                    context,
                    Icons.list,
                    'View Products',
                    () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ProductList()));
                    },
                  ),
                  _buildIconTile(
                    context,
                    Icons.notifications,
                    'Notifications',
                    () {
                      // Handle notifications
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIconTile(BuildContext context, IconData icon, String title, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blue[50],
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 60, color: Colors.blue),
            SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}