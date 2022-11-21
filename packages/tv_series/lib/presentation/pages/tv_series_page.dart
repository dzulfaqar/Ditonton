import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/tv_series.dart';

class TvSeriesPage extends StatefulWidget {
  const TvSeriesPage({Key? key}) : super(key: key);

  @override
  State<TvSeriesPage> createState() => _TvSeriesPageState();
}

class _TvSeriesPageState extends State<TvSeriesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context
          .read<AiringTodayTvSeriesBloc>()
          .add(const OnFetchingAiringToday());
      context.read<PopularTvSeriesBloc>().add(const OnFetchingPopular());
      context.read<TopRatedTvSeriesBloc>().add(const OnFetchingTopRated());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SubHeadingView(
              title: 'Airing Today',
              onTap: () =>
                  Navigator.pushNamed(context, airingTodayTvSeriesRoute),
            ),
            BlocBuilder<AiringTodayTvSeriesBloc, AiringTodayTvSeriesState>(
                builder: (context, state) {
              if (state is AiringTodayTvSeriesLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is AiringTodayTvSeriesHasData) {
                return TvSeriesList(tvSeriesList: state.result);
              } else {
                return const Text('Failed');
              }
            }),
            SubHeadingView(
              title: 'Popular',
              onTap: () => Navigator.pushNamed(context, popularTvSeriesRoute),
            ),
            BlocBuilder<PopularTvSeriesBloc, PopularTvSeriesState>(
                builder: (context, state) {
              if (state is PopularTvSeriesLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is PopularTvSeriesHasData) {
                return TvSeriesList(tvSeriesList: state.result);
              } else {
                return const Text('Failed');
              }
            }),
            SubHeadingView(
              title: 'Top Rated',
              onTap: () => Navigator.pushNamed(context, topRatedTvSeriesRoute),
            ),
            BlocBuilder<TopRatedTvSeriesBloc, TopRatedTvSeriesState>(
                builder: (context, state) {
              if (state is TopRatedTvSeriesLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is TopRatedTvSeriesHasData) {
                return TvSeriesList(tvSeriesList: state.result);
              } else {
                return const Text('Failed');
              }
            }),
          ],
        ),
      ),
    );
  }
}

class TvSeriesList extends StatelessWidget {
  final List<TvSeries> tvSeriesList;

  const TvSeriesList({
    Key? key,
    required this.tvSeriesList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final tvSeries = tvSeriesList[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              key: const Key('card_item_key'),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  detailTvSeriesRoute,
                  arguments: tvSeries.id,
                );
              },
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$baseImageUrl${tvSeries.posterPath}',
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: tvSeriesList.length,
      ),
    );
  }
}
