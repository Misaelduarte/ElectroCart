import 'package:flutter/material.dart';
import 'package:flutter_bloc_app/features/home/models/home_product_data_model.dart';
import 'package:flutter_bloc_app/features/wishlist/bloc/wishlist_bloc.dart';
import 'package:flutter_bloc_app/shared/widgets/product_card.dart';

class WishlistTileWidget extends StatelessWidget {
  final ProductDataModel product;
  final WishlistBloc bloc;

  const WishlistTileWidget({
    super.key,
    required this.product,
    required this.bloc,
  });

  @override
  Widget build(BuildContext context) {
    return ProductCard(
      imageUrl: product.imageUrl,
      title: product.name,
      subtitle: product.description,
      price: product.price,
      actionIcon: Icons.shopping_bag_outlined,
      onAction: () => bloc.add(
        WishlistRemoveFromWishlistEvent(productDataModel: product),
      ),
    );
  }
}
