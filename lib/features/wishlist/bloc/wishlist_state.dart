part of 'wishlist_bloc.dart';

@immutable
sealed class WishlistState {}

sealed class WishlistActionState extends WishlistState {}

final class WishlistInitial extends WishlistState {}

final class WishlistSuccessState extends WishlistState {
  final List<ProductDataModel> wishlistItems;
  WishlistSuccessState({required this.wishlistItems});
}

final class WishlistProductItemRemovedActionState extends WishlistActionState {
  final ProductDataModel? productDataModel;
  WishlistProductItemRemovedActionState({this.productDataModel});
}
