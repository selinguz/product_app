import 'package:flutter/material.dart';
import 'package:product_app/product.dart';

import 'consts.dart';

void main() {
  runApp(const ProductPage());
}

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Products'),
          backgroundColor: appBarColor,
        ),
        body: MyProduct(),
      ),
    );
  }
}

class MyProduct extends StatefulWidget {
  const MyProduct({super.key});

  @override
  State<MyProduct> createState() => _MyProductState();
}

class _MyProductState extends State<MyProduct> {
  Future<List<Product>> productList = Product.getProducts();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: backgroundColor,
        padding: const EdgeInsets.all(8),
        child: FutureBuilder<List<Product>>(
          future: Product.getProducts(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Product> products = snapshot.data as List<Product>;
              return ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  return Card(
                    //padding: EdgeInsets.all(12.0),
                    margin: EdgeInsets.all(8),
                    color: containerColor,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 18.0, top: 18.0,
                              bottom: 18.0),
                          child: Column(
                            children: [
                              Image.network(
                                'https://placehold.co/100x100/png',
                                color: placeColor,
                              ),
                              SizedBox(height: 12.0,),
                              Container(
                                width: 100,
                                child: Text(
                                  products[index].title,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 22),softWrap: true,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 12.0,),
                        Container(
                          width: 200,
                          height: 120,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(products[index].description,textAlign:
                              TextAlign.center),
                              Text(
                                'Price: ' + products[index].price.toString(),
                                style: TextStyle(fontSize: 20),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            }
            if (snapshot.hasError) {
              return Text('error');
            }
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
