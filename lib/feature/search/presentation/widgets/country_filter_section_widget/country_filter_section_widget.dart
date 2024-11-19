import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rokhshare/feature/search/presentation/widgets/country_filter_section_widget/bloc/country_filter_section_cubit.dart';
import 'package:rokhshare/feature/search/presentation/widgets/search_field_widget.dart';
import 'package:rokhshare/utils/error_widget.dart';

class CountryFilterSectionWidget extends StatefulWidget {
  final bool readOnly;

  const CountryFilterSectionWidget({super.key, this.readOnly = false});

  @override
  State<CountryFilterSectionWidget> createState() =>
      _CountryFilterSectionWidgetState();
}

class _CountryFilterSectionWidgetState
    extends State<CountryFilterSectionWidget> {
  late final TextEditingController searchController;

  @override
  void initState() {
    BlocProvider.of<CountryFilterSectionCubit>(context).initialSelectedItem();
    searchController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CountryFilterSectionCubit, CountryFilterSectionState>(
      buildWhen: (p, c) {
        return p.status != c.status;
      },
      builder: (context, countryState) {
        if (countryState.status == CountryFilterSectionStatus.loading) {
          return const Center(
              child: Padding(
            padding: EdgeInsets.all(16),
            child: CircularProgressIndicator.adaptive(),
          ));
        } else if (countryState.status == CountryFilterSectionStatus.success) {
          return Column(
            children: [
              if ((countryState.data?.length ?? 0) > 1) ...[
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: SearchFieldWidget(
                    controller: searchController,
                    isDense: true,
                    hintText: "جستجو کشور",
                    showSearchIcon: false,
                    showClearIcon: true,
                    hintStyle: Theme.of(context).textTheme.bodyMedium,
                    suffixIconConstraints:
                        const BoxConstraints(maxHeight: 32, maxWidth: 32),
                    onChange: (text) {
                      BlocProvider.of<CountryFilterSectionCubit>(context)
                          .searchData(text);
                    },
                  ),
                )
              ],
              BlocBuilder<CountryFilterSectionCubit, CountryFilterSectionState>(
                  buildWhen: (p, c) {
                return p.filteredData != c.filteredData ||
                    c.tempSelected.length != p.tempSelected.length;
              }, builder: (context, state) {
                return SizedBox(
                  height: ((state.filteredData?.length ?? 0) > 5)
                      ? 240
                      : (state.filteredData?.length ?? 0) * 48,
                  child: ListView.builder(
                    itemCount: state.filteredData?.length ?? 0,
                    itemExtent: 48,
                    itemBuilder: (context, index) {
                      return CheckboxListTile(
                        key: Key(state.filteredData![index].name ??
                            state.filteredData![index].hashCode.toString()),
                        value: state.tempSelected
                            .contains(state.filteredData![index]),
                        onChanged: (value) {
                          if (value == true) {
                            BlocProvider.of<CountryFilterSectionCubit>(context)
                                .selectItem(state.filteredData![index]);
                          } else if (value == false) {
                            BlocProvider.of<CountryFilterSectionCubit>(context)
                                .removeItem(state.filteredData![index]);
                          }
                        },
                        title: Text(state.filteredData![index].name ?? ""),
                        controlAffinity: ListTileControlAffinity.leading,
                        dense: true,
                      );
                    },
                  ),
                );
              })
            ],
          );
        } else {
          return CustomErrorWidget(
              error: countryState.error!,
              onRetry: () {
                BlocProvider.of<CountryFilterSectionCubit>(context).getData();
              });
        }
      },
    );
  }
}
