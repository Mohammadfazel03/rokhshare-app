import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:rokhshare/feature/plan/presentation/bloc/plan_cubit.dart';
import 'package:rokhshare/feature/user/presentation/bloc/auth_cubit.dart';
import 'package:rokhshare/gen/assets.gen.dart';
import 'package:rokhshare/utils/error_widget.dart';

class PlanPage extends StatefulWidget {
  final String? username;

  const PlanPage({super.key, this.username});

  @override
  State<PlanPage> createState() => _PlanPageState();
}

class _PlanPageState extends State<PlanPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("خرید اشتراک",
              style: Theme
                  .of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.w700)),
          centerTitle: true,
          surfaceTintColor: Theme
              .of(context)
              .colorScheme
              .surfaceTint),
      body: BlocConsumer<PlanCubit, PlanState>(listenWhen: (p, c) {
        return p.buyError != c.buyError || p.buyStatus != c.buyStatus;
      }, listener: (BuildContext context, PlanState state) {
        if (state.buyStatus == BuyStatus.success) {
          final endDate = DateFormat('yyyy-MM-ddTHH:mm')
              .parse(state.buyResponse?.endDate ?? "");
          final now = DateTime.now();
          int days = endDate
              .difference(now)
              .inDays;
          BlocProvider.of<AuthCubit>(context)
              .premium(days);
          Navigator.of(context).pop();
        } else if (state.buyStatus == BuyStatus.fail) {
          final snackBar = SnackBar(
            dismissDirection: DismissDirection.horizontal,
            behavior: SnackBarBehavior.floating,
            content: Text(state.buyError?.error ?? "",
                textAlign: TextAlign.center,
                style: Theme
                    .of(context)
                    .textTheme
                    .labelLarge
                    ?.copyWith(
                    color: Theme
                        .of(context)
                        .colorScheme
                        .onInverseSurface)),
            backgroundColor: Theme
                .of(context)
                .colorScheme
                .inverseSurface,
            duration: const Duration(seconds: 10),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      }, builder: (context, state) {
        if (state.status == PlanStatus.loading ||
            state.status == PlanStatus.initial) {
          return const Center(child: CircularProgressIndicator.adaptive());
        } else if (state.status == PlanStatus.error) {
          return CustomErrorWidget(
              error: state.error!,
              showIcon: true,
              showTitle: true,
              onRetry: () {
                BlocProvider.of<PlanCubit>(context).getPlans();
              });
        }
        return SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 24, 8, 24),
                child: Wrap(
                  alignment: WrapAlignment.center,
                  runAlignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 4,
                  runSpacing: 4,
                  children: [
                    Text("خرید اشتراک رخشاره",
                        textAlign: TextAlign.center,
                        style: Theme
                            .of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(fontWeight: FontWeight.w700)),
                    DecoratedBox(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: Theme
                              .of(context)
                              .colorScheme
                              .surfaceContainerHigh),
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text("برای کاربر ${widget.username}",
                            style: Theme
                                .of(context)
                                .textTheme
                                .labelLarge
                                ?.copyWith(
                              // fontWeight: FontWeight.w700,
                                color: Theme
                                    .of(context)
                                    .colorScheme
                                    .onSecondaryContainer)),
                      ),
                    ),
                  ],
                ),
              ),
              for (var plan in state.plans) ...[
                Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    onTap: () {
                      BlocProvider.of<PlanCubit>(context).buy(price: plan.price!, plan: plan.id!);
                    },
                    leading: Assets.icons.ticketBoldDuotone.svg(
                        colorFilter: ColorFilter.mode(
                            Theme
                                .of(context)
                                .colorScheme
                                .primary,
                            BlendMode.srcIn)),
                    title: Text(plan.title ?? "",
                        style: Theme
                            .of(context)
                            .textTheme
                            .labelLarge
                            ?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: Theme
                                .of(context)
                                .colorScheme
                                .onSurface)),
                    subtitle: Text("${plan.days} روزه ",
                        style: Theme
                            .of(context)
                            .textTheme
                            .labelMedium
                            ?.copyWith(
                            color: Theme
                                .of(context)
                                .colorScheme
                                .onSurfaceVariant)),
                    trailing: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(4)),
                        child: Text(
                          "${plan.price} تومان ",
                          style:
                          Theme
                              .of(context)
                              .textTheme
                              .labelSmall
                              ?.copyWith(
                            color: Colors.white,
                          ),
                        )),
                    tileColor:
                    Theme
                        .of(context)
                        .colorScheme
                        .surfaceContainerLowest,
                    shape: RoundedRectangleBorder(
                        side: BorderSide(
                            width: 0.2,
                            color: Theme
                                .of(context)
                                .colorScheme
                                .outline),
                        borderRadius: BorderRadius.circular(8)),
                  ),
                )
              ],
              Padding(
                padding:
                const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: Text(
                  "%10 مالیات بر ارزش افزوده به قیمت همه اشتراک‌ها اضافه می‌شود.",
                  style: Theme
                      .of(context)
                      .textTheme
                      .labelSmall,
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding:
                const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: SizedBox(
                  width: double.infinity,
                  child: Text(
                    "با خرید اشتراک  به امکانات زیر دسترسی خواهید داشت:",
                    style: Theme
                        .of(context)
                        .textTheme
                        .labelLarge
                        ?.copyWith(fontWeight: FontWeight.w700),
                    textAlign: TextAlign.start,
                  ),
                ),
              ),
              Padding(
                  padding:
                  const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "• ",
                        style: Theme
                            .of(context)
                            .textTheme
                            .labelSmall,
                      ),
                      Expanded(
                        child: Text(
                          "تماشای فیلم های اشتراکی به صورت رایگان",
                          style: Theme
                              .of(context)
                              .textTheme
                              .labelSmall,
                        ),
                      ),
                    ],
                  )),
              Padding(
                  padding:
                  const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "• ",
                        style: Theme
                            .of(context)
                            .textTheme
                            .labelSmall,
                      ),
                      Expanded(
                        child: Text(
                          "دسترسی کامل به امکانات و کنترل ویدیو",
                          style: Theme
                              .of(context)
                              .textTheme
                              .labelSmall,
                        ),
                      ),
                    ],
                  )),
              Padding(
                  padding:
                  const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "• ",
                        style: Theme
                            .of(context)
                            .textTheme
                            .labelSmall,
                      ),
                      Expanded(
                        child: Text(
                          "خذف تبلیغات",
                          style: Theme
                              .of(context)
                              .textTheme
                              .labelSmall,
                        ),
                      ),
                    ],
                  ))
            ],
          ),
        );
      }),
    );
  }
}
