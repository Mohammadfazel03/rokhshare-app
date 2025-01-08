import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rokhshare/config/dependency_injection.dart';
import 'package:rokhshare/config/local_storage_service.dart';
import 'package:rokhshare/feature/media/data/remote/model/rating.dart';
import 'package:rokhshare/feature/media/presentation/widgets/media_rate_widget/bloc/media_rate_cubit.dart';
import 'package:rokhshare/gen/assets.gen.dart';
import 'package:rokhshare/utils/error_widget.dart';

class MediaRateWidget extends StatelessWidget {
  const MediaRateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MediaRateCubit, MediaRateState>(
      buildWhen: (p, c) {
        return c.status == MediaRateStatus.submitLoading ||
            c.myRate != p.myRate ||
            p.status == MediaRateStatus.submitLoading;
      },
      listenWhen: (p, c) => c.status == MediaRateStatus.submitError,
      listener: (context, state) {
        final snackBar = SnackBar(
          dismissDirection: DismissDirection.horizontal,
          behavior: SnackBarBehavior.floating,
          content: Text(state.error?.title ?? "خطا در ثبت امتیاز",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: Theme.of(context).colorScheme.onInverseSurface)),
          backgroundColor: Theme.of(context).colorScheme.inverseSurface,
          duration: const Duration(seconds: 5),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      },
      builder: (context, state) {
        return IconButton.filledTonal(
            tooltip: "امتیاز",
            padding: const EdgeInsets.all(16),
            onPressed: () {
              showModalBottomSheet(
                  showDragHandle: true,
                  context: context,
                  builder: (_) => MultiBlocProvider(
                          providers: [
                            BlocProvider.value(
                                value:
                                    BlocProvider.of<MediaRateCubit>(context)),
                          ],
                          child:
                              const IntrinsicHeight(child: MediaRateResultScreen())));
            },
            icon: state.status == MediaRateStatus.submitLoading
                ? SizedBox(
                    height: 24,
                    width: 24,
                    child: SpinKitRing(
                      color: Theme.of(context).colorScheme.onSecondaryContainer,
                      size: 24,
                      lineWidth: 5,
                      duration: const Duration(milliseconds: 500),
                    ),
                  )
                : SvgPicture(
                    SvgAssetLoader(state.myRate != null
                        ? Assets.icons.starBold.path
                        : Assets.icons.starLinear.path),
                    colorFilter: ColorFilter.mode(
                        Theme.of(context).colorScheme.onSecondaryContainer,
                        BlendMode.srcIn),
                    height: 24,
                    width: 24));
      },
    );
  }
}

class MediaRateResultScreen extends StatefulWidget {
  const MediaRateResultScreen({super.key});

  @override
  State<MediaRateResultScreen> createState() => _MediaRateResultScreenState();
}

class _MediaRateResultScreenState extends State<MediaRateResultScreen> {
  ValueNotifier<int?> tempValue = ValueNotifier(null);

  @override
  void dispose() {
    tempValue.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MediaRateCubit, MediaRateState>(
      buildWhen: (p, c) {
        return (c.status == MediaRateStatus.loading &&
                p.status != MediaRateStatus.loading) ||
            (c.status == MediaRateStatus.error &&
                p.status != MediaRateStatus.error) ||
            (c.status == MediaRateStatus.success &&
                p.status != MediaRateStatus.success);
      },
      builder: (context, state) {
        if (state.status == MediaRateStatus.loading ||
            state.status == MediaRateStatus.submitLoading) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: CircularProgressIndicator.adaptive(),
            ),
          );
        }
        if (state.status == MediaRateStatus.error) {
          return CustomErrorWidget(
              error: state.error!,
              showIcon: false,
              showMessage: true,
              showTitle: false,
              onRetry: () {
                BlocProvider.of<MediaRateCubit>(context).getRates();
              });
        }
        if (state.status == MediaRateStatus.success ||
            state.status == MediaRateStatus.submitError) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 4,
              children: [
                Text("ثبت امتیاز",
                    style: Theme.of(context).textTheme.titleMedium),
                const Divider(),
                IntrinsicHeight(
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          spacing: 4,
                          children: [
                            RichText(
                                text: TextSpan(children: [
                              TextSpan(
                                  text: state.allRate.toStringAsFixed(1),
                                  style: Theme.of(context)
                                      .textTheme
                                      .displaySmall
                                      ?.copyWith(
                                          fontWeight: FontWeight.w500,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSurface)),
                              TextSpan(
                                  text: "از 5",
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium
                                      ?.copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSurface)),
                            ])),
                            RatingBar(
                              initialRating: state.allRate.roundToDouble(),
                              direction: Axis.horizontal,
                              allowHalfRating: false,
                              ignoreGestures: true,
                              itemCount: 5,
                              itemSize: 16,
                              ratingWidget: RatingWidget(
                                full: Assets.icons.starBold.svg(
                                    colorFilter: const ColorFilter.mode(
                                        Color(0xffFACC15), BlendMode.srcIn)),
                                half: Assets.icons.starBold.svg(),
                                empty: Assets.icons.starBold.svg(
                                    colorFilter: const ColorFilter.mode(
                                        Color(0x4dfacc15), BlendMode.srcIn)),
                              ),
                              itemPadding: const EdgeInsets.symmetric(horizontal: 1),
                              onRatingUpdate: (rating) {
                              },
                            ),
                            Text("(${state.count} رای)",
                                style: Theme.of(context).textTheme.labelSmall)
                          ],
                        ),
                      ),
                      const VerticalDivider(),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 16, 16, 16),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            spacing: 4,
                            children: [
                              for (int i = 1; i <= 5; i++) ...[
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  spacing: 8,
                                  children: [
                                    Text("$i",
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium),
                                    Expanded(
                                      child: LinearProgressIndicator(
                                          color: const Color(0xffFACC15),
                                          borderRadius:
                                              BorderRadius.circular(32),
                                          value: (state.rates
                                                      .firstWhere(
                                                          (t) => t.rating == i,
                                                          orElse: () => Rating(
                                                              rating: 0,
                                                              count: 0))
                                                      .count ??
                                                  0) /
                                              (state.count == 0
                                                  ? 1
                                                  : state.count)),
                                    )
                                  ],
                                )
                              ]
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  child: FutureBuilder(
                      future: getIt.get<LocalStorageService>().isLogin(),
                      builder: (c, data) {
                        return RatingBar(
                          initialRating: state.myRate?.roundToDouble() ?? 0.0,
                          direction: Axis.horizontal,
                          allowHalfRating: false,
                          ignoreGestures: data.data != true,
                          itemCount: 5,
                          itemSize: 40,
                          minRating: 1,
                          ratingWidget: RatingWidget(
                            full: Assets.icons.starBold.svg(
                                colorFilter: const ColorFilter.mode(
                                    Color(0xffFACC15), BlendMode.srcIn)),
                            half: Assets.icons.starBold.svg(),
                            empty: Assets.icons.starBold.svg(
                                colorFilter: const ColorFilter.mode(
                                    Color(0x4dfacc15), BlendMode.srcIn)),
                          ),
                          itemPadding: const EdgeInsets.symmetric(horizontal: 4),
                          onRatingUpdate: (rating) {
                            tempValue.value = rating.round();
                          },
                        );
                      }),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  spacing: 16,
                  children: [
                    Expanded(
                        child: OutlinedButton(
                            onPressed: state.myRate != null
                                ? () {
                                    Navigator.of(context).pop();
                                    BlocProvider.of<MediaRateCubit>(context)
                                        .deleteRate();
                                  }
                                : null,
                            style: ButtonStyle(
                                textStyle: WidgetStatePropertyAll(
                                    Theme.of(context).textTheme.labelLarge),
                                shape: WidgetStatePropertyAll(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8)))),
                            child: const Text("حذف امتیاز"))),
                    Expanded(
                      child: ValueListenableBuilder(
                          valueListenable: tempValue,
                          builder: (c, d, w) {
                            return FilledButton(
                              onPressed: d != null && d != state.myRate
                                  ? () {
                                      Navigator.of(context).pop();
                                      BlocProvider.of<MediaRateCubit>(context)
                                          .submitRate(rate: tempValue.value!);
                                    }
                                  : null,
                              style: ButtonStyle(
                                  textStyle: WidgetStatePropertyAll(
                                      Theme.of(context).textTheme.labelLarge),
                                  shape: WidgetStatePropertyAll(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8)))),
                              child: const Text("ثبت امتیاز"),
                            );
                          }),
                    )
                  ],
                ),
                const SizedBox(height: 8)
              ],
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
