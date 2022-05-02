import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerItem extends StatefulWidget {
  final VideoPlayerController VideoPlayerItemController;
  final bool looping;

  const VideoPlayerItem(
      {required this.VideoPlayerItemController,
      required this.looping,
      Key? key})
      : super(key: key);

  @override
  State<VideoPlayerItem> createState() => _VideoPlayerItemState();
}

class _VideoPlayerItemState extends State<VideoPlayerItem> {
  ChewieController? _chewieController;

  @override
  void initState() {
    super.initState();
    // Wrapper on top of the VideoPlayerItemController
    _chewieController = ChewieController(
      videoPlayerController: widget.VideoPlayerItemController,
      aspectRatio: 16 / 9,
      autoInitialize: true,
      looping: true,
      showControlsOnInitialize: true,
      showControls: true,
      allowMuting: true,
      allowFullScreen: false,
      showOptions: false,
      autoPlay: true,
      errorBuilder: (context, errorMessage) {
        return Center(
          child: Text(
            errorMessage,
            style: TextStyle(color: Colors.white),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Chewie(
        controller: _chewieController!,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    // IMPORTANT to dispose of all the used resources
    widget.VideoPlayerItemController.dispose();
    _chewieController!.dispose();
  }
}
