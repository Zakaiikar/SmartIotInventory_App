import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard"),
        actions: [
          // Notification Icon
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              // Handle notification icon press
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
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.add),
              title: Text('Add Item'),
              onTap: () {
                // Navigate to Add Item page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddItemPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.view_list),
              title: Text('View Products'),
              onTap: () {
                // Navigate to View Products page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProductsPage()),
                );
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Text("Welcome To Our Dashboard"),
      ),
    );
  }
}

// Dummy pages for navigation
class AddItemPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Item")),
      body: Center(child: Text("Add Item Form")),
    );
  }
}

class ProductsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Products")),
      body: Center(child: Text("List of Products")),
    );
  }
}