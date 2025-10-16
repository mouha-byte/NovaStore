import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/product_model.dart';

class EditProductScreen extends StatefulWidget {
  final ProductModel product;

  const EditProductScreen({super.key, required this.product});

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _subtitleController;
  late TextEditingController _descriptionController;
  late TextEditingController _priceController;
  late TextEditingController _compareAtPriceController;
  late TextEditingController _discountController;
  late TextEditingController _shippingETAController;
  late TextEditingController _returnPolicyController;
  late TextEditingController _soldCountController;

  late List<String> _images;
  late List<_VariantData> _variants;

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.product.title);
    _subtitleController = TextEditingController(text: widget.product.subtitle);
    _descriptionController = TextEditingController(text: widget.product.description);
    _priceController = TextEditingController(text: widget.product.price.toString());
    _compareAtPriceController = TextEditingController(text: widget.product.compareAtPrice.toString());
    _discountController = TextEditingController(text: widget.product.discountPercentage.toString());
    _shippingETAController = TextEditingController(text: widget.product.shippingETA);
    _returnPolicyController = TextEditingController(text: widget.product.returnPolicy);
    _soldCountController = TextEditingController(text: widget.product.soldCount.toString());

    _images = List.from(widget.product.images);
    _variants = widget.product.variants
        .map((v) => _VariantData(
              variantId: v.variantId,
              title: v.title,
              sku: v.sku,
              stock: v.stock,
              price: v.price,
            ))
        .toList();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _subtitleController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _compareAtPriceController.dispose();
    _discountController.dispose();
    _shippingETAController.dispose();
    _returnPolicyController.dispose();
    _soldCountController.dispose();
    super.dispose();
  }

  Future<void> _saveProduct() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final data = {
        'title': _titleController.text.trim(),
        'subtitle': _subtitleController.text.trim(),
        'description': _descriptionController.text.trim(),
        'price': double.parse(_priceController.text),
        'compareAtPrice': double.parse(_compareAtPriceController.text),
        'discountPercentage': int.parse(_discountController.text),
        'images': _images,
        'variants': _variants.map((v) => v.toMap()).toList(),
        'shippingETA': _shippingETAController.text.trim(),
        'returnPolicy': _returnPolicyController.text.trim(),
        'soldCount': int.parse(_soldCountController.text),
        'updatedAt': Timestamp.now(),
      };

      await FirebaseFirestore.instance
          .collection('products')
          .doc(widget.product.id)
          .update(data);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('✅ Produit mis à jour avec succès!'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pop(context, true); // Retour avec succès
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('❌ Erreur: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Modifier le produit'),
        actions: [
          if (_isLoading)
            const Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              ),
            )
          else
            IconButton(
              icon: const Icon(Icons.save),
              onPressed: _saveProduct,
              tooltip: 'Enregistrer',
            ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Informations principales
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Informations principales',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _titleController,
                      decoration: const InputDecoration(
                        labelText: 'Titre',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) =>
                          value?.isEmpty ?? true ? 'Titre requis' : null,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _subtitleController,
                      decoration: const InputDecoration(
                        labelText: 'Sous-titre',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) =>
                          value?.isEmpty ?? true ? 'Sous-titre requis' : null,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _descriptionController,
                      decoration: const InputDecoration(
                        labelText: 'Description',
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 5,
                      validator: (value) =>
                          value?.isEmpty ?? true ? 'Description requise' : null,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Prix
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Prix',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _priceController,
                            decoration: const InputDecoration(
                              labelText: 'Prix (\$)',
                              border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value?.isEmpty ?? true) return 'Prix requis';
                              if (double.tryParse(value!) == null) {
                                return 'Prix invalide';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: TextFormField(
                            controller: _compareAtPriceController,
                            decoration: const InputDecoration(
                              labelText: 'Prix comparaison (\$)',
                              border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value?.isEmpty ?? true) return 'Prix requis';
                              if (double.tryParse(value!) == null) {
                                return 'Prix invalide';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _discountController,
                      decoration: const InputDecoration(
                        labelText: 'Réduction (%)',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value?.isEmpty ?? true) return 'Réduction requise';
                        final num = int.tryParse(value!);
                        if (num == null || num < 0 || num > 100) {
                          return 'Entre 0 et 100';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Images
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Images',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () => _addImageDialog(),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    if (_images.isEmpty)
                      const Text('Aucune image', style: TextStyle(color: Colors.grey))
                    else
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _images.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: Image.network(
                              _images[index],
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(Icons.image, size: 50);
                              },
                            ),
                            title: Text(
                              _images[index],
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                setState(() => _images.removeAt(index));
                              },
                            ),
                          );
                        },
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Variantes
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Variantes',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () => _addVariantDialog(),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    if (_variants.isEmpty)
                      const Text('Aucune variante', style: TextStyle(color: Colors.grey))
                    else
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _variants.length,
                        itemBuilder: (context, index) {
                          final variant = _variants[index];
                          return Card(
                            margin: const EdgeInsets.only(bottom: 8),
                            child: ListTile(
                              title: Text(variant.title),
                              subtitle: Text(
                                'SKU: ${variant.sku} | Stock: ${variant.stock} | Prix: \$${variant.price ?? "N/A"}',
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.edit, size: 20),
                                    onPressed: () => _editVariantDialog(index),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete, color: Colors.red, size: 20),
                                    onPressed: () {
                                      setState(() => _variants.removeAt(index));
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Autres informations
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Autres informations',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _soldCountController,
                      decoration: const InputDecoration(
                        labelText: 'Nombre de ventes',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value?.isEmpty ?? true) return 'Requis';
                        if (int.tryParse(value!) == null) return 'Nombre invalide';
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _shippingETAController,
                      decoration: const InputDecoration(
                        labelText: 'Délai de livraison',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) =>
                          value?.isEmpty ?? true ? 'Délai requis' : null,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _returnPolicyController,
                      decoration: const InputDecoration(
                        labelText: 'Politique de retour',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) =>
                          value?.isEmpty ?? true ? 'Politique requise' : null,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),

            // Bouton enregistrer
            SizedBox(
              height: 50,
              child: ElevatedButton.icon(
                onPressed: _isLoading ? null : _saveProduct,
                icon: const Icon(Icons.save),
                label: const Text('Enregistrer les modifications', style: TextStyle(fontSize: 16)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  void _addImageDialog() {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Ajouter une image'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            labelText: 'URL de l\'image',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Annuler'),
          ),
          ElevatedButton(
            onPressed: () {
              if (controller.text.trim().isNotEmpty) {
                setState(() => _images.add(controller.text.trim()));
                Navigator.pop(context);
              }
            },
            child: const Text('Ajouter'),
          ),
        ],
      ),
    );
  }

  void _addVariantDialog() {
    final titleController = TextEditingController();
    final skuController = TextEditingController();
    final stockController = TextEditingController();
    final priceController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Ajouter une variante'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: 'Nom de la variante',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: skuController,
                decoration: const InputDecoration(
                  labelText: 'SKU',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: stockController,
                decoration: const InputDecoration(
                  labelText: 'Stock',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 8),
              TextField(
                controller: priceController,
                decoration: const InputDecoration(
                  labelText: 'Prix (optionnel)',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Annuler'),
          ),
          ElevatedButton(
            onPressed: () {
              if (titleController.text.trim().isNotEmpty) {
                setState(() {
                  _variants.add(_VariantData(
                    variantId: DateTime.now().millisecondsSinceEpoch.toString(),
                    title: titleController.text.trim(),
                    sku: skuController.text.trim(),
                    stock: int.tryParse(stockController.text) ?? 0,
                    price: priceController.text.isEmpty
                        ? null
                        : double.tryParse(priceController.text),
                  ));
                });
                Navigator.pop(context);
              }
            },
            child: const Text('Ajouter'),
          ),
        ],
      ),
    );
  }

  void _editVariantDialog(int index) {
    final variant = _variants[index];
    final titleController = TextEditingController(text: variant.title);
    final skuController = TextEditingController(text: variant.sku);
    final stockController = TextEditingController(text: variant.stock.toString());
    final priceController = TextEditingController(
      text: variant.price?.toString() ?? '',
    );

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Modifier la variante'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: 'Nom de la variante',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: skuController,
                decoration: const InputDecoration(
                  labelText: 'SKU',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: stockController,
                decoration: const InputDecoration(
                  labelText: 'Stock',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 8),
              TextField(
                controller: priceController,
                decoration: const InputDecoration(
                  labelText: 'Prix (optionnel)',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Annuler'),
          ),
          ElevatedButton(
            onPressed: () {
              if (titleController.text.trim().isNotEmpty) {
                setState(() {
                  _variants[index] = _VariantData(
                    variantId: variant.variantId,
                    title: titleController.text.trim(),
                    sku: skuController.text.trim(),
                    stock: int.tryParse(stockController.text) ?? 0,
                    price: priceController.text.isEmpty
                        ? null
                        : double.tryParse(priceController.text),
                  );
                });
                Navigator.pop(context);
              }
            },
            child: const Text('Enregistrer'),
          ),
        ],
      ),
    );
  }
}

class _VariantData {
  final String variantId;
  final String title;
  final String sku;
  final int stock;
  final double? price;

  _VariantData({
    required this.variantId,
    required this.title,
    required this.sku,
    required this.stock,
    this.price,
  });

  Map<String, dynamic> toMap() {
    return {
      'variantId': variantId,
      'title': title,
      'SKU': sku,
      'stock': stock,
      if (price != null) 'price': price,
    };
  }
}
