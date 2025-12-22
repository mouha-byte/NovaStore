import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'landing_constants.dart';

import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';
class VideosSection extends StatelessWidget {
  final bool shouldPlay;

  const VideosSection({
    super.key,
    this.shouldPlay = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 120, horizontal: 40),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFFAF5FF),
            Colors.white,
            Color(0xFFF3E8FF),
          ],
        ),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              _buildBadge(),
              const SizedBox(height: 40),
              _buildTitle(),
              const SizedBox(height: 30),
              _buildSubtitle(),
              const SizedBox(height: 70),
              _buildVideosGrid(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [LandingConstants.pinkAccent, LandingConstants.secondaryColor],
        ),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: LandingConstants.pinkAccent.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.play_circle, color: Colors.white, size: 20),
          const SizedBox(width: 10),
          Text(
            LandingConstants.videosBadge,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w900,
              color: Colors.white,
              letterSpacing: 2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      LandingConstants.videosTitle,
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: 46,
        fontWeight: FontWeight.w900,
        height: 1.2,
        letterSpacing: -1,
      ),
    );
  }

  Widget _buildSubtitle() {
    return Text(
      LandingConstants.videosSubtitle,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 20,
        color: Colors.grey[600],
        height: 1.6,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  Widget _buildVideosGrid() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount = constraints.maxWidth > 900 ? 2 : 1;
        
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 40,
            mainAxisSpacing: 40,
            childAspectRatio: 1.5,
          ),
          itemCount: LandingConstants.videoItems.length,
          itemBuilder: (context, index) {
            final video = LandingConstants.videoItems[index];
            return VideoCard(
              video: video,
              shouldPlay: shouldPlay,
            );
          },
        );
      },
    );
  }
}

class VideoCard extends StatefulWidget {
  final VideoItem video;
  final bool shouldPlay;

  const VideoCard({
    super.key,
    required this.video,
    required this.shouldPlay,
  });

  @override
  State<VideoCard> createState() => _VideoCardState();
}

class _VideoCardState extends State<VideoCard> {
  late VideoPlayerController _controller;
  bool _isInitialized = false;
  bool _isMuted = true;

  @override
  void initState() {
    super.initState();
    _initializeController();
  }

  Future<void> _initializeController() async {
    _controller = VideoPlayerController.asset(widget.video.videoUrl);
    try {
      await _controller.initialize();
      _controller.setLooping(true);
      _controller.setVolume(0); // Start muted for autoplay
      if (mounted) {
        setState(() {
          _isInitialized = true;
        });
        if (widget.shouldPlay) {
          _controller.play();
        }
      }
    } catch (e) {
      debugPrint('Error initializing video: $e');
    }
  }

  @override
  void didUpdateWidget(VideoCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.shouldPlay != oldWidget.shouldPlay && _isInitialized) {
      if (widget.shouldPlay) {
        _controller.play();
      } else {
        _controller.pause();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleMute() {
    setState(() {
      _isMuted = !_isMuted;
      _controller.setVolume(_isMuted ? 0 : 1);
    });
  }

  void _togglePlay() {
    setState(() {
      if (_controller.value.isPlaying) {
        _controller.pause();
      } else {
        _controller.play();
      }
    });
  }

  void _enterFullScreen() {
    _controller.pause();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => _FullScreenVideoPlayer(
          videoUrl: widget.video.videoUrl,
          initialPosition: _controller.value.position,
        ),
      ),
    ).then((_) {
      // Resume when coming back if it was playing or should play
      if (widget.shouldPlay) {
        _controller.play();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final minutes = widget.video.duration.inMinutes;
    final seconds = widget.video.duration.inSeconds.remainder(60);
    final durationText = '$minutes:${seconds.toString().padLeft(2, '0')}';

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 30,
            offset: const Offset(0, 15),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Video Player or Thumbnail
            if (_isInitialized)
              GestureDetector(
                onTap: _togglePlay,
                child: VideoPlayer(_controller),
              )
            else
              Image.network(
                widget.video.thumbnailUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[300],
                    child: const Center(
                      child: Icon(Icons.videocam, size: 64, color: Colors.grey),
                    ),
                  );
                },
              ),

            // Overlay Gradient
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.6),
                    ],
                  ),
                ),
              ),
            ),

            // Controls
            if (_isInitialized) ...[
              // Top Controls (Mute & Fullscreen)
              Positioned(
                top: 16,
                right: 16,
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: _toggleMute,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.6),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          _isMuted ? Icons.volume_off : Icons.volume_up,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: _enterFullScreen,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.6),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.fullscreen,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              // Center Play/Pause Button
              Center(
                child: GestureDetector(
                  onTap: _togglePlay,
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: Icon(
                      _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                ),
              ),
            ],

            // Duration Badge (only if not initialized)
            if (!_isInitialized)
              Positioned(
                top: 16,
                right: 16,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    durationText,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),

            // Info Overlay
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.video.title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.visibility, color: Colors.white70, size: 16),
                        const SizedBox(width: 6),
                        Text(
                          widget.video.views,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.white70,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FullScreenVideoPlayer extends StatefulWidget {
  final String videoUrl;
  final Duration initialPosition;

  const _FullScreenVideoPlayer({
    required this.videoUrl,
    required this.initialPosition,
  });

  @override
  State<_FullScreenVideoPlayer> createState() => _FullScreenVideoPlayerState();
}

class _FullScreenVideoPlayerState extends State<_FullScreenVideoPlayer> {
  late VideoPlayerController _controller;
  bool _showControls = true;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(widget.videoUrl)
      ..initialize().then((_) {
        _controller.seekTo(widget.initialPosition);
        _controller.play();
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTap: () => setState(() => _showControls = !_showControls),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Center(
              child: _controller.value.isInitialized
                  ? AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(_controller),
                    )
                  : const CircularProgressIndicator(color: Colors.white),
            ),
            if (_showControls) ...[
              // Close Button
              Positioned(
                top: 40,
                left: 20,
                child: IconButton(
                  icon: const Icon(Icons.close, color: Colors.white, size: 30),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              // Play/Pause Button
              Center(
                child: IconButton(
                  icon: Icon(
                    _controller.value.isPlaying ? Icons.pause_circle_filled : Icons.play_circle_filled,
                    color: Colors.white,
                    size: 80,
                  ),
                  onPressed: () {
                    setState(() {
                      _controller.value.isPlaying ? _controller.pause() : _controller.play();
                    });
                  },
                ),
              ),
              // Progress Bar
              Positioned(
                bottom: 40,
                left: 20,
                right: 20,
                child: VideoProgressIndicator(
                  _controller,
                  allowScrubbing: true,
                  colors: VideoProgressColors(
                    playedColor: LandingConstants.primaryColor,
                    bufferedColor: Colors.white24,
                    backgroundColor: Colors.grey,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

