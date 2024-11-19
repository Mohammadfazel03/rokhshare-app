import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rokhshare/feature/search/presentation/widgets/date_filter_section_widget/bloc/date_filter_section_cubit.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class DateFilterSectionWidget extends StatefulWidget {
  final DateRangePickerController dateRangePickerController;

  const DateFilterSectionWidget(
      {super.key, required this.dateRangePickerController});

  @override
  State<DateFilterSectionWidget> createState() =>
      _DateFilterSectionWidgetState();
}

class _DateFilterSectionWidgetState extends State<DateFilterSectionWidget> {
  get dateRangePickerController => widget.dateRangePickerController;

  @override
  void initState() {
    BlocProvider.of<DateFilterSectionCubit>(context).init();
    var state = BlocProvider.of<DateFilterSectionCubit>(context).state;
    dateRangePickerController.selectedRange = state.tempRange;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DateFilterSectionCubit, DateFilterSectionState>(
      buildWhen: (p, c) {
        return p.tempRange != c.tempRange;
      },
      builder: (context, state) {
        return ListTile(
          shape: Border.symmetric(
              horizontal: BorderSide(
                  width: 0.5,
                  color: Theme.of(context).colorScheme.outlineVariant)),
          dense: true,
          title: Row(
            children: [
              const Text("سال ساخت"),
              if (state.tempRange != null) ...[
                const SizedBox(width: 8),
                DecoratedBox(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Theme.of(context).colorScheme.primary),
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: Text(
                      "${state.tempRange!.startDate!.year} - ${state.tempRange!.endDate!.year}",
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          fontSize: 9,
                          color: Theme.of(context).colorScheme.onPrimary),
                    ),
                  ),
                )
              ]
            ],
          ),
          onTap: () async {
            showModalBottomSheet(
                context: context,
                builder: (_) {
                  return BlocProvider.value(
                      value: BlocProvider.of<DateFilterSectionCubit>(context),
                      child: bottomSheet());
                });
          },
        );
      },
    );
  }

  Widget bottomSheet() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SfDateRangePicker(
              controller: dateRangePickerController,
              backgroundColor:
                  Theme.of(context).colorScheme.surfaceContainerLow,
              view: DateRangePickerView.decade,
              selectionMode: DateRangePickerSelectionMode.range,
              allowViewNavigation: false,
              navigationDirection: DateRangePickerNavigationDirection.vertical,
              navigationMode: DateRangePickerNavigationMode.scroll,
              selectionShape: DateRangePickerSelectionShape.circle,
              maxDate: DateTime.now(),
              minDate: DateTime(1900),
              headerStyle: DateRangePickerHeaderStyle(
                textAlign: TextAlign.center,
                backgroundColor:
                    Theme.of(context).colorScheme.surfaceContainerLow,
              ),
              selectionRadius: 8,
              yearCellStyle: DateRangePickerYearCellStyle(
                textStyle: Theme.of(context).textTheme.labelMedium,
              ),
              extendableRangeSelectionDirection:
                  ExtendableRangeSelectionDirection.none,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BlocBuilder<DateFilterSectionCubit, DateFilterSectionState>(
                builder: (context, state) {
                  return Expanded(
                      child: OutlinedButton(
                          onPressed: state.tempRange != null
                              ? () {
                                  Navigator.of(context).pop();
                                  BlocProvider.of<DateFilterSectionCubit>(
                                          context)
                                      .clear();
                                  widget.dateRangePickerController.selectedRange = null;
                                }
                              : null,
                          child: const Text("حذف فیلتر")));
                },
              ),
              const SizedBox(width: 16),
              Expanded(
                  child: FilledButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        BlocProvider.of<DateFilterSectionCubit>(context)
                            .setDateRange(
                                dateRangePickerController.selectedRange);
                      },
                      child: const Text("تایید"))),
            ],
          )
        ],
      ),
    );
  }
}
