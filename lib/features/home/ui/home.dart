import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_app/auth/bloc/auth_bloc.dart';
import 'package:flutter_bloc_app/auth/bloc/auth_event.dart';
import 'package:flutter_bloc_app/features/cart/ui/cart.dart';
import 'package:flutter_bloc_app/features/home/bloc/home_bloc.dart';
import 'package:flutter_bloc_app/features/home/ui/product_tile_widget.dart';
import 'package:flutter_bloc_app/features/wishlist/ui/wishlist.dart';
import 'package:flutter_bloc_app/shared/widgets/gradient_app_bar.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    homeBloc.add(HomeInitialEvent());
    super.initState();
  }

  final HomeBloc homeBloc = HomeBloc();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
      listenWhen: (previous, current) => current is HomeActionState,
      buildWhen: (previous, current) => current is! HomeActionState,
      listener: (context, state) {
        if (state is HomeNavigateToCartPageActionState) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Cart()));
        } else if (state is HomeNavigateToWishListPageActionState) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => WishList()));
        } else if (state is HomeProductItemWishListedActionState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Produto adicionado a Lista de Desejos'),
              duration: Duration(seconds: 2),
            ),
          );
        } else if (state is HomeProductItemCartActionState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Produto adicionado ao carrinho'),
              duration: Duration(seconds: 2),
            ),
          );
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case const (HomeLoadingState):
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          case const (HomeLoadedSuccessState):
            final homeLoadedSuccessState = state as HomeLoadedSuccessState;
            return Scaffold(
              backgroundColor: Colors.grey.shade100,
              appBar: GradientAppBar(
                leading: IconButton(
                  icon: const Icon(Icons.shopping_bag_outlined),
                  color: Colors.white,
                  onPressed: () {
                    homeBloc.add(HomeCartButtonNavigateEvent());
                  },
                ),
                title: 'Shopiverse',
                actions: [
                  IconButton(
                    icon: const Icon(Icons.logout),
                    color: Colors.white,
                    onPressed: () {
                      context.read<AuthBloc>().add(AuthSignOutRequested());
                    },
                  ),
                ],
              ),
              body: ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  itemCount: homeLoadedSuccessState.products.length,
                  itemBuilder: (context, index) {
                    return ProductTileWidget(
                        homeBloc: homeBloc,
                        productDataModel:
                            homeLoadedSuccessState.products[index]);
                  }),
            );
          case const (HomeErrorState):
            return const Scaffold(
              body: Center(
                child: Text('Error'),
              ),
            );
          default:
            return SizedBox();
        }
      },
    );
  }
}
