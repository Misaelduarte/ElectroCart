part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

final class HomeInitialEvent extends HomeEvent {}

final class HomeProductWishListButtonClickedEvent extends HomeEvent {
  final ProductDataModel clickedProduct;
  HomeProductWishListButtonClickedEvent({
    required this.clickedProduct,
  });
}
