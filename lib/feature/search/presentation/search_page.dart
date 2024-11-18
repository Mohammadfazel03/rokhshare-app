import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rokhshare/config/dependency_injection.dart';
import 'package:rokhshare/feature/search/presentation/widgets/country_filter_section_widget/bloc/country_filter_section_cubit.dart';
import 'package:rokhshare/feature/search/presentation/widgets/date_filter_section_widget/bloc/date_filter_section_cubit.dart';
import 'package:rokhshare/feature/search/presentation/widgets/filter_section_widget/filter_section_widget.dart';
import 'package:rokhshare/feature/search/presentation/widgets/genre_filter_section_widget/bloc/genre_filter_section_cubit.dart';
import 'package:rokhshare/feature/search/presentation/widgets/search_field_widget.dart';
import 'package:rokhshare/feature/search/presentation/widgets/sort_by_section_widget/bloc/sort_by_section_cubit.dart';
import 'package:rokhshare/feature/search/presentation/widgets/type_section_widget/bloc/type_section_cubit.dart';
import 'package:rokhshare/gen/assets.gen.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        body: Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                  child: SizedBox(
                height: 48,
                child: SearchFieldWidget(),
              )),
              const SizedBox(width: 8),
              IconButton.filledTonal(
                  style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(Theme.of(context)
                          .colorScheme
                          .surfaceContainerHighest),
                      shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)))),
                  onPressed: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (_) {
                          return MultiBlocProvider(providers: [
                            BlocProvider.value(
                                value: getIt.get<GenreFilterSectionCubit>()),
                            BlocProvider.value(
                                value: getIt.get<CountryFilterSectionCubit>()),
                            BlocProvider.value(
                                value: getIt.get<DateFilterSectionCubit>()),
                            BlocProvider.value(
                                value: getIt.get<SortBySectionCubit>()),
                            BlocProvider.value(
                                value: getIt.get<TypeSectionCubit>()),
                          ], child: const FilterSectionWidget());
                        },
                        isScrollControlled: true,
                        useSafeArea: true);
                  },
                  padding: const EdgeInsets.all(12),
                  icon: Assets.icons.filterBold.svg(
                      height: 24,
                      width: 24,
                      colorFilter: ColorFilter.mode(
                          Theme.of(context).colorScheme.onSurfaceVariant,
                          BlendMode.srcIn))),
            ],
          ),
        )
      ],
    ));
  }

  @override
  bool get wantKeepAlive => true;
}
