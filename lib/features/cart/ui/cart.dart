import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_app/features/cart/bloc/cart_bloc.dart';
import 'package:flutter_bloc_app/features/cart/ui/cart_tile_widget.dart';
import 'package:flutter_bloc_app/shared/widgets/gradient_app_bar.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  final CartBloc cartBloc = CartBloc();
  @override
  void initState() {
    cartBloc.add(CartInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () => Navigator.pop(context),
        ),
        title: 'Carrinho',
        actions: const [],
      ),
      body: BlocConsumer<CartBloc, CartState>(
        bloc: cartBloc,
        listener: (context, state) {
          if (state is CartProductItemRemovedActionState) {
            final productDataModel = state.productDataModel!.name;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content:
                    Text('Produto $productDataModel removido do carrinho!'),
                duration: Duration(seconds: 2),
              ),
            );
          }
        },
        listenWhen: (previous, current) => current is CartActionState,
        buildWhen: (previous, current) => current is! CartActionState,
        builder: (context, state) {
          switch (state.runtimeType) {
            case const (CartSuccessState):
              final cartSuccessState = state as CartSuccessState;

              return cartSuccessState.cartItems.isNotEmpty
                  ? ListView.builder(
                      itemCount: cartSuccessState.cartItems.length,
                      itemBuilder: (context, index) {
                        return CartTileWidget(
                            bloc: cartBloc,
                            product: cartSuccessState.cartItems[index]);
                      })
                  : Center(
                      child: Text(
                        'Carrinho vazio',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey.shade500,
                        ),
                      ),
                    );
            default:
              return const SizedBox();
          }
        },
      ),
    );
  }
}
