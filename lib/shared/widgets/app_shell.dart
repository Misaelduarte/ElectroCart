import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_app/bloc/navigation/navigation_bloc.dart';
import 'package:flutter_bloc_app/bloc/navigation/navigation_event.dart';
import 'package:flutter_bloc_app/bloc/navigation/navigation_state.dart';
import 'package:flutter_bloc_app/features/cart/ui/cart.dart';
import 'package:flutter_bloc_app/features/home/ui/home.dart';
import 'package:flutter_bloc_app/features/wishlist/ui/wishlist.dart';

class AppShell extends StatelessWidget {
  const AppShell({super.key});

  static const _pages = [
    Home(),
    WishList(),
    Cart(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationBloc, NavigationState>(
      builder: (context, state) {
        return Scaffold(
          body: IndexedStack(
            index: state.selectedIndex,
            children: _pages,
          ),
          bottomNavigationBar: SizedBox(
            // decoration: BoxDecoration(
            //   gradient: LinearGradient(
            //     colors: [
            //       Colors.deepPurple.shade700,
            //       Colors.blue.shade600,
            //     ],
            //     begin: Alignment.topLeft,
            //     end: Alignment.bottomRight,
            //   ),
            //   boxShadow: const [
            //     BoxShadow(
            //       color: Colors.black26,
            //       blurRadius: 4,
            //       offset: Offset(0, -2),
            //     ),
            //   ],
            // ),
            child: Theme(
              data: Theme.of(context).copyWith(
                splashFactory: NoSplash.splashFactory,
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
              ),
              child: BottomNavigationBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                currentIndex: state.selectedIndex,
                type: BottomNavigationBarType.fixed,
                showUnselectedLabels: true,
                selectedItemColor: Colors.black,
                unselectedItemColor: Colors.black45,
                selectedFontSize: 11,
                unselectedFontSize: 11,
                onTap: (idx) => context
                    .read<NavigationBloc>()
                    .add(NavigationItemSelected(idx)),
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home_outlined),
                    activeIcon: Icon(Icons.home),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.favorite_border),
                    activeIcon: Icon(Icons.favorite),
                    label: 'Desejos',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.shopping_bag_outlined),
                    activeIcon: Icon(Icons.shopping_bag),
                    label: 'Carrinho',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person_outline),
                    activeIcon: Icon(Icons.person),
                    label: 'Perfil',
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
