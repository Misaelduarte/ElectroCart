import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc_app/data/repositories/product_repository.dart';
import 'package:flutter_bloc_app/features/home/models/home_product_data_model.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final ProductRepository repository;

  HomeBloc({required this.repository}) : super(HomeInitial()) {
    on<HomeInitialEvent>(homeInitialEvent);
    on<HomeProductWishListButtonClickedEvent>(_onWishListClicked);
  }

  Future<void> homeInitialEvent(
    HomeInitialEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoadingState());
    try {
      final products = await repository.fetchAll();
      emit(HomeLoadedSuccessState(products: products));
    } catch (_) {
      emit(HomeErrorState());
    }
  }

  void _onWishListClicked(
    HomeProductWishListButtonClickedEvent event,
    Emitter<HomeState> emit,
  ) {
    emit(HomeProductItemWishListedActionState());
  }
}
