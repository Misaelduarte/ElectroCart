import 'package:flutter/material.dart';
import 'package:flutter_bloc_app/features/home/bloc/home_bloc.dart';
import 'package:flutter_bloc_app/features/home/models/home_product_data_model.dart';

class ProductTileWidget extends StatelessWidget {
  final ProductDataModel productDataModel;
  final HomeBloc homeBloc;
  const ProductTileWidget(
      {super.key, required this.productDataModel, required this.homeBloc});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 300,
            width: double.maxFinite,
            decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(productDataModel.imageUrl)),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            productDataModel.name,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(productDataModel.description,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              )),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "R\$ ${productDataModel.price.toString()}",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      homeBloc.add(HomeProductWishListButtonClickedEvent(
                          clickedProduct: productDataModel));
                    },
                    icon: Icon(Icons.favorite_border),
                    style: ButtonStyle(
                      iconColor: WidgetStateProperty.all(Colors.black),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      homeBloc.add(HomeProductCartButtonClickedEvent(
                          clickedProduct: productDataModel));
                    },
                    icon: Icon(
                      Icons.shopping_bag_outlined,
                    ),
                    style: ButtonStyle(
                      iconColor: WidgetStateProperty.all(Colors.black),
                    ),
                  )
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
