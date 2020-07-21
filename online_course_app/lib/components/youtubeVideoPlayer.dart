import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubeVideoPlayer extends StatefulWidget {
  @override
  _YoutubeVideoPlayerState createState() => _YoutubeVideoPlayerState();
}

class _YoutubeVideoPlayerState extends State<YoutubeVideoPlayer> {
  YoutubePlayerController _controller = YoutubePlayerController(
      initialVideoId: 'zRO4u6cYTEQ',
      flags: YoutubePlayerFlags(
          autoPlay: true, forceHD: false, enableCaption: true));

  @override
  void initState() {
    super.initState();
    // _controller = YoutubePlayerController(
    //     initialVideoId: 'zRO4u6cYTEQ',
    //     flags: YoutubePlayerFlags(
    //         autoPlay: true, forceHD: false, enableCaption: true));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(_controller.value.isReady);
    return YoutubePlayer(
      controller: _controller,
      topActions: <Widget>[Text("hello there")],
    );
  }
}
