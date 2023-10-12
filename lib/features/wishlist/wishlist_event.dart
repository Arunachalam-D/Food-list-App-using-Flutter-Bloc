part of 'wishlist_bloc.dart';

@immutable
abstract class WishlistEvent {}

class WishlistInitialEvent extends WishlistEvent{}

class WishlistRemovedEvent extends WishlistEvent{
  final ProductDataModel productDataModel;

  WishlistRemovedEvent({required this.productDataModel});

}
