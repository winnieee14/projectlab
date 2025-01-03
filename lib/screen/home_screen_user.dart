//home_screen_user.dart

import 'package:flutter/material.dart';
import 'package:projectlab/helper/api.dart';
import 'package:projectlab/helper/auth_service.dart';
import 'package:projectlab/models/product.dart';
import 'product_screen_user.dart';

class HomeScreenUser extends StatefulWidget {
  const HomeScreenUser({Key? key}) : super(key: key);

  @override
  _HomeScreenUserState createState() => _HomeScreenUserState();
}

class _HomeScreenUserState extends State<HomeScreenUser> {
  List<Product> products = [];
  String username = '';

  @override
  void initState() {
    super.initState();
    fetchProducts();
    setUsername();
  }

  void setUsername() {
    setState(() {
      username = AuthService.loggedUser?.username ?? 'User';
    });
  }

  Future<void> fetchProducts() async {
    try {
      final fetchedProducts = await getProducts();
      setState(() {
        products = fetchedProducts;
      });
    } catch (e) {
      print('Gagal memuat produk: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Image.asset(
              'assets/image/snelogo.png',
              width: 100,
              height: 150,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text(
              'Welcome, $username',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Colors.black54,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 16.0),
            child: Text(
              'Daftar Produk',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: RefreshIndicator(
              onRefresh: fetchProducts,
              child: products.isEmpty
                  ? const Center(child: CircularProgressIndicator())
                  : GridView.builder(
                      padding: const EdgeInsets.all(8.0),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 8.0,
                        crossAxisSpacing: 8.0,
                        childAspectRatio: 0.7,
                      ),
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        final product = products[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ProductScreenUser(product: product),
                              ),
                            );
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            elevation: 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.vertical(
                                        top: Radius.circular(12.0)),
                                    child: product.imageUrl != null &&
                                            product.imageUrl.isNotEmpty
                                        ? Image.network(
                                            product.imageUrl,
                                            fit: BoxFit.cover,
                                            width: double.infinity,
                                            errorBuilder:
                                                (context, error, stackTrace) {
                                              return Image.asset(
                                                'assets/image/notfound.png',
                                                fit: BoxFit.cover,
                                              );
                                            },
                                          )
                                        : Image.asset(
                                            'assets/image/notfound.png',
                                            fit: BoxFit.cover,
                                          ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        product.title,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        'Rp ${product.price.toStringAsFixed(0)}',
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
