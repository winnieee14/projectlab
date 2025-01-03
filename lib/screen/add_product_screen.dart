import 'package:flutter/material.dart';
import 'package:projectlab/helper/api.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({Key? key}) : super(key: key);

  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _formKey = GlobalKey<FormState>();

  final _titleController = TextEditingController();
  final _priceController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _genreController = TextEditingController();
  final _levelController = TextEditingController();
  final _imageUrlController = TextEditingController();

  Future<void> _addProduct() async {
    if (_formKey.currentState!.validate()) {
      final title = _titleController.text;
      final price = double.tryParse(_priceController.text) ?? 0.0;
      final description = _descriptionController.text;
      final genre = _genreController.text;
      final level = _levelController.text;
      final imageUrl = _imageUrlController.text;

      bool success = await addProduct(
        title: title,
        price: price,
        description: description,
        genre: genre,
        level: level,
        imageUrl: imageUrl,
      );

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Produk berhasil ditambahkan'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Gagal menambahkan produk'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Tambah Product Baru',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset(
                  'assets/image/snelogo.png',
                  width: 100,
                  height: 95,
                ),
              ),
              const SizedBox(height: 16),
              _buildStyledTextField('Nama Produk', _titleController),
              const SizedBox(height: 16),
              _buildStyledTextField('Harga', _priceController,
                  keyboardType: TextInputType.number),
              const SizedBox(height: 16),
              _buildStyledTextField('Deskripsi', _descriptionController,
                  maxLines: 3),
              const SizedBox(height: 16),
              _buildStyledTextField('Genre', _genreController),
              const SizedBox(height: 16),
              _buildStyledTextField('Level', _levelController),
              const SizedBox(height: 16),
              _buildStyledTextField('URL Gambar', _imageUrlController),
              const SizedBox(height: 32),
              Center(
                child: ElevatedButton(
                  onPressed: _addProduct,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    minimumSize: const Size(150, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Tambah Produk',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStyledTextField(String label, TextEditingController controller,
      {TextInputType keyboardType = TextInputType.text, int maxLines = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: 'Masukkan ${label.toLowerCase()} Anda',
            filled: true,
            fillColor: Colors.grey.shade200,
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(10),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return '$label tidak boleh kosong';
            }
            return null;
          },
        ),
      ],
    );
  }
}
