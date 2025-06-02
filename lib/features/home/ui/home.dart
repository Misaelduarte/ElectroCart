import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_app/data/repositories/product_repository.dart';
import 'package:flutter_bloc_app/features/home/bloc/home_bloc.dart';
import 'package:flutter_bloc_app/features/home/ui/product_tile_widget.dart';
import 'package:flutter_bloc_app/shared/widgets/gradient_app_bar.dart';
import 'package:flutter_bloc_app/auth/bloc/auth_bloc.dart';
import 'package:flutter_bloc_app/auth/bloc/auth_event.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        return HomeBloc(repository: ProductRepository())
          ..add(HomeInitialEvent());
      },
      child: const HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      listenWhen: (_, curr) => curr is HomeActionState,
      buildWhen: (_, curr) => curr is! HomeActionState,
      listener: (ctx, state) {
        if (state is HomeProductItemWishListedActionState) {
          ScaffoldMessenger.of(ctx).showSnackBar(
            const SnackBar(
                content: Text('Produto adicionado à Lista de Desejos')),
          );
        }
      },
      builder: (ctx, state) {
        if (state is HomeLoadingState) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (state is HomeLoadedSuccessState) {
          return Scaffold(
            backgroundColor: Colors.grey.shade100,
            appBar: GradientAppBar(
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
              itemCount: state.products.length,
              itemBuilder: (context, i) {
                final p = state.products[i];
                return ProductTileWidget(
                  homeBloc: context.read<HomeBloc>(),
                  productDataModel: p,
                );
              },
            ),
          );
        }

        return const Scaffold(
          body: Center(child: Text('Erro ao carregar')),
        );
      },
    );
  }
}
