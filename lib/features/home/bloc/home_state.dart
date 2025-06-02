part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeLoadingState extends HomeState {}

final class HomeLoadedSuccessState extends HomeState {
  final List<ProductDataModel> products;
  HomeLoadedSuccessState({
    required this.products,
  });
}

final class HomeErrorState extends HomeState {}

sealed class HomeActionState extends HomeState {}

final class HomeProductItemWishListedActionState extends HomeActionState {}
