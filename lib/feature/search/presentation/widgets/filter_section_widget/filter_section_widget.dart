import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rokhshare/feature/home/data/remote/model/country.dart';
import 'package:rokhshare/feature/home/data/remote/model/genre.dart';
import 'package:rokhshare/feature/search/presentation/bloc/search_cubit.dart';
import 'package:rokhshare/feature/search/presentation/widgets/country_filter_section_widget/bloc/country_filter_section_cubit.dart';
import 'package:rokhshare/feature/search/presentation/widgets/country_filter_section_widget/country_filter_section_widget.dart';
import 'package:rokhshare/feature/search/presentation/widgets/date_filter_section_widget/bloc/date_filter_section_cubit.dart';
import 'package:rokhshare/feature/search/presentation/widgets/date_filter_section_widget/date_filter_section_widget.dart';
import 'package:rokhshare/feature/search/presentation/widgets/genre_filter_section_widget/bloc/genre_filter_section_cubit.dart';
import 'package:rokhshare/feature/search/presentation/widgets/genre_filter_section_widget/genre_filter_section_widget.dart';
import 'package:rokhshare/feature/search/presentation/widgets/sort_by_section_widget/bloc/sort_by_section_cubit.dart';
import 'package:rokhshare/feature/search/presentation/widgets/sort_by_section_widget/sort_by_section_widget.dart';
import 'package:rokhshare/feature/search/presentation/widgets/type_section_widget/bloc/type_section_cubit.dart';
import 'package:rokhshare/feature/search/presentation/widgets/type_section_widget/type_section_widget.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class FilterSectionWidget extends StatefulWidget {
  const FilterSectionWidget({super.key});

  @override
  State<FilterSectionWidget> createState() => _FilterSectionWidgetState();
}

class _FilterSectionWidgetState extends State<FilterSectionWidget> {
  final DateRangePickerController dateRangePickerController =
      DateRangePickerController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surfaceContainerLow,
        appBar: AppBar(
          title:
              Text("فیلترها", style: Theme.of(context).textTheme.headlineSmall),
          backgroundColor: Theme.of(context).colorScheme.surfaceContainerLow,
          actions: [
            Builder(builder: (context) {
              final genreState = BlocProvider.of<GenreFilterSectionCubit>(
                      context,
                      listen: true)
                  .state;
              final typeState =
                  BlocProvider.of<TypeSectionCubit>(context, listen: true)
                      .state;
              final countryState = BlocProvider.of<CountryFilterSectionCubit>(
                      context,
                      listen: true)
                  .state;
              final dateState =
                  BlocProvider.of<DateFilterSectionCubit>(context, listen: true)
                      .state;
              final sortState =
                  BlocProvider.of<SortBySectionCubit>(context, listen: true)
                      .state;
              bool enable = genreState.tempSelected.isNotEmpty ||
                  typeState.tempSelectedItem.length != 2 ||
                  countryState.tempSelected.isNotEmpty ||
                  dateState.tempRange != null ||
                  sortState.tempSortBy != SortBy.titleASC;
              return TextButton(
                onPressed: enable
                    ? () {
                        BlocProvider.of<GenreFilterSectionCubit>(context)
                            .clearAllSelectedItem();
                        BlocProvider.of<TypeSectionCubit>(context).clear();
                        BlocProvider.of<CountryFilterSectionCubit>(context)
                            .clearAllSelectedItem();
                        BlocProvider.of<DateFilterSectionCubit>(context)
                            .clear();
                        BlocProvider.of<SortBySectionCubit>(context).clear();
                        dateRangePickerController.selectedRange = null;
                      }
                    : null,
                style: ButtonStyle(
                  foregroundColor: WidgetStateProperty.resolveWith((state) {
                    if (state.contains(WidgetState.disabled)) {
                      return Theme.of(context).disabledColor;
                    } else {
                      return Theme.of(context).colorScheme.primary;
                    }
                  }),
                  textStyle: WidgetStatePropertyAll(
                      Theme.of(context).textTheme.labelMedium),
                ),
                child: const Text("حذف فیلتر"),
              );
            })
          ],
        ),
        body: SingleChildScrollView(
            child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
              const TypeSectionWidget(),
              ExpansionTile(
                collapsedShape: Border.symmetric(
                    horizontal: BorderSide(
                        width: 0.5,
                        color: Theme.of(context).colorScheme.outlineVariant)),
                shape: Border.symmetric(
                    horizontal: BorderSide(
                        width: 0.5,
                        color: Theme.of(context).colorScheme.primary)),
                dense: true,
                title: const Text("ژانر ها"),
                maintainState: true,
                children: const [GenreFilterSectionWidget()],
              ),
              ExpansionTile(
                collapsedShape: Border.symmetric(
                    horizontal: BorderSide(
                        width: 0.5,
                        color: Theme.of(context).colorScheme.outlineVariant)),
                shape: Border.symmetric(
                    horizontal: BorderSide(
                        width: 0.5,
                        color: Theme.of(context).colorScheme.primary)),
                dense: true,
                title: const Text("کشور ها"),
                maintainState: true,
                children: const [CountryFilterSectionWidget()],
              ),
              DateFilterSectionWidget(
                  dateRangePickerController: dateRangePickerController),
              const SortBySectionWidget(),
              Builder(builder: (context) {
                final genreState = BlocProvider.of<GenreFilterSectionCubit>(
                        context,
                        listen: true)
                    .state;
                final typeState =
                    BlocProvider.of<TypeSectionCubit>(context, listen: true)
                        .state;
                final countryState = BlocProvider.of<CountryFilterSectionCubit>(
                        context,
                        listen: true)
                    .state;
                final dateState = BlocProvider.of<DateFilterSectionCubit>(
                        context,
                        listen: true)
                    .state;
                final sortState =
                    BlocProvider.of<SortBySectionCubit>(context, listen: true)
                        .state;
                bool enable = !genreState.isNewFilter() ||
                    !typeState.isNewFilter() ||
                    !countryState.isNewFilter() ||
                    !dateState.isNewFilter() ||
                    !sortState.isNewFilter();
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  child: FilledButton(
                    onPressed: enable
                        ? () {
                            SearchFilter filter = SearchFilter(
                                query: null,
                                type: typeState.tempSelectedItem.length == 2
                                    ? 'both'
                                    : typeState.tempSelectedItem.first
                                        .toServerName(),
                                genres: genreState.tempSelected
                                    .map<int>((Genre x) => x.id ?? -1)
                                    .toList(),
                                countries: countryState.tempSelected
                                    .map<int>((Country x) => x.id ?? -1)
                                    .toList(),
                                range: dateState.tempRange,
                                sortBy: sortState.tempSortBy?.toServerName() ??
                                    "-name");
                            Navigator.of(context).pop(filter);

                            BlocProvider.of<GenreFilterSectionCubit>(context)
                                .finalizeSelectedItem();
                            BlocProvider.of<CountryFilterSectionCubit>(context)
                                .finalizeSelectedItem();
                            BlocProvider.of<DateFilterSectionCubit>(context)
                                .finalize();
                            BlocProvider.of<SortBySectionCubit>(context)
                                .finalize();
                            BlocProvider.of<TypeSectionCubit>(context)
                                .finalize();
                          }
                        : null,
                    style: ButtonStyle(
                        shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)))),
                    child: const Text("اعمال فیلتر"),
                  ),
                );
              })
            ])));
  }
}
