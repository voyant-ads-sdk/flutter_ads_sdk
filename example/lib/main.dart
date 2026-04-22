import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ads_sdk/flutter_ads_sdk.dart';
import 'package:media_kit/media_kit.dart';
import 'previews/mini_native_preview.dart';
import 'previews/native_fullscreen_preview.dart';
import 'previews/native_preview.dart';
import 'previews/rewarding_preview.dart';
import 'previews/video_embedded_preview.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MediaKit.ensureInitialized();
  // DEMO KEYS USED
  await FlutterAds.instance.ensureInitialized(
    accountId: "00000000036c256b",
    appId: '00000000033f35e5',
    apiKey: '9a444ccfda2f2db31d103868a8e1b2f8',
    sdkSecret:
        '46a18ed8bde9d0131ee22c0ed2fb41b54effec0bcffa71b8cb6c08a3edcf0927',
  );
  FlutterAds.instance.addDummyData();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<Uint8List> loadAssetBytes(String assetKey) async {
    final ByteData data = await rootBundle.load(assetKey);
    return data.buffer.asUint8List();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Builder(
        // ✅ IMPORTANT
        builder: (context) {
          return Scaffold(
            appBar: AppBar(title: const Text('Flutter Ads Example')),
            body: HomePageWidget(),
            //body: VideoPlayerPage(),
          );
        },
      ),
    );
  }
}

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({super.key});

  @override
  State<HomePageWidget> createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  @override
  Widget build(BuildContext context) {
    FlutterAds.instance.enableAutoFetch(context);
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextButton(
            child: const Text('SHOW miniNative'),
            onPressed: () async {
              await FlutterAds.instance.ensureAdsAvailable(
                adType: AdType.miniNative,
              );
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => MiniNativeAdPreview()),
              );
            },
          ),

          TextButton(
            child: const Text('SHOW native'),
            onPressed: () async {
              await FlutterAds.instance.ensureAdsAvailable(
                adType: AdType.native,
              );
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => NativeAdPreview()),
              );
            },
          ),

          TextButton(
            child: const Text('SHOW nativeFullscreen'),
            onPressed: () async {
              await FlutterAds.instance.ensureAdsAvailable(
                adType: AdType.nativeFullscreen,
              );
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => NativeFullScreenAdPreview()),
              );
            },
          ),

          TextButton(
            child: const Text('SHOW rewarding'),
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => RewardingAdPreview()),
              );
            },
          ),

          TextButton(
            child: const Text('SHOW videoEmbedded'),
            onPressed: () async {
              await FlutterAds.instance.ensureAdsAvailable(
                adType: AdType.videoEmbedded,
              );
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => VideoEmbeddedAdPreview()),
              );
            },
          ),
        ],
      ),
    );
  }
}
