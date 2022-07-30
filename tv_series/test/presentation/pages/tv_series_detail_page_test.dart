import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/domain/entities/tv_series_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/tv_series.dart';

import '../../../../core/test/dummy_data/dummy_objects.dart';
import 'tv_series_detail_page_test.mocks.dart';

@GenerateMocks([
  TvSeriesDetailBloc,
  TvSeriesRecommendationBloc,
  TvSeriesWatchlistBloc,
])
void main() {
  late MockTvSeriesDetailBloc mockTvSeriesDetailBloc;
  late MockTvSeriesRecommendationBloc mockTvSeriesRecommendationBloc;
  late MockTvSeriesWatchlistBloc mockTvSeriesWatchlistBloc;

  String addedMessage = 'Added to Watchlist';
  String removedMessage = 'Removed from Watchlist';
  String failedAddingWatchlist = 'Failed to add watchlist';
  String failedRemovingWatchlist = 'Failed to remove watchlist';

  final newTestTvSeriesDetail = TvSeriesDetail(
    id: testTvSeriesDetail.id,
    name: testTvSeriesDetail.name,
    overview: testTvSeriesDetail.overview,
    posterPath: testTvSeriesDetail.posterPath,
    genres: testTvSeriesDetail.genres,
    voteAverage: testTvSeriesDetail.voteAverage,
    episodeRunTime: const [100],
    seasons: testTvSeriesDetail.seasons,
  );

  setUp(() {
    mockTvSeriesDetailBloc = MockTvSeriesDetailBloc();
    mockTvSeriesRecommendationBloc = MockTvSeriesRecommendationBloc();
    mockTvSeriesWatchlistBloc = MockTvSeriesWatchlistBloc();
  });

  void _arrangeUsecaseDetailHasData() {
    when(mockTvSeriesDetailBloc.state)
        .thenReturn(const TvSeriesDetailHasData(testTvSeriesDetail));
    when(mockTvSeriesDetailBloc.stream).thenAnswer(
        (_) => Stream.value(const TvSeriesDetailHasData(testTvSeriesDetail)));
  }

  void _arrangeUsecaseRecommendationEmpty() {
    when(mockTvSeriesRecommendationBloc.state)
        .thenReturn(TvSeriesRecommendationEmpty());
    when(mockTvSeriesRecommendationBloc.stream)
        .thenAnswer((_) => Stream.value(TvSeriesRecommendationEmpty()));
  }

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TvSeriesDetailBloc>(
          create: (context) => mockTvSeriesDetailBloc,
        ),
        BlocProvider<TvSeriesRecommendationBloc>(
          create: (context) => mockTvSeriesRecommendationBloc,
        ),
        BlocProvider<TvSeriesWatchlistBloc>(
          create: (context) => mockTvSeriesWatchlistBloc,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
      'Page should display TV Series Detail when data load successfully',
      (WidgetTester tester) async {
    when(mockTvSeriesDetailBloc.state)
        .thenReturn(TvSeriesDetailHasData(newTestTvSeriesDetail));
    when(mockTvSeriesDetailBloc.stream).thenAnswer(
        (_) => Stream.value(TvSeriesDetailHasData(newTestTvSeriesDetail)));

    _arrangeUsecaseRecommendationEmpty();

    when(mockTvSeriesWatchlistBloc.state)
        .thenReturn(const TvSeriesWatchlistHasMessage(false, null));
    when(mockTvSeriesWatchlistBloc.stream).thenAnswer(
        (_) => Stream.value(const TvSeriesWatchlistHasMessage(false, null)));

    await tester
        .pumpWidget(_makeTestableWidget(const TvSeriesDetailPage(id: 1)));

    final imageFinder = find.byType(CachedNetworkImage);
    expect(imageFinder, findsNWidgets(2)); // Poster and Season
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(mockTvSeriesDetailBloc.state)
        .thenReturn(const TvSeriesDetailError('Error message'));
    when(mockTvSeriesDetailBloc.stream).thenAnswer(
        (_) => Stream.value(const TvSeriesDetailError('Error message')));

    _arrangeUsecaseRecommendationEmpty();

    when(mockTvSeriesWatchlistBloc.state)
        .thenReturn(const TvSeriesWatchlistHasMessage(false, null));
    when(mockTvSeriesWatchlistBloc.stream).thenAnswer(
        (_) => Stream.value(const TvSeriesWatchlistHasMessage(false, null)));

    await tester
        .pumpWidget(_makeTestableWidget(const TvSeriesDetailPage(id: 1)));

    final textFinder = find.byKey(const Key('error_message'));
    expect(textFinder, findsOneWidget);
  });

  testWidgets('Watchlist button should display with disabled when first time',
      (WidgetTester tester) async {
    _arrangeUsecaseDetailHasData();
    _arrangeUsecaseRecommendationEmpty();

    when(mockTvSeriesWatchlistBloc.state).thenReturn(TvSeriesWatchlistEmpty());
    when(mockTvSeriesWatchlistBloc.stream)
        .thenAnswer((_) => Stream.value(TvSeriesWatchlistEmpty()));

    await tester
        .pumpWidget(_makeTestableWidget(const TvSeriesDetailPage(id: 1)));

    final watchlistButtonFinder = find.byType(ElevatedButton);
    expect(watchlistButtonFinder, findsOneWidget);

    ElevatedButton watchlistButton = tester.widget(watchlistButtonFinder);
    expect(watchlistButton.onPressed, null);
  });

  testWidgets(
      'Watchlist button should display add icon when tv series not added to watchlist',
      (WidgetTester tester) async {
    _arrangeUsecaseDetailHasData();
    _arrangeUsecaseRecommendationEmpty();

    when(mockTvSeriesWatchlistBloc.state)
        .thenReturn(const TvSeriesWatchlistHasMessage(false, null));
    when(mockTvSeriesWatchlistBloc.stream).thenAnswer(
        (_) => Stream.value(const TvSeriesWatchlistHasMessage(false, null)));

    await tester
        .pumpWidget(_makeTestableWidget(const TvSeriesDetailPage(id: 1)));

    final watchlistButtonIcon = find.byIcon(Icons.add);
    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should dispay check icon when tv series is added to wathclist',
      (WidgetTester tester) async {
    _arrangeUsecaseDetailHasData();
    _arrangeUsecaseRecommendationEmpty();

    when(mockTvSeriesWatchlistBloc.state)
        .thenReturn(const TvSeriesWatchlistHasMessage(true, null));
    when(mockTvSeriesWatchlistBloc.stream).thenAnswer(
        (_) => Stream.value(const TvSeriesWatchlistHasMessage(true, null)));

    await tester
        .pumpWidget(_makeTestableWidget(const TvSeriesDetailPage(id: 1)));

    final watchlistButtonIcon = find.byIcon(Icons.check);
    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display Snackbar when added to watchlist',
      (WidgetTester tester) async {
    _arrangeUsecaseDetailHasData();
    _arrangeUsecaseRecommendationEmpty();

    when(mockTvSeriesWatchlistBloc.state)
        .thenReturn(TvSeriesWatchlistHasMessage(false, addedMessage));
    when(mockTvSeriesWatchlistBloc.stream).thenAnswer(
        (_) => Stream.value(TvSeriesWatchlistHasMessage(false, addedMessage)));

    await tester
        .pumpWidget(_makeTestableWidget(const TvSeriesDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    final watchlistButton = find.byType(ElevatedButton);
    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text(addedMessage), findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display Snackbar when removed from watchlist',
      (WidgetTester tester) async {
    _arrangeUsecaseDetailHasData();
    _arrangeUsecaseRecommendationEmpty();

    when(mockTvSeriesWatchlistBloc.state)
        .thenReturn(TvSeriesWatchlistHasMessage(true, removedMessage));
    when(mockTvSeriesWatchlistBloc.stream).thenAnswer(
        (_) => Stream.value(TvSeriesWatchlistHasMessage(true, removedMessage)));

    await tester
        .pumpWidget(_makeTestableWidget(const TvSeriesDetailPage(id: 1)));

    expect(find.byIcon(Icons.check), findsOneWidget);

    final watchlistButton = find.byType(ElevatedButton);
    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text(removedMessage), findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display AlertDialog when add to watchlist failed',
      (WidgetTester tester) async {
    _arrangeUsecaseDetailHasData();
    _arrangeUsecaseRecommendationEmpty();

    when(mockTvSeriesWatchlistBloc.state)
        .thenReturn(TvSeriesWatchlistHasMessage(false, failedAddingWatchlist));
    when(mockTvSeriesWatchlistBloc.stream).thenAnswer((_) => Stream.value(
        TvSeriesWatchlistHasMessage(false, failedAddingWatchlist)));

    await tester
        .pumpWidget(_makeTestableWidget(const TvSeriesDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    final watchlistButton = find.byType(ElevatedButton);
    await tester.tap(watchlistButton, warnIfMissed: false);
    await tester.pump();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text(failedAddingWatchlist), findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display AlertDialog when remove from watchlist failed',
      (WidgetTester tester) async {
    _arrangeUsecaseDetailHasData();
    _arrangeUsecaseRecommendationEmpty();

    when(mockTvSeriesWatchlistBloc.state).thenReturn(
        TvSeriesWatchlistHasMessage(false, failedRemovingWatchlist));
    when(mockTvSeriesWatchlistBloc.stream).thenAnswer((_) => Stream.value(
        TvSeriesWatchlistHasMessage(false, failedRemovingWatchlist)));

    await tester
        .pumpWidget(_makeTestableWidget(const TvSeriesDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    final watchlistButton = find.byType(ElevatedButton);
    await tester.tap(watchlistButton, warnIfMissed: false);
    await tester.pump();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text(failedRemovingWatchlist), findsOneWidget);
  });

  testWidgets('Recommendation should display text with message when Error',
      (WidgetTester tester) async {
    _arrangeUsecaseDetailHasData();

    when(mockTvSeriesRecommendationBloc.state)
        .thenReturn(const TvSeriesRecommendationError('Error message'));
    when(mockTvSeriesRecommendationBloc.stream).thenAnswer((_) =>
        Stream.value(const TvSeriesRecommendationError('Error message')));

    when(mockTvSeriesWatchlistBloc.state)
        .thenReturn(const TvSeriesWatchlistHasMessage(true, null));
    when(mockTvSeriesWatchlistBloc.stream).thenAnswer(
        (_) => Stream.value(const TvSeriesWatchlistHasMessage(true, null)));

    await tester
        .pumpWidget(_makeTestableWidget(const TvSeriesDetailPage(id: 1)));

    final textFinder =
        find.byKey(const Key('error_message'), skipOffstage: false);
    expect(textFinder, findsOneWidget);
  });

  testWidgets('Recommendation should display ListView when data is loaded',
      (WidgetTester tester) async {
    _arrangeUsecaseDetailHasData();

    when(mockTvSeriesRecommendationBloc.state)
        .thenReturn(TvSeriesRecommendationHasData(testTvSeriesList));
    when(mockTvSeriesRecommendationBloc.stream).thenAnswer(
        (_) => Stream.value(TvSeriesRecommendationHasData(testTvSeriesList)));

    when(mockTvSeriesWatchlistBloc.state)
        .thenReturn(const TvSeriesWatchlistHasMessage(true, null));
    when(mockTvSeriesWatchlistBloc.stream).thenAnswer(
        (_) => Stream.value(const TvSeriesWatchlistHasMessage(true, null)));

    await tester
        .pumpWidget(_makeTestableWidget(const TvSeriesDetailPage(id: 1)));

    final listViewFinder = find.byType(ListView, skipOffstage: false);
    expect(listViewFinder, findsOneWidget);
  });
}
