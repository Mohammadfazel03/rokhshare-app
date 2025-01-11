import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rokhshare/feature/play/presentation/bloc/play_cubit.dart';
import 'package:rokhshare/utils/error_widget.dart';
import 'package:video_player/video_player.dart';

class PlayerPage extends StatefulWidget {
  final int media;
  final int? movie;
  final int? episode;

  const PlayerPage({
    super.key,
    required this.media,
    this.movie,
    this.episode,
  });

  @override
  State<PlayerPage> createState() => _PlayerPageState();
}

class _PlayerPageState extends State<PlayerPage> {
  VideoPlayerController? mediaVideoPlayerController;
  ChewieController? mediaChewieController;
  VideoPlayerController? adsVideoPlayerController;
  ChewieController? adsChewieController;

  @override
  void initState() {
    if (widget.episode != null) {
      BlocProvider.of<PlayCubit>(context).episodePlay(widget.episode!);
    } else if (widget.movie != null) {
      BlocProvider.of<PlayCubit>(context).moviePlay(widget.movie!);
    }
    super.initState();
  }

  @override
  void dispose() {
    mediaVideoPlayerController?.dispose();
    mediaChewieController?.dispose();
    adsVideoPlayerController?.dispose();
    adsChewieController?.dispose();
    mediaChewieController = null;
    mediaVideoPlayerController = null;
    adsVideoPlayerController = null;
    adsChewieController = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocConsumer<PlayCubit, PlayState>(
      listener: (context, state) async {
        if (state is MediaPlayInitialSuccessfully) {
          mediaVideoPlayerController?.dispose();
          mediaChewieController?.dispose();
          mediaVideoPlayerController =
              VideoPlayerController.networkUrl(Uri.parse(state.media.file!));
          await mediaVideoPlayerController!.initialize();
          mediaChewieController = ChewieController(
            fullScreenByDefault: false,
            showOptions: false,
            videoPlayerController: mediaVideoPlayerController!,
            autoPlay: true,
            autoInitialize: true,
            looping: false,
            showControlsOnInitialize: false,
            allowMuting: state.media.isPremium ?? false,
            draggableProgressBar: state.media.isPremium ?? false,
            showControls: state.media.isPremium ?? false,
            allowPlaybackSpeedChanging: state.media.isPremium ?? false,
          );
          if (state.media.adsTime?.isNotEmpty ?? false) {
            List<int> adsTime =
                List<int>.of(state.media.adsTime!.skipWhile((x) => x == 0));
            BlocProvider.of<PlayCubit>(context)
                .adsPlay(widget.media, widget.episode);
            if (adsTime.isNotEmpty) {
              mediaVideoPlayerController!.addListener(() async {
                if (adsTime.contains(
                    mediaVideoPlayerController!.value.position.inSeconds)) {
                  mediaChewieController!.pause();
                  adsTime.remove(
                      mediaVideoPlayerController!.value.position.inSeconds);
                  BlocProvider.of<PlayCubit>(context)
                      .adsPlay(widget.media, widget.episode);
                }
              });
            }
          } else {
            BlocProvider.of<PlayCubit>(context).mediaReadyPlay();
          }
        }
        if (state is AdsPlayInitialSuccessfully) {
          if (state.ads.file?.file != null) {
            adsVideoPlayerController?.dispose();
            adsChewieController?.dispose();
            adsChewieController = null;
            adsVideoPlayerController = null;
            adsVideoPlayerController = VideoPlayerController.networkUrl(
                Uri.parse(state.ads.file!.file!));
            await adsVideoPlayerController!.initialize();
            adsChewieController = ChewieController(
              fullScreenByDefault: false,
              showOptions: false,
              videoPlayerController: adsVideoPlayerController!,
              autoPlay: true,
              autoInitialize: true,
              looping: false,
              showControlsOnInitialize: false,
              allowMuting: false,
              draggableProgressBar: false,
              showControls: false,
              allowPlaybackSpeedChanging: false,
            );
            adsVideoPlayerController!.addListener(() async {
              if (adsVideoPlayerController!.value.isCompleted) {
                BlocProvider.of<PlayCubit>(context).adsComplete();
              }
            });
            BlocProvider.of<PlayCubit>(context).adsReadyPlay();
          } else {
            BlocProvider.of<PlayCubit>(context).adsComplete();
          }
        }
        if (state is AdsPlayComplete) {
          if (mediaChewieController != null &&
              mediaVideoPlayerController != null) {
            await Future.delayed(const Duration(milliseconds: 500));
            mediaChewieController!.play();
          } else {
            BlocProvider.of<PlayCubit>(context).setError();
          }
        }
      },
      builder: (context, state) {
        if (state is AdsPlaySuccessfully) {
          return Chewie(controller: adsChewieController!);
        }

        if (state is MediaPlaySuccessfully || state is AdsPlayComplete) {
          return Theme(
              data: Theme.of(context).copyWith(
                platform: TargetPlatform.iOS,
              ),
              child: Chewie(controller: mediaChewieController!));
        }

        if (state is PlayFailed) {
          return CustomErrorWidget(
            error: state.error,
            onRetry: () {},
            showButton: false,
            showIcon: false,
            showTitle: true,
            showMessage: true,
          );
        }

        return Container(
          color: Colors.black,
          child: const Center(child: CircularProgressIndicator.adaptive()),
        );
      },
    ));
  }
}
