/*import 'package:flutter/material.dart';

//import 'package:purchases_flutter/object_wrappers.dart';
class Package {
  Product product;
  Package(this.product);
}

class Product {
  String? title;
  String? description;
  String? priceString;
  Product(this.title, this.description, this.priceString);
}

class PaywallWidget extends StatefulWidget {
  String title = "";
  String description = "";
  List<Package> packages;
  ValueChanged<Package> onClickedPackage;

  PaywallWidget(
      {required this.title,
      required this.description,
      required this.packages,
      required this.onClickedPackage});

  @override
  _PaywallWidgetState createState() => _PaywallWidgetState();
}

class _PaywallWidgetState extends State<PaywallWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        title: Text(
          "Activate Subscriptions",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.75,
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Text(widget.title,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              SizedBox(
                height: 16,
              ),
              Text(
                widget.description,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(
                height: 16,
              ),
              buildPackages(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildPackages() => ListView.builder(
      shrinkWrap: true,
      primary: false,
      itemCount: widget.packages.length,
      itemBuilder: (context, index) {
        final package = widget.packages[index];
        return buildPackage(context, package);
      });

  Widget buildPackage(BuildContext context, Package package) {
    final product = package.product;
    return Card(
      color: Theme.of(context).accentColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Theme(
        data: ThemeData.light(),
        child: ListTile(
          contentPadding: EdgeInsets.all(8),
          title: Text(
            product.title!,
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.yellow),
          ),
          subtitle: Text(
            product.description!,
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
          trailing: Text(
            product.priceString!,
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          onTap: () => widget.onClickedPackage(package),
        ),
      ),
    );
  }
}*/
