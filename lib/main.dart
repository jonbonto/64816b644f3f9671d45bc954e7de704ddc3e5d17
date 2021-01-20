import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:kulinary/models/models.dart';
import 'package:kulinary/services/services.dart';
import 'package:kulinary/shared/shared.dart';
import 'package:kulinary/ui/widgets/widgets.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kulinary',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kulinary"),
      ),
      body: Center(
        child: FutureBuilder<List<Product>>(
            future: ProductServices.getProducts(1),
            builder: (_, snapshot) {
              if (!snapshot.hasData)
                return SizedBox(
                  height: 50,
                  width: 50,
                  child: SpinKitFadingCircle(
                    color: accentColor3,
                  ),
                );
              var products = snapshot.data;
              final itemWidth =
                  (MediaQuery.of(context).size.width - 2.5 * defaultMargin) / 2;
              final itemHeight = 305;
              return GridView.count(
                crossAxisCount: 2,
                padding: EdgeInsets.all(defaultMargin),
                childAspectRatio: (itemWidth / itemHeight),
                crossAxisSpacing: 0.5 * defaultMargin,
                mainAxisSpacing: 1.5 * defaultMargin,
                children: List.generate(products.length, (index) {
                  return ProductCard(
                    width: itemWidth,
                    product: products[index],
                  );
                }),
              );
            }),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
