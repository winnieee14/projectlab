import 'package:flutter/material.dart';
import 'package:projectlab/models/product.dart';
import 'package:projectlab/helper/api.dart';

class ProductScreen extends StatelessWidget {
  final Product product;

  const ProductScreen({Key? key, required this.product}) : super(key: key);

  Future<void> _deleteProduct(BuildContext context) async {
    try {
      await deleteProduct(product.id);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Produk berhasil dihapus'),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pop(context, true);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Gagal menghapus produk: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
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
                        product.title,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Image.network(
                product.imageUrl,
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
                      product.title,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Rp ${product.price.toStringAsFixed(0)}',
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.red,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      product.description,
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Genre: ${product.genre}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Level: ${product.level}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: ElevatedButton(
                        onPressed: () => _deleteProduct(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          minimumSize: const Size(100, 50),
                        ),
                        child: const Text(
                          'Hapus Produk',
                          style: TextStyle(fontSize: 18, color: Colors.white),
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
