class Product {
  String _name; // underscore indicates the variable is private
  String _description;
  double _price;

  Product(this._name, this._description, this._price);

  String get name => _name; // using getters for retrieval
  String get description => _description;
  double get price => _price;

  set name(String name) => _name = name; // using setters for assignment of new value
  set description(String description) => _description = description;
  set price(double price) => _price = price;

  @override
  String toString() {
    return 'Product{name: $_name, description: $_description, price: $_price}';
  }
}

class ProductManager {
  List<Product> _products = [];

  void addProduct(Product product) {
    _products.add(product);
    print('Product added: ${product.name}');
  }

  void viewAllProducts() {
    if (_products.isEmpty) {
      print("No products found");
      return;
    }
    for (var product in _products) {
      print(product.toString());
    }
  }

  void viewSingleProduct(int index) {
    if (index < 0 || index >= _products.length) {
      print("No product found at index $index");
      return;
    }
    print(_products[index].toString());
  }

  void editProduct(int index, String name, String description, double price) {
    if (index < 0 || index >= _products.length) {
      print('Product not found.');
      return;
    }
    _products[index].name = name;
    _products[index].description = description;
    _products[index].price = price;
    print('Product updated: ${_products[index].name}');
  }

  void deleteProduct(int index) {
    if (index < 0 || index >= _products.length) {
      print('Product not found.');
      return;
    }
    print('Product deleted: ${_products[index].name}');
    _products.removeAt(index);
  }
}

void main() {
  var productManager = ProductManager();

  // Sample interaction
  productManager.addProduct(Product('Laptop', 'High performance laptop', 999.99));
  productManager.addProduct(Product('Smartphone', 'Latest model smartphone', 699.99));

  print('\nAll products:');
  productManager.viewAllProducts();

  productManager.editProduct(1, 'Smartphone', 'Updated smartphone description', 649.99);

  print('\nViewing product at index 1:');
  productManager.viewSingleProduct(1);

  productManager.deleteProduct(0);

  print('\nAll products after deletion:');
  productManager.viewAllProducts();
}