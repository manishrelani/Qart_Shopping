import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shopping/Constant/path.dart';
import 'package:shopping/Model/product_model.dart';
import 'package:shopping/Widget/product.dart';

class ProductScreen extends StatelessWidget {
  final Product? product;
  const ProductScreen({Key? key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbar(context),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              _imageView(context),
              _productDetail(),
              _size(),
              _description(),
              _referance(context),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _appbar(context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
          color: Colors.black,
        ),
        onPressed: () => Navigator.pop(context),
      ),
      title: Text(
        "Qart",
        style: Theme.of(context).textTheme.headline5,
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusDirectional.circular(20)),
              color: Colors.deepPurple,
              child: Text(
                "Add To Cart",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {}),
        )
      ],
    );
  }

  Widget _title(String value) {
    return Text(
      value,
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    );
  }

  Widget _card({@required Widget? child}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: child,
        ),
      ),
    );
  }

  Widget _textField({@required String? type, @required String? value}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        readOnly: true,
        style: TextStyle(
          fontSize: 18,
        ),
        initialValue: value,
        decoration: InputDecoration(
            labelText: type,
            labelStyle: TextStyle(fontSize: 18),
            border: OutlineInputBorder()),
      ),
    );
  }

  Widget _imageView(BuildContext context) {
    return _card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.55,
            width: double.maxFinite,
            child: CachedNetworkImage(
              fit: BoxFit.fill,
              imageUrl: kImageUrl + product!.image!,

              // show shimmer effect until the image load
              placeholder: (_, __) => Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.55,
                  width: double.maxFinite,
                  color: Colors.white,
                ),
              ),

              // animate when ulr change
              useOldImageOnUrlChange: true,

              // disply error when no image found
              errorWidget: (_, __, ___) => Center(
                child: Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.45,
                      child: Image.asset(
                        kNoImageFound,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Text("No image found")
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text(
              product!.color ?? "",
              style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text(
              "₹ ${product!.mrp ?? ""}",
              textScaleFactor: 1.2,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Badge(
              toAnimate: false,
              shape: BadgeShape.square,
              badgeColor: Colors.deepPurple,
              borderRadius: BorderRadius.circular(10),
              badgeContent: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text((product!.likeablty ?? "").toString(),
                      style: TextStyle(color: Colors.white, fontSize: 16)),
                  SizedBox(
                    width: 5,
                  ),
                  Icon(
                    Icons.star,
                    size: 20,
                    color: Colors.white,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _productDetail() {
    return _card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _title("Product Details"),
          SizedBox(
            height: 10,
          ),
          _textField(
              type: "Brand - Category - Collection",
              value:
                  "${product!.brand ?? ""} - ${product!.category ?? ""} - ${product!.collection ?? ""}"),
          _textField(
              type: "Gender - Name - SubCategory",
              value:
                  "${product!.gender ?? ""} - ${product!.name ?? ""} - ${product!.subCategory ?? ""}"),
          _textField(
              type: "Fit - Theme - Finish",
              value:
                  "${product!.fit ?? ""} - ${product!.theme ?? ""} - ${product!.finish ?? ""}"),
          _textField(
              type: "OFF_MONTH - Mo_od",
              value: "${product!.offerMonth ?? ""} - ${product!.mood ?? ""}"),
        ],
      ),
    );
  }

  Widget _sizeBox(String value) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2),
          border: Border.all(color: Colors.black)),
      child: Text(
        value,
        style: TextStyle(fontSize: 16),
      ),
    );
  }

  Widget _size() {
    return _card(
        child: Container(
      width: double.maxFinite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _title("Size"),
          SizedBox(
            height: 10,
          ),
          Wrap(
              children:
                  product!.availableSize!.map((e) => _sizeBox(e)).toList())
        ],
      ),
    ));
  }

  Widget _description() {
    return _card(
        child: Container(
      width: double.maxFinite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _title("Discription"),
          SizedBox(
            height: 10,
          ),
          Text(
            product!.description ?? "",
            style: TextStyle(fontSize: 16),
          )
        ],
      ),
    ));
  }

  Widget _referance(context) {
    return _card(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _title("You may Also Like This"),
        SizedBox(
          height: 10,
        ),
        Container(
          height: 300,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: 30,
            physics: BouncingScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return Container(
                width: 200,
                padding: EdgeInsets.all(2),
                child: ProductDetails(
                  product: product,
                ),
              );
            },
          ),
        )
      ],
    ));
  }
}
