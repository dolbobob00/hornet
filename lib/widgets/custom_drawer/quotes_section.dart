import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../src/presentation/cubit/quotes_cubit/cubit/quotes_cubit.dart';

class QuotesSection extends StatelessWidget {
  const QuotesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuotesCubit, QuotesState>(
      builder: (context, state) {
        if (state is QuotesLoaded) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Column(
              children: [
                Text(
                  state.quote,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 13,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                Text(
                  state.authorName,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          );
        }
        if (state is QuotesError) {
          return Text(state.message);
        }
        return const Text('No quote available');
      },
    );
  }
}
