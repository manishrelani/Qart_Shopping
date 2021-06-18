import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shopping/Constant/path.dart';
import 'package:shopping/Model/product_model.dart';
import 'package:shopping/Screen/ProductScreen.dart';

class ProductDetails extends StatelessWidget {
  final Product? product;
  const ProductDetails({Key? key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return GestureDetector(
            child: Card(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              elevation: 5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [_imageView(constraints), _allDetails(constraints)],
              ),
            ),
            onTap: () {
              FocusScope.of(context).unfocus();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (ctx) => ProductScreen(
                    product: product,
                  ),
                ),
              );
            });
      },
    );
  }

  Widget _imageView(BoxConstraints constraints) {
    return Container(
      height: constraints.maxHeight * 0.6,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
      child: CachedNetworkImage(
        fit: BoxFit.fill,
        imageUrl: kImageUrl + product!.image!,

        // show shimmer effect until the image load
        placeholder: (_, __) => Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Container(
            height: constraints.maxHeight * 0.6,
            width: constraints.maxWidth,
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
                height: constraints.maxHeight * 0.5,
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
    );
  }

  Widget _allDetails(BoxConstraints constraints) {
    // show details about product like title, qrcode, rating, price etc..
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _productTitle(),
            _qrCode(),
            _priceTagAndRating(constraints)
          ],
        ),
      ),
    );
  }

  Widget _productTitle() {
    return Text(
      product!.color!,
      maxLines: 2,
      softWrap: true,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 17,
      ),
    );
  }

  Widget _qrCode() {
    return FittedBox(
      child: Text(
        "OP: ${product!.option}",
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: Colors.grey,
          fontWeight: FontWeight.bold,
          fontSize: 15,
        ),
      ),
    );
  }

  Widget _priceTagAndRating(BoxConstraints constraints) {
    return Row(
      children: [
        Expanded(
          child: Text(
            "₹ ${product!.mrp}",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 17,
            ),
          ),
        ),
        Icon(
          Icons.star_rate_rounded,
          color: Colors.purple,
          size: 20,
        ),
        Text(
          product!.likeablty!.toString(),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        )
      ],
    );
  }
}
