import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/movies.dart';

import '../../../../core/test/dummy_data/dummy_objects.dart';
import 'popular_movies_page_test.mocks.dart';

@GenerateMocks([PopularMoviesBloc])
void main() {
  late MockPopularMoviesBloc mockPopularMoviesBloc;

  setUp(() {
    mockPopularMoviesBloc = MockPopularMoviesBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PopularMoviesBloc>(
          create: (context) => mockPopularMoviesBloc,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(mockPopularMoviesBloc.state).thenReturn(PopularMoviesLoading());
    when(mockPopularMoviesBloc.stream)
        .thenAnswer((_) => Stream.value(PopularMoviesLoading()));

    await tester.pumpWidget(_makeTestableWidget(const PopularMoviesPage()));

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(mockPopularMoviesBloc.state)
        .thenReturn(PopularMoviesHasData(testMovieList));
    when(mockPopularMoviesBloc.stream)
        .thenAnswer((_) => Stream.value(PopularMoviesHasData(testMovieList)));

    await tester.pumpWidget(_makeTestableWidget(const PopularMoviesPage()));

    final listViewFinder = find.byType(ListView);
    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(mockPopularMoviesBloc.state)
        .thenReturn(const PopularMoviesError('Error message'));
    when(mockPopularMoviesBloc.stream).thenAnswer(
        (_) => Stream.value(const PopularMoviesError('Error message')));

    await tester.pumpWidget(_makeTestableWidget(const PopularMoviesPage()));

    final textFinder = find.byKey(const Key('error_message'));
    expect(textFinder, findsOneWidget);
  });
}
