import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/movies.dart';

import '../../../../core/test/dummy_data/dummy_objects.dart';
import 'movie_detail_page_test.mocks.dart';
import 'movie_page_test.mocks.dart';

@GenerateMocks([
  PopularMoviesBloc,
  TopRatedMoviesBloc,
  MovieListBloc,
])
void main() {
  late MockPopularMoviesBloc mockPopularMoviesBloc;
  late MockTopRatedMoviesBloc mockTopRatedMoviesBloc;
  late MockMovieListBloc mockMovieListBloc;

  late MockMovieDetailBloc mockMovieDetailBloc;
  late MockMovieRecommendationBloc mockMovieRecommendationBloc;
  late MockMovieWatchlistBloc mockMovieWatchlistBloc;

  setUp(() {
    mockPopularMoviesBloc = MockPopularMoviesBloc();
    mockTopRatedMoviesBloc = MockTopRatedMoviesBloc();
    mockMovieListBloc = MockMovieListBloc();

    mockMovieDetailBloc = MockMovieDetailBloc();
    mockMovieRecommendationBloc = MockMovieRecommendationBloc();
    mockMovieWatchlistBloc = MockMovieWatchlistBloc();
  });

  void _arrangeUsecasePopularLoading() {
    when(mockPopularMoviesBloc.state).thenReturn(PopularMoviesLoading());
    when(mockPopularMoviesBloc.stream)
        .thenAnswer((_) => Stream.value(PopularMoviesLoading()));
  }

  void _arrangeUsecaseTopRatedLoading() {
    when(mockTopRatedMoviesBloc.state).thenReturn(TopRatedMoviesLoading());
    when(mockTopRatedMoviesBloc.stream)
        .thenAnswer((_) => Stream.value(TopRatedMoviesLoading()));
  }

  void _arrangeUsecaseListLoading() {
    when(mockMovieListBloc.state).thenReturn(MovieListLoading());
    when(mockMovieListBloc.stream)
        .thenAnswer((_) => Stream.value(MovieListLoading()));
  }

  void _arrangeUsecaseDetail() {
    when(mockMovieWatchlistBloc.state)
        .thenReturn(const MovieWatchlistHasMessage(false, null));
    when(mockMovieWatchlistBloc.stream).thenAnswer(
        (_) => Stream.value(const MovieWatchlistHasMessage(false, null)));

    when(mockMovieDetailBloc.state)
        .thenReturn(const MovieDetailHasData(testMovieDetail));
    when(mockMovieDetailBloc.stream).thenAnswer(
        (_) => Stream.value(const MovieDetailHasData(testMovieDetail)));

    when(mockMovieRecommendationBloc.state)
        .thenReturn(MovieRecommendationEmpty());
    when(mockMovieRecommendationBloc.stream)
        .thenAnswer((_) => Stream.value(MovieRecommendationEmpty()));
  }

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PopularMoviesBloc>(
          create: (context) => mockPopularMoviesBloc,
        ),
        BlocProvider<TopRatedMoviesBloc>(
          create: (context) => mockTopRatedMoviesBloc,
        ),
        BlocProvider<MovieListBloc>(
          create: (context) => mockMovieListBloc,
        ),
        BlocProvider<MovieDetailBloc>(
          create: (context) => mockMovieDetailBloc,
        ),
        BlocProvider<MovieRecommendationBloc>(
          create: (context) => mockMovieRecommendationBloc,
        ),
        BlocProvider<MovieWatchlistBloc>(
          create: (context) => mockMovieWatchlistBloc,
        ),
      ],
      child: MaterialApp(
        home: Scaffold(body: body),
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case popularMovieRoute:
              return MaterialPageRoute(
                  builder: (_) => const PopularMoviesPage());
            case topRatedMovieRoute:
              return MaterialPageRoute(
                  builder: (_) => const TopRatedMoviesPage());
            case detailMovieRoute:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
          }
          return null;
        },
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    _arrangeUsecasePopularLoading();
    _arrangeUsecaseTopRatedLoading();
    _arrangeUsecaseListLoading();

    await tester.pumpWidget(_makeTestableWidget(const MoviePage()));

    final nowPlayingTitleFinder = find.text('Now Playing');
    expect(nowPlayingTitleFinder, findsOneWidget);

    final popularTitleFinder = find.text('Popular');
    expect(popularTitleFinder, findsOneWidget);

    final topRatedTitleFinder = find.text('Top Rated');
    expect(topRatedTitleFinder, findsOneWidget);

    final progressFinder = find.byType(CircularProgressIndicator);
    expect(progressFinder, findsNWidgets(3));
  });

  testWidgets('Now Playing section should display ListView when data is loaded',
      (WidgetTester tester) async {
    _arrangeUsecasePopularLoading();
    _arrangeUsecaseTopRatedLoading();

    when(mockMovieListBloc.state).thenReturn(MovieListHasData(testMovieList));
    when(mockMovieListBloc.stream)
        .thenAnswer((_) => Stream.value(MovieListHasData(testMovieList)));

    await tester.pumpWidget(_makeTestableWidget(const MoviePage()));

    final titleFinder = find.text('Now Playing');
    expect(titleFinder, findsOneWidget);

    final listFinder = find.byType(ListView);
    expect(listFinder, findsOneWidget);
  });

  testWidgets('Popular section should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(mockPopularMoviesBloc.state)
        .thenReturn(PopularMoviesHasData(testMovieList));
    when(mockPopularMoviesBloc.stream)
        .thenAnswer((_) => Stream.value(PopularMoviesHasData(testMovieList)));

    _arrangeUsecaseTopRatedLoading();
    _arrangeUsecaseListLoading();

    await tester.pumpWidget(_makeTestableWidget(const MoviePage()));

    final subheadingFinder = find.byType(SubHeadingView);

    final subheadingTitleFinder =
        find.descendant(of: subheadingFinder, matching: find.text('Popular'));
    expect(subheadingTitleFinder, findsOneWidget);

    final subheadingButtonFinder =
        find.descendant(of: subheadingFinder, matching: find.byType(InkWell));
    expect(subheadingButtonFinder, findsWidgets);

    final listFinder = find.byType(ListView);
    expect(listFinder, findsOneWidget);

    await tester.tap(subheadingButtonFinder.at(0));
    await tester.pump();
  });

  testWidgets('Top Rated section should display ListView when data is loaded',
      (WidgetTester tester) async {
    _arrangeUsecasePopularLoading();

    when(mockTopRatedMoviesBloc.state)
        .thenReturn(TopRatedMoviesHasData(testMovieList));
    when(mockTopRatedMoviesBloc.stream)
        .thenAnswer((_) => Stream.value(TopRatedMoviesHasData(testMovieList)));

    _arrangeUsecaseListLoading();

    await tester.pumpWidget(_makeTestableWidget(const MoviePage()));

    final subheadingFinder = find.byType(SubHeadingView);

    final subheadingTitleFinder =
        find.descendant(of: subheadingFinder, matching: find.text('Top Rated'));
    expect(subheadingTitleFinder, findsOneWidget);

    final subheadingButtonFinder =
        find.descendant(of: subheadingFinder, matching: find.byType(InkWell));
    expect(subheadingButtonFinder, findsWidgets);

    final listFinder = find.byType(ListView);
    expect(listFinder, findsOneWidget);

    await tester.tap(subheadingButtonFinder.at(1));
    await tester.pump();
  });

  testWidgets('Now Playing should open Movie Detail Page when item clicked',
      (WidgetTester tester) async {
    _arrangeUsecasePopularLoading();
    _arrangeUsecaseTopRatedLoading();

    when(mockMovieListBloc.state).thenReturn(MovieListHasData(testMovieList));
    when(mockMovieListBloc.stream)
        .thenAnswer((_) => Stream.value(MovieListHasData(testMovieList)));

    _arrangeUsecaseDetail();

    await tester.pumpWidget(_makeTestableWidget(const MoviePage()));

    final listFinder = find.byType(ListView);
    expect(listFinder, findsOneWidget);

    final buttonFinder = find.descendant(
        of: listFinder, matching: find.byKey(const Key('card_item_key')));
    expect(buttonFinder, findsOneWidget);

    await tester.tap(buttonFinder);
    await tester.pump();
  });

  testWidgets('Popular should open Movie Detail Page when item clicked',
      (WidgetTester tester) async {
    when(mockPopularMoviesBloc.state)
        .thenReturn(PopularMoviesHasData(testMovieList));
    when(mockPopularMoviesBloc.stream)
        .thenAnswer((_) => Stream.value(PopularMoviesHasData(testMovieList)));

    _arrangeUsecaseTopRatedLoading();
    _arrangeUsecaseListLoading();

    _arrangeUsecaseDetail();

    await tester.pumpWidget(_makeTestableWidget(const MoviePage()));

    final listFinder = find.byType(ListView);
    expect(listFinder, findsOneWidget);

    final buttonFinder = find.descendant(
        of: listFinder, matching: find.byKey(const Key('card_item_key')));
    expect(buttonFinder, findsOneWidget);

    await tester.tap(buttonFinder);
    await tester.pump();
  });

  testWidgets('Top Rated should open Movie Detail Page when item clicked',
      (WidgetTester tester) async {
    _arrangeUsecasePopularLoading();

    when(mockTopRatedMoviesBloc.state)
        .thenReturn(TopRatedMoviesHasData(testMovieList));
    when(mockTopRatedMoviesBloc.stream)
        .thenAnswer((_) => Stream.value(TopRatedMoviesHasData(testMovieList)));

    _arrangeUsecaseListLoading();

    _arrangeUsecaseDetail();

    await tester.pumpWidget(_makeTestableWidget(const MoviePage()));

    final listFinder = find.byType(ListView);
    expect(listFinder, findsOneWidget);

    final buttonFinder = find.descendant(
        of: listFinder, matching: find.byKey(const Key('card_item_key')));
    expect(buttonFinder, findsOneWidget);

    await tester.tap(buttonFinder);
    await tester.pump();
  });
}
