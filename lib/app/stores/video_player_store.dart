import 'package:flutter/material.dart';

import 'package:desafio_seventh/app/utils/api_response.dart';
import 'package:desafio_seventh/app/repositories/video_player_repository.dart';

class VideoPlayerStore {
  final ValueNotifier<ApiResponse> videoPlayerState =
      ValueNotifier<ApiResponse>(ApiResponse.initial());

  final VideoPlayerRepository _videoPlayerRepository;

  VideoPlayerStore(this._videoPlayerRepository) {
    _getVideoUrl();
  }

  _getVideoUrl() async {
    try {
      final url =
          await _videoPlayerRepository.getVideoUrlByFileName('bunny.mp4');
      videoPlayerState.value = ApiResponse.completed(url);
    } catch (e) {
      videoPlayerState.value = ApiResponse.error(e.toString());
    }
  }
}
