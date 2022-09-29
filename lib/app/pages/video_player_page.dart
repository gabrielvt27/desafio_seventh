import 'package:flutter/material.dart';

import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:desafio_seventh/app/stores/auth_store.dart';
import 'package:desafio_seventh/app/utils/api_response.dart';
import 'package:desafio_seventh/app/stores/video_player_store.dart';
import 'package:desafio_seventh/app/pages/components/error_message_widget.dart';
import 'package:desafio_seventh/app/pages/components/default_button_widget.dart';

/// Stateful widget to fetch and then display video content.
class VideoPlayerPage extends StatefulWidget {
  const VideoPlayerPage({Key? key}) : super(key: key);

  @override
  VideoPlayerPageState createState() => VideoPlayerPageState();
}

class VideoPlayerPageState extends State<VideoPlayerPage> {
  final VideoPlayerStore _videoPlayerStore = Modular.get<VideoPlayerStore>();
  final AuthStore _authStore = Modular.get<AuthStore>();

  late VideoPlayerController _videoController;
  late ChewieController _chewieController;

  _initializeVideoPlayer(String url) {
    _videoController = VideoPlayerController.network(url);

    _chewieController = ChewieController(
      videoPlayerController: _videoController,
      autoPlay: true,
      allowMuting: false,
      aspectRatio: 16 / 9,
      additionalOptions: (context) {
        return <OptionItem>[
          OptionItem(
            onTap: () => _authStore.logoutUser(),
            iconData: Icons.exit_to_app,
            title: 'Sair',
          ),
        ];
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ValueListenableBuilder<ApiResponse>(
          valueListenable: _videoPlayerStore.videoPlayerState,
          builder: (context, value, child) {
            if (value.status == Status.error) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ErrorMessageWidget(message: value.message!),
                    DefaultButtonWidget(
                      text: "LOGOUT",
                      onPressed: () => _authStore.logoutUser(),
                    ),
                  ],
                ),
              );
            } else if (value.status == Status.completed) {
              _initializeVideoPlayer(value.data!);
              return Container(
                color: Colors.black,
                child: Chewie(
                  controller: _chewieController,
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _videoController.dispose();
    _chewieController.dispose();
    super.dispose();
  }
}
