import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class TrailerPlayerPage extends StatefulWidget {
  final String trailer;

  const TrailerPlayerPage({super.key, required this.trailer});

  @override
  State<TrailerPlayerPage> createState() => _TrailerPlayerPageState();
}

class _TrailerPlayerPageState extends State<TrailerPlayerPage> {
  late final VideoPlayerController videoPlayerController;
  ChewieController? chewieController;

  @override
  void initState() {
    videoPlayerController =
        VideoPlayerController.networkUrl(Uri.parse(widget.trailer));
    videoPlayerController.initialize().then((_) {
      chewieController = ChewieController(
        fullScreenByDefault: true,
        showOptions: false,
        videoPlayerController: videoPlayerController,
        autoPlay: true,
        autoInitialize: true,
        looping: false,
        allowMuting: true,
      );

      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: chewieController != null
            ? Chewie(controller: chewieController!)
            : Container(
                color: Colors.black,
                child:
                    const Center(child: CircularProgressIndicator.adaptive()),
              ));
  }
}
