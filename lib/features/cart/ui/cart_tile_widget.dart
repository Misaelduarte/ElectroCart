import 'package:flutter/material.dart';
import 'package:flutter_bloc_app/features/cart/bloc/cart_bloc.dart';
import 'package:flutter_bloc_app/features/home/models/home_product_data_model.dart';
import 'package:flutter_bloc_app/shared/widgets/product_card.dart';

class CartTileWidget extends StatelessWidget {
  final ProductDataModel product;
  final CartBloc bloc;

  const CartTileWidget({
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
      actionIcon: Icons.remove_shopping_cart,
      onAction: () => bloc.add(
        CartRemoveFromCartEvent(productDataModel: product),
      ),
    );
  }
}
