import 'package:flutter/material.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:permission_handler/permission_handler.dart';

// Replace with your actual App ID and token from Agora Console
const String appId = '3a3600537b0e4fd8b3f432c54af8a6ff';
const String channelName = 'career_channel';
const String token =
    '007eJxTYAgz0pzSZtZxcdnaT5diGqxtfJlTle7/yZKNu3FeWnRuLqsCg3GisZmBgamxeZJBqklaikWScZqJsVGyqUlimkWiWVraq/8lGQ2BjAzzmHlZGBkgEMTnY0hOLEpNLYpPzkjMy0vNYWAAADdhIkQ=';

class VideoCallPage extends StatefulWidget {
  const VideoCallPage({super.key});

  @override
  State<VideoCallPage> createState() => _VideoCallPageState();
}

class _VideoCallPageState extends State<VideoCallPage> {
  int? _remoteUid;
  late final RtcEngine _engine;
  bool _isEngineReady = false;
  late final int _localUid;

  @override
  void initState() {
    super.initState();
    _localUid = DateTime.now().millisecondsSinceEpoch % 100000;
    initAgora();
  }

  Future<void> initAgora() async {
    // Request permissions
    await [Permission.camera, Permission.microphone].request();

    _engine = createAgoraRtcEngine();
    await _engine.initialize(
      const RtcEngineContext(
        appId: appId,
        channelProfile: ChannelProfileType.channelProfileCommunication,
      ),
    );

    await _engine.enableVideo();

    _engine.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (connection, elapsed) {
          debugPrint('✅ Local user joined with UID: ${connection.localUid}');
        },
        onUserJoined: (connection, remoteUid, elapsed) {
          debugPrint('👤 Remote user joined: $remoteUid');
          setState(() => _remoteUid = remoteUid);
        },
        onUserOffline: (connection, remoteUid, reason) {
          debugPrint('❌ Remote user left: $remoteUid');
          setState(() => _remoteUid = null);
        },
      ),
    );

    await _engine.joinChannel(
      token: token,
      channelId: channelName,
      uid: _localUid,
      options: const ChannelMediaOptions(),
    );

    setState(() => _isEngineReady = true);
  }

  @override
  void dispose() {
    _engine.leaveChannel();
    _engine.disableVideo();
    _engine.release();
    super.dispose();
  }

  Widget _renderLocalPreview() {
    if (!_isEngineReady) {
      return const Center(child: CircularProgressIndicator());
    }

    return AgoraVideoView(
      controller: VideoViewController(
        rtcEngine: _engine,
        canvas: VideoCanvas(uid: _localUid),
      ),
    );
  }

  Widget _renderRemoteVideo() {
    if (!_isEngineReady) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_remoteUid != null) {
      return AgoraVideoView(
        controller: VideoViewController.remote(
          rtcEngine: _engine,
          canvas: VideoCanvas(uid: _remoteUid),
          connection: const RtcConnection(channelId: channelName),
        ),
      );
    } else {
      return const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 12),
            Text(
              'Waiting for other user to join...',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Video Interaction'),
        backgroundColor: const Color(0xFF6A1B9A),
      ),
      body: Stack(
        children: [
          _renderRemoteVideo(),
          Positioned(
            top: 20,
            left: 20,
            child: SizedBox(
              width: 120,
              height: 160,
              child: _renderLocalPreview(),
            ),
          ),
        ],
      ),
    );
  }
}
