import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShowLodingShimmer extends StatelessWidget {
  const ShowLodingShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: GridView.builder(
          shrinkWrap: true,
          itemCount: 6,
          physics: BouncingScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 2,
              childAspectRatio: 0.7),
          itemBuilder: (BuildContext context, int index) {
            return Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
            );
          },
        ),
      ),
    );
  }
}
