part of 'quotes_cubit.dart';

@immutable
sealed class QuotesState {}

final class QuotesInitial extends QuotesState {}

final class QuotesLoaded extends QuotesState {
  final String quote;
  final String authorName;
  QuotesLoaded({required this.quote, required this.authorName});
}

final class QuotesError extends QuotesState {
  final String message;
  QuotesError({required this.message});
}
