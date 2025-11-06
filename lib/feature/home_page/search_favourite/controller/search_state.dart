part of 'search_cubit.dart';

@immutable
abstract class SearchState {}

class SearchInitial extends SearchState {}

class GetSearchLoading extends SearchState {}
class GetSearchSuccess extends SearchState {}
class GetSearchError extends SearchState {}
