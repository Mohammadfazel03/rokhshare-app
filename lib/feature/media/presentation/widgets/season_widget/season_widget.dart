import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rokhshare/feature/home/data/remote/model/series.dart';
import 'package:rokhshare/feature/media/presentation/widgets/episodes_items_widget/bloc/episodes_items_cubit.dart';
import 'package:rokhshare/feature/media/presentation/widgets/season_widget/bloc/season_cubit.dart';
import 'package:rokhshare/utils/error_widget.dart';

class SeasonWidget extends StatefulWidget {
  final Season season;

  const SeasonWidget({super.key, required this.season});

  @override
  State<SeasonWidget> createState() => _SeasonWidgetState();
}

class _SeasonWidgetState extends State<SeasonWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SeasonCubit, SeasonState>(
      builder: (context, state) {
        if (state.status == SeasonStatus.loading) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: CircularProgressIndicator.adaptive(),
            ),
          );
        }
        if (state.status == SeasonStatus.error) {
          return CustomErrorWidget(
              error: state.error!,
              showIcon: false,
              showMessage: true,
              showTitle: false,
              onRetry: () {
                BlocProvider.of<SeasonCubit>(context).getSeasons();
              });
        }
        if (state.status == SeasonStatus.success) {
          return ListView.builder(
              itemCount: state.seasons.length,
              itemBuilder: (_, i) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  child: ListTile(
                    onTap: () {
                      BlocProvider.of<EpisodesItemsCubit>(context)
                          .changeSeason(state.seasons[i]);
                      Navigator.of(context).pop();
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    selectedTileColor:
                        Theme.of(context).colorScheme.primaryContainer,
                    selectedColor:
                        Theme.of(context).colorScheme.onPrimaryContainer,
                    leading: widget.season.id == state.seasons[i].id
                        ? const Icon(Icons.check)
                        : null,
                    selected: widget.season.id == state.seasons[i].id,
                    titleTextStyle: Theme.of(context).textTheme.labelLarge,
                    title: Text(
                        "فصل ${state.seasons[i].number} ${state.seasons[i].name ?? ''}"),
                  ),
                );
              });
        }
        return const SizedBox.shrink();
      },
    );
  }
}
