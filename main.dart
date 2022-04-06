import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  static const customSwatch = MaterialColor(
    0xFFFF5252,
    <int, Color>{
      50: Color(0xFFFFEBEE),
      100: Color(0xFFFFCDD2),
      200: Color(0xFFEF9A9A),
      300: Color(0xFFE57373),
      400: Color(0xFFEF5350),
      500: Color(0xFFFF5252),
      600: Color(0xFFE53935),
      700: Color(0xFFD32F2F),
      800: Color(0xFFC62828),
      900: Color(0xFFB71C1C),
    },
  );

  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: customSwatch,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  VideoPlayerController? _controller;

  @override
  void initState() {
    super.initState();
    /// load video from network
    // _controller = VideoPlayerController.network(
    //     'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4')
    //   ..initialize().then((_) {
    //     // Ensure the first frame is shown after the video is initialized,
    //     // even before the play button has been pressed.
    //     setState(() {});
    //   });

    /// load video from asset
    _controller = VideoPlayerController.asset("assets/Butterfly.mp4")..initialize().then((_) {
      // Ensure the first frame is shown after the video is initialized,
      // even before the play button has been pressed.
      setState(() {});
    });

    /// _controller = VideoPlayerController.file(file) -> load video from file

    /// _controller.seekTo(position) -> go to specific point in video
    /// _controller.setVolume(volume) -> value between 0.0 (silent) and 1.0 (full volume)
    /// _controller.setLooping(looping) -> repeat video
  }

  @override
  void dispose() {
    super.dispose();
    _controller?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Video Player"),
      ),
      body: Center(
        child: _controller!=null && _controller!.value.isInitialized? AspectRatio(
          aspectRatio: _controller!.value.aspectRatio,
          child: VideoPlayer(_controller!,),
        ) : Container(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: buttonPressed,
        child: Icon(
          _controller!=null && _controller!.value.isPlaying? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }

  void buttonPressed() {
    if (_controller != null) {
      setState(() {
        _controller!.value.isPlaying? _controller!.pause() : _controller!.play();
      });
    }
  }

}

