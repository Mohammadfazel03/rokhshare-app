import 'package:flutter/material.dart';
import 'package:rokhshare/feature/search/presentation/widgets/country_filter_section_widget/country_filter_section_widget.dart';
import 'package:rokhshare/feature/search/presentation/widgets/date_filter_section_widget/date_filter_section_widget.dart';
import 'package:rokhshare/feature/search/presentation/widgets/genre_filter_section_widget/genre_filter_section_widget.dart';
import 'package:rokhshare/feature/search/presentation/widgets/sort_by_section_widget/sort_by_section_widget.dart';
import 'package:rokhshare/feature/search/presentation/widgets/type_section_widget/type_section_widget.dart';

class FilterSectionWidget extends StatefulWidget {
  const FilterSectionWidget({super.key});

  @override
  State<FilterSectionWidget> createState() => _FilterSectionWidgetState();
}

class _FilterSectionWidgetState extends State<FilterSectionWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surfaceContainerLow,
        appBar: AppBar(
          title:
              Text("فیلترها", style: Theme.of(context).textTheme.headlineSmall),
          backgroundColor: Theme.of(context).colorScheme.surfaceContainerLow,
        ),
        body: SingleChildScrollView(
            child: Column(children: [
          TypeSectionWidget(),
          ExpansionTile(
            collapsedShape: Border.symmetric(
                horizontal: BorderSide(
                    width: 0.5,
                    color: Theme.of(context).colorScheme.outlineVariant)),
            shape: Border.symmetric(
                horizontal: BorderSide(
                    width: 0.5, color: Theme.of(context).colorScheme.primary)),
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
                    width: 0.5, color: Theme.of(context).colorScheme.primary)),
            dense: true,
            title: const Text("کشور ها"),
            maintainState: true,
            children: const [CountryFilterSectionWidget()],
          ),
          const DateFilterSectionWidget(),
          const SortBySectionWidget(),
        ])));
  }
}
