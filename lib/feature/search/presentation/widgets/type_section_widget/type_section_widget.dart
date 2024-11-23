import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rokhshare/feature/search/presentation/widgets/type_section_widget/bloc/type_section_cubit.dart';

class TypeSectionWidget extends StatefulWidget {
  const TypeSectionWidget({super.key});

  @override
  State<TypeSectionWidget> createState() => _TypeSectionWidgetState();
}

class _TypeSectionWidgetState extends State<TypeSectionWidget> {
  @override
  void initState() {
    BlocProvider.of<TypeSectionCubit>(context).init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TypeSectionCubit, TypeSectionState>(
      builder: (context, state) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: MediaType.values.map<Widget>((x) {
            return Flexible(
              child: CheckboxListTile(
                  title: Text(x.toName(),
                      style: Theme.of(context).textTheme.labelLarge),
                  controlAffinity: ListTileControlAffinity.leading,
                  dense: false,
                  value: state.tempSelectedItem.contains(x),
                  onChanged: (value) {
                    if (value == true) {
                      BlocProvider.of<TypeSectionCubit>(context).selectItem(x);
                    } else if (value == false) {
                      BlocProvider.of<TypeSectionCubit>(context).removeItem(x);
                    }
                  }),
            );
          }).toList(),
        );
      },
    );
  }
}
