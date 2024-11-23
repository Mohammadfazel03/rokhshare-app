import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rokhshare/feature/search/presentation/widgets/sort_by_section_widget/bloc/sort_by_section_cubit.dart';

class SortBySectionWidget extends StatefulWidget {
  const SortBySectionWidget({super.key});

  @override
  State<SortBySectionWidget> createState() => _SortBySectionWidgetState();
}

class _SortBySectionWidgetState extends State<SortBySectionWidget> {
  @override
  void initState() {
    BlocProvider.of<SortBySectionCubit>(context).init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SortBySectionCubit, SortBySectionState>(
      builder: (context, state) {
        return ExpansionTile(
            collapsedShape: Border.symmetric(
                horizontal: BorderSide(
                    width: 0.5,
                    color: Theme.of(context).colorScheme.outlineVariant)),
            shape: Border.symmetric(
                horizontal: BorderSide(
                    width: 0.5, color: Theme.of(context).colorScheme.primary)),
            dense: false,
            title: Text("مرتب سازی",
                style: Theme.of(context).textTheme.labelLarge),
            maintainState: false,
            children: SortBy.values.map<Widget>((x) {
              return RadioListTile(
                  dense: true,
                  value: x,
                  title: Text(x.toName(),
                      style: Theme.of(context).textTheme.labelMedium),
                  groupValue: state.tempSortBy,
                  onChanged: (value) {
                    BlocProvider.of<SortBySectionCubit>(context).set(value);
                  });
            }).toList());
      },
    );
  }
}
