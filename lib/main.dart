import 'package:flutter/material.dart';
import 'package:appinio_video_player/appinio_video_player.dart';


void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyPlayer(),
    );
  }
}

class MyPlayer extends StatefulWidget {
  const MyPlayer({Key? key}) : super(key: key);

  @override
  State<MyPlayer> createState() => _MyPlayerState();
}

class _MyPlayerState extends State<MyPlayer> {
  late VideoPlayerController videoPlayerController;
  late CustomVideoPlayerController _customVideoPlayerController;

  //Must be needed to https:// link not http
  String videoUrl = "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4";


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    videoPlayerController = VideoPlayerController.network(videoUrl)
      ..initialize().then((value) => setState(() {}));
    _customVideoPlayerController = CustomVideoPlayerController(
      context: context,
      videoPlayerController: videoPlayerController,
      customVideoPlayerSettings: const CustomVideoPlayerSettings(
        playButton:  Icon(Icons.play_circle,color: Colors.deepOrange,),
        pauseButton: Icon(Icons.pause_circle,color: Colors.deepOrange,),
        customVideoPlayerProgressBarSettings: CustomVideoPlayerProgressBarSettings(progressColor: Colors.deepOrange)
      )
    );


  }

  @override
  void dispose() {
    _customVideoPlayerController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(width: double.infinity,height: double.infinity,
        child: Column(crossAxisAlignment: CrossAxisAlignment.center,children: [
          CustomVideoPlayer(
              customVideoPlayerController: _customVideoPlayerController
          ),
        ],),),
      ),
    );
  }
}
