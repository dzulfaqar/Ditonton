import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/tv_series.dart';

import '../../../../core/test/dummy_data/dummy_objects.dart';
import 'airing_today_tv_series_page_test.mocks.dart';

@GenerateMocks([AiringTodayTvSeriesBloc])
void main() {
  late MockAiringTodayTvSeriesBloc mockAiringTodayTvSeriesBloc;

  setUp(() {
    mockAiringTodayTvSeriesBloc = MockAiringTodayTvSeriesBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AiringTodayTvSeriesBloc>(
          create: (context) => mockAiringTodayTvSeriesBloc,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(mockAiringTodayTvSeriesBloc.state)
        .thenReturn(AiringTodayTvSeriesLoading());
    when(mockAiringTodayTvSeriesBloc.stream)
        .thenAnswer((_) => Stream.value(AiringTodayTvSeriesLoading()));

    await tester
        .pumpWidget(_makeTestableWidget(const AiringTodayTvSeriesPage()));

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(mockAiringTodayTvSeriesBloc.state)
        .thenReturn(AiringTodayTvSeriesHasData(testTvSeriesList));
    when(mockAiringTodayTvSeriesBloc.stream).thenAnswer(
        (_) => Stream.value(AiringTodayTvSeriesHasData(testTvSeriesList)));

    await tester
        .pumpWidget(_makeTestableWidget(const AiringTodayTvSeriesPage()));

    final listViewFinder = find.byType(ListView);
    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(mockAiringTodayTvSeriesBloc.state)
        .thenReturn(const AiringTodayTvSeriesError('Error message'));
    when(mockAiringTodayTvSeriesBloc.stream).thenAnswer(
        (_) => Stream.value(const AiringTodayTvSeriesError('Error message')));

    await tester
        .pumpWidget(_makeTestableWidget(const AiringTodayTvSeriesPage()));

    final textFinder = find.byKey(const Key('error_message'));
    expect(textFinder, findsOneWidget);
  });
}
