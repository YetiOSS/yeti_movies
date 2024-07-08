import 'package:flutter/material.dart';
import 'package:yeti_movies/discovery/data/data.dart';

import 'widgets.dart';

class MovieCard extends StatefulWidget {
  final MovieEntity movie;

  const MovieCard({super.key, required this.movie});

  @override
  State<MovieCard> createState() => _MovieCardState();
}

class _MovieCardState extends State<MovieCard> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: () {
        setState(() => isExpanded = !isExpanded);
      },
      child: Card(
        margin: const EdgeInsets.all(8.0),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: TmdbImageNetworkWidget(
                  movie.posterPath,
                  height: 450.0,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 10.0),
              Text(
                movie.title,
                style: theme.textTheme.titleLarge?.copyWith(
                  color: theme.colorScheme.surfaceTint,
                ),
              ),
              AnimatedCrossFade(
                firstChild: Container(),
                secondChild: Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Visibility(
                    maintainState: true,
                    maintainAnimation: true,
                    visible: isExpanded,
                    child: Text(
                      movie.overview,
                      style: theme.textTheme.bodyMedium,
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ),
                crossFadeState: isExpanded
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
                duration: const Duration(milliseconds: 500),
                sizeCurve: Curves.easeInOut,
              ),
            ],
          ),
        ),
      ),
    );
  }

  MovieEntity get movie => widget.movie;
}
