import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<Map<String, dynamic>> cart = [];
  final nameController = TextEditingController();
  final priceController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadCart();
  }

  Future<void> loadCart() async {
    final prefs = await SharedPreferences.getInstance();
    final cartString = prefs.getString('cart');
    if (cartString != null) {
      final List decoded = json.decode(cartString);
      if (mounted) {
        setState(() {
          cart = List<Map<String, dynamic>>.from(decoded);
        });
      }
    }
  }

  Future<void> saveCart() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('cart', json.encode(cart));
  }

  void addItem() {
    final name = nameController.text.trim();
    final price = double.tryParse(priceController.text.trim());
    if (name.isNotEmpty && price != null) {
      setState(() {
        cart.add({'name': name, 'price': price});
        nameController.clear();
        priceController.clear();
      });
      saveCart();
    }
  }

  void deleteItem(int index) {
    setState(() {
      cart.removeAt(index);
    });
    saveCart();
  }

  double get totalPrice => cart.fold(0.0, (sum, item) => sum + item['price']);

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('username');
    await prefs.remove('password');

    if (!mounted) return;
    Navigator.pushReplacementNamed(context, '/');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Giỏ hàng'),
        actions: [IconButton(icon: Icon(Icons.logout), onPressed: logout)],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: nameController,
                    decoration: InputDecoration(labelText: 'Tên mặt hàng'),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: priceController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: 'Giá'),
                  ),
                ),
                IconButton(icon: Icon(Icons.add), onPressed: addItem),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: cart.length,
                itemBuilder: (context, index) {
                  final item = cart[index];
                  return ListTile(
                    title: Text(item['name']),
                    subtitle: Text('${item['price']} VNĐ'),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () => deleteItem(index),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                'Tổng cộng: ${totalPrice.toStringAsFixed(0)} VNĐ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
