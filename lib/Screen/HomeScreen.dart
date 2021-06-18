import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shopping/Bloc/product/product_bloc.dart';
import 'package:shopping/Constant/path.dart';
import 'package:shopping/Widget/product.dart';
import 'package:shopping/Widget/shimmer_effect.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ProductBloc? _productBloc = ProductBloc();

  @override
  void initState() {
    _productBloc!..add(FetchProduct());
    super.initState();
  }

  @override
  void dispose() {
    _productBloc!.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        _productBloc!..add(FetchProduct());
      },
      child: Scaffold(
        appBar: _appBar(),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [_searchField(), _listofProduct()],
          ),
        ),
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      centerTitle: true,
      title: Text(
        "Product",
        style: Theme.of(context).textTheme.headline5,
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      leading: IconButton(
        onPressed: () {},
        icon: Icon(
          Icons.menu,
          size: 25,
          color: Colors.black,
        ),
      ),
      actions: [
        Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: Badge(
              position: BadgePosition.topEnd(top: 12, end: -1),
              child: Icon(
                Icons.shopping_cart_outlined,
                color: Colors.black,
                size: 25,
              ),
            ))
      ],
    );
  }

  Widget _searchField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Card(
        elevation: 5,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          height: 56,
          alignment: Alignment.centerLeft,
          child: TextField(
            style: TextStyle(
              fontSize: 18,
            ),
            decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.search,
                  size: 25,
                ),
                border: InputBorder.none,
                hintText: "Search"),
            onChanged: (value) {
              _productBloc!..add(SearchProduct(value));
            },
          ),
        ),
      ),
    );
  }

  Widget _listofProduct() {
    return BlocBuilder<ProductBloc, ProductState>(
      bloc: _productBloc,
      builder: (context, state) {
        if (state is ProductLoding) {
          return ShowLodingShimmer();
        }
        if (state is ProductLoded) {
          if (state.productList.isEmpty) {
            return _noDataFound();
          }
          return CustomeGridView(
            state: state,
          );
        }
        if (state is ProductError) {
          return _onError();
        }
        return Container();
      },
    );
  }

  Widget _onError() {
    return Flexible(
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.4,
              child: Image.asset(kNoImageFound),
            ),
            Text(
              "Please Try Again",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            MaterialButton(
                color: Colors.deepPurple,
                onPressed: () {
                  _productBloc!..add(FetchProduct());
                },
                child: Text(
                  "Retry",
                  style: TextStyle(color: Colors.white),
                ))
          ],
        ),
      ),
    );
  }

  Widget _noDataFound() {
    return Flexible(
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.4,
              child: Image.asset(kNoImageFound),
            ),
            Text(
              "No Product Found",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomeGridView extends StatelessWidget {
  final ProductLoded? state;

  const CustomeGridView({Key? key, @required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: StaggeredGridView.countBuilder(
        staggeredTileBuilder: (index) {
          return StaggeredTile.count(1, index == 0 ? 2 : 1.6);
        },
        physics: BouncingScrollPhysics(),
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        itemCount: state!.productList.length,
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return _showWithResult(index);
          }
          return ProductDetails(
            product: state!.productList[index],
          );
        },
      ),
    );
  }

  Widget _showWithResult(int index) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Found ${state!.productList.length} Results",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
          ),
        ),
        Flexible(
          child: ProductDetails(
            product: state!.productList[index],
          ),
        )
      ],
    );
  }
}
