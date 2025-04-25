import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_app/features/wishlist/bloc/wishlist_bloc.dart';
import 'package:flutter_bloc_app/features/wishlist/ui/wishlist_tile_widget.dart';

class WishList extends StatefulWidget {
  const WishList({super.key});

  @override
  State<WishList> createState() => _WishListState();
}

class _WishListState extends State<WishList> {
  final WishlistBloc cartBloc = WishlistBloc();
  @override
  void initState() {
    cartBloc.add(WishlistInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Lista de desejos',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: Colors.deepPurple.shade700,
      ),
      body: BlocConsumer<WishlistBloc, WishlistState>(
        bloc: cartBloc,
        listener: (context, state) {
          if (state is WishlistProductItemRemovedActionState) {
            final productDataModel = state.productDataModel!.name;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                    'Produto $productDataModel removido da lista de desejos!'),
                duration: Duration(seconds: 2),
              ),
            );
          }
        },
        listenWhen: (previous, current) => current is WishlistActionState,
        buildWhen: (previous, current) => current is! WishlistActionState,
        builder: (context, state) {
          switch (state.runtimeType) {
            case const (WishlistSuccessState):
              final cartSuccessState = state as WishlistSuccessState;

              return cartSuccessState.wishlistItems.isNotEmpty
                  ? ListView.builder(
                      itemCount: cartSuccessState.wishlistItems.length,
                      itemBuilder: (context, index) {
                        return WishlistTileWidget(
                            wishlistBloc: cartBloc,
                            productDataModel:
                                cartSuccessState.wishlistItems[index]);
                      })
                  : Center(
                      child: Text(
                        'Lista vazia',
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
