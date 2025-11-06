part of 'fav_cubit.dart';

abstract class FavState {}

class FavInitial extends FavState {}

///todo add fave
class AddToFavSuccess extends FavState {}
class AddToFavLoading extends FavState {}
class AddToFavError extends FavState {}

///todo remove fave
class RemoveFavSuccess extends FavState {}
class RemoveFavLoading extends FavState {}
class RemoveFavError extends FavState {}


///todo get fave
class GetVafSuccess extends FavState {}
class GetVafLoading extends FavState {}
class GetVafError extends FavState {}
