import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_app/features/cart/bloc/cart_bloc.dart';
import 'package:flutter_bloc_app/features/cart/ui/cart_tile_widget.dart';

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
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Carrinho',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: Colors.deepPurple.shade700,
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
                            cartBloc: cartBloc,
                            productDataModel:
                                cartSuccessState.cartItems[index]);
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
