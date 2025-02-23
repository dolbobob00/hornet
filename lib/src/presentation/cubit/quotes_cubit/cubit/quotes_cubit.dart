import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import 'package:restful_solid_bloc/src/data/repositories/quotes_repo.dart';

part 'quotes_state.dart';

class QuotesCubit extends Cubit<QuotesState> {
  QuotesRepository repository = GetIt.I<QuotesRepository>();
  QuotesCubit() : super(QuotesInitial());

  void fetchQuote() async {
    try {
      final data = await repository.getRandomQuote();
      final quote = data[0]['quote'];
      final author = data[0]['author'];
      emit(
        QuotesLoaded(
          quote: quote,
          authorName: author,
        ),
      );
    } catch (e) {
      emit(
        QuotesError(
          message: e.toString(),
        ),
      );
    }
  }
}
