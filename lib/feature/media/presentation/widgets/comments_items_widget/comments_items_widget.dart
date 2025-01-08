import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rokhshare/feature/media/presentation/widgets/comments_items_widget/bloc/comments_items_cubit.dart';
import 'package:rokhshare/gen/assets.gen.dart';
import 'package:rokhshare/utils/error_widget.dart';

class CommentsItemsWidget extends StatefulWidget {
  const CommentsItemsWidget({super.key});

  @override
  State<CommentsItemsWidget> createState() => _CommentsItemsWidgetState();
}

class _CommentsItemsWidgetState extends State<CommentsItemsWidget> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.sizeOf(context).width;
    return BlocConsumer<CommentsItemsCubit, CommentsItemsState>(
      listenWhen: (p, c) {
        return c.status == CommentsItemsStatus.submitError ||
            c.status == CommentsItemsStatus.submitSuccess;
      },
      buildWhen: (p, c) {
        return c.status != CommentsItemsStatus.submitError ||
            c.status != CommentsItemsStatus.submitSuccess;
      },
      listener: (context, state) {
        if (state.status == CommentsItemsStatus.submitSuccess) {
          final snackBar = SnackBar(
            dismissDirection: DismissDirection.horizontal,
            behavior: SnackBarBehavior.floating,
            content: Text("نظر شما پس از برسی نمایش داده خواهد شد.",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onInverseSurface)),
            backgroundColor: Theme.of(context).colorScheme.inverseSurface,
            duration: const Duration(seconds: 10),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
        if (state.status == CommentsItemsStatus.submitError) {
          final snackBar = SnackBar(
            dismissDirection: DismissDirection.horizontal,
            behavior: SnackBarBehavior.floating,
            content: Text(state.error?.error ?? "",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onInverseSurface)),
            backgroundColor: Theme.of(context).colorScheme.inverseSurface,
            duration: const Duration(seconds: 10),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
      builder: (context, state) {
        return SliverMainAxisGroup(slivers: [
          const SliverToBoxAdapter(
              child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Divider(),
          )),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "نظرات",
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          builder: (c) {
                            return BlocProvider.value(
                              value:
                                  BlocProvider.of<CommentsItemsCubit>(context),
                              child: const WriteCommentWidget(),
                            );
                          });
                    },
                    label: const Text("دیدگاه جدید"),
                    style: ButtonStyle(
                      textStyle: WidgetStatePropertyAll(Theme.of(context)
                          .textTheme
                          .labelLarge
                          ?.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurfaceVariant)),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (state.comments.isNotEmpty) ...[
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              sliver: SliverList.builder(
                itemCount: state.comments.length +
                    ((state.status == CommentsItemsStatus.loading ||
                            state.status == CommentsItemsStatus.error ||
                            state.lastPage >= state.nextPage)
                        ? 1
                        : 0),
                itemBuilder: (BuildContext context, int index) {
                  if (index == state.comments.length) {
                    if (state.lastPage >= state.nextPage &&
                        state.status != CommentsItemsStatus.loading &&
                        state.status != CommentsItemsStatus.error) {
                      return Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Expanded(child: Divider()),
                          Padding(
                            padding: const EdgeInsets.all(4),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(32),
                              onTap: () {
                                BlocProvider.of<CommentsItemsCubit>(context)
                                    .getComments(
                                        page:
                                            BlocProvider.of<CommentsItemsCubit>(
                                                    context)
                                                .state
                                                .nextPage);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(4),
                                child: Row(
                                  spacing: 8,
                                  children: [
                                    Text("نظرات بیشتر",
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium
                                            ?.copyWith(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onSurface)),
                                    Icon(Icons.arrow_drop_down_rounded,
                                        size: 16,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurface)
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const Expanded(child: Divider()),
                        ],
                      );
                    } else if (state.status == CommentsItemsStatus.loading) {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: CircularProgressIndicator.adaptive(),
                        ),
                      );
                    } else {
                      return CustomErrorWidget(
                          error: state.error!,
                          showIcon: false,
                          showMessage: true,
                          showTitle: false,
                          onRetry: () {
                            int page =
                                BlocProvider.of<CommentsItemsCubit>(context)
                                    .state
                                    .nextPage;
                            BlocProvider.of<CommentsItemsCubit>(context)
                                .getComments(page: page, retry: true);
                          });
                    }
                  }
                  return Container(
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surfaceContainer,
                        borderRadius: BorderRadius.circular(8)),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 8,
                      children: [
                        Assets.icons.userCircleBold.svg(
                            height: 28,
                            width: 282,
                            colorFilter: ColorFilter.mode(
                                Theme.of(context)
                                    .colorScheme
                                    .onSecondaryContainer,
                                BlendMode.srcIn)),
                        Expanded(
                            child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 8),
                            Text(state.comments[index].user?.username ?? "",
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium
                                    ?.copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSecondaryContainer)),
                            const SizedBox(height: 8),
                            const Divider(height: 1),
                            const SizedBox(height: 8),
                            Text(state.comments[index].comment ?? "",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSecondaryContainer)),
                          ],
                        ))
                      ],
                    ),
                  );
                },
              ),
            )
          ] else ...[
            if (state.status == CommentsItemsStatus.loading) ...[
              const SliverToBoxAdapter(
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: CircularProgressIndicator.adaptive(),
                  ),
                ),
              )
            ] else if (state.status == CommentsItemsStatus.error) ...[
              SliverToBoxAdapter(
                child: CustomErrorWidget(
                    error: state.error!,
                    showIcon: false,
                    showMessage: true,
                    showTitle: false,
                    onRetry: () {
                      int page = BlocProvider.of<CommentsItemsCubit>(context)
                          .state
                          .nextPage;
                      BlocProvider.of<CommentsItemsCubit>(context)
                          .getComments(page: page, retry: true);
                    }),
              )
            ] else ...[
              const SliverToBoxAdapter(
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Text("نظری وجود ندارد"),
                  ),
                ),
              )
            ]
          ],
          const SliverPadding(padding: EdgeInsets.all(8))
        ]);
      },
    );
  }
}

class WriteCommentWidget extends StatefulWidget {
  const WriteCommentWidget({super.key});

  @override
  State<WriteCommentWidget> createState() => _WriteCommentWidgetState();
}

class _WriteCommentWidgetState extends State<WriteCommentWidget> {
  late final TextEditingController textEditingController;
  bool enabled = false;

  @override
  void initState() {
    textEditingController = TextEditingController();
    textEditingController.addListener(textListener);
    super.initState();
  }

  @override
  void dispose() {
    textEditingController.removeListener(textListener);
    textEditingController.dispose();
    super.dispose();
  }

  void textListener() {
    if (enabled == false && textEditingController.text.isNotEmpty) {
      setState(() {
        enabled = true;
      });
    } else if (enabled == true && textEditingController.text.isEmpty) {
      setState(() {
        enabled = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
          16, 16, 16, 16 + MediaQuery.of(context).viewInsets.bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 16, 0, 32),
            child: Text("دیدگاه خود را بنویسید",
                style: Theme.of(context).textTheme.labelLarge),
          ),
          TextField(
            controller: textEditingController,
            minLines: 1,
            maxLines: 5,
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
                filled: true,
                border: const UnderlineInputBorder(borderSide: BorderSide.none),
                alignLabelWithHint: true,
                suffixIcon: IconButton(
                    onPressed: enabled
                        ? () {
                            BlocProvider.of<CommentsItemsCubit>(context)
                                .submitComment(
                                    comment: textEditingController.text);
                            Navigator.of(context).pop();
                          }
                        : null,
                    icon: Transform.rotate(
                        angle: pi / 180 * -135,
                        child: Assets.icons.sendBold.svg(
                            colorFilter: ColorFilter.mode(
                                enabled
                                    ? Theme.of(context).colorScheme.primary
                                    : Theme.of(context).disabledColor,
                                BlendMode.srcIn))),
                    padding: EdgeInsets.zero)),
          )
        ],
      ),
    );
  }
}
