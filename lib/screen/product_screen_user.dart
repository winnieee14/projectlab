//product_screen_user.dart

import 'package:flutter/material.dart';
import 'package:projectlab/models/product.dart';
import 'package:projectlab/helper/api.dart';

class ProductScreenUser extends StatefulWidget {
  final Product product;

  const ProductScreenUser({Key? key, required this.product}) : super(key: key);

  @override
  _ProductScreenUserState createState() => _ProductScreenUserState();
}

class _ProductScreenUserState extends State<ProductScreenUser> {
  int _quantity = 1;

  void _buyProduct() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Berhasil membeli ${_quantity}x ${widget.product.title}',
        ),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    Expanded(
                      child: Text(
                        widget.product.title,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Image.network(
                widget.product.imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
                height: 300,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    'assets/image/notfound.png',
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 300,
                  );
                },
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.product.title,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Rp ${widget.product.price.toStringAsFixed(0)}',
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.red,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.product.description,
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Genre: ${widget.product.genre}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Level: ${widget.product.level}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        const Text(
                          "Jumlah: ",
                          style: TextStyle(fontSize: 18),
                        ),
                        IconButton(
                          icon: const Icon(Icons.remove),
                          onPressed: () {
                            setState(() {
                              if (_quantity > 1) _quantity--;
                            });
                          },
                        ),
                        Text(
                          _quantity.toString(),
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () {
                            setState(() {
                              _quantity++;
                            });
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: ElevatedButton(
                        onPressed: _buyProduct,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          minimumSize: const Size(100, 50),
                        ),
                        child: const Text(
                          'Buy',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
