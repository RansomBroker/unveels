import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';

import '../../../../shared/configs/size_config.dart';
import '../../../../shared/extensions/context_parsing.dart';
import '../../../../shared/extensions/live_step_parsing.dart';
import '../../../../shared/widgets/buttons/button_widget.dart';
import '../../../../shared/widgets/clippers/face_clipper.dart';
import '../../../../shared/widgets/lives/bottom_copyright_widget.dart';
import '../../../../shared/widgets/lives/live_widget.dart';
import '../../../find_the_look/presentation/pages/ftl_live_page.dart';
import '../widgets/stf_shades_widget.dart';


class STFLivePage extends StatefulWidget {
  const STFLivePage({
    super.key,
  });

  @override
  State<STFLivePage> createState() => _STFLivePageState();
}

class _STFLivePageState extends State<STFLivePage> {
  late LiveStep step;
  final GlobalKey webViewKey = GlobalKey();
  InAppWebViewController? webViewController;
  InAppWebViewSettings settings = InAppWebViewSettings(
      isInspectable: true,
      mediaPlaybackRequiresUserGesture: false,
      allowsInlineMediaPlayback: true,
      iframeAllow: "camera; microphone",
      iframeAllowFullscreen: true,
      javaScriptEnabled: true);

  bool _isShowShades = false;
  bool _isScanned = false;

  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() {
    // default step
    step = LiveStep.photoSettings;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          InAppWebView(
            key: webViewKey,
            initialUrlRequest: URLRequest(url: WebUri("https://66f651491465eddb3c106d3e--grand-cat-98da21.netlify.app/")),
            initialSettings: settings,
            onWebViewCreated: (controller) {
              webViewController = controller;
            },
            onPermissionRequest: (controller, request) async {
              return PermissionResponse(
                  resources: request.resources,
                  action: PermissionResponseAction.GRANT);
            },
            onLoadStop: (controller, url) async {
              print(url);
            },

          ),
          PointerInterceptor(child: BottomCopyrightWidget(
            child: _isScanned ? Column(
              children: [
                ButtonWidget(
                  text: 'SHOW SHADES',
                  width: context.width / 2,
                  backgroundColor: Colors.black,
                  onTap: _onShowShades,
                ),
              ],
            ) : SizedBox.shrink()
          ))
        ],
      ),
    );
  }

  Widget get _buildBody {
    /*
    * ubah step ke step berikutnya untuk melanjutkan e.g LiveStep.ScanningFace jika di perlukan
    * */
    switch (step) {
      case LiveStep.photoSettings:
        return Stack(
          alignment: Alignment.bottomCenter,
          children: [
            InAppWebView(
              key: webViewKey,
              initialUrlRequest: URLRequest(url: WebUri("https://66f651491465eddb3c106d3e--grand-cat-98da21.netlify.app/")),
              initialSettings: settings,
              onWebViewCreated: (controller) {
                webViewController = controller;
              },
              onPermissionRequest: (controller, request) async {
                return PermissionResponse(
                    resources: request.resources,
                    action: PermissionResponseAction.GRANT);
              },
            ),
            PointerInterceptor(child: BottomCopyrightWidget(
              child: Column(
                children: [
                  ButtonWidget(
                    text: 'SHOW SHADES',
                    width: context.width / 2,
                    backgroundColor: Colors.black,
                    onTap: _onShowShades,
                  ),
                ],
              ),
            ))
          ],
        );
      case LiveStep.scanningFace:
        // show oval face container
        return const SizedBox.shrink();
      case LiveStep.scannedFace:
        if (_isShowShades) {
          return const BottomCopyrightWidget(
            child: SizedBox.shrink(),
          );
        }

        return BottomCopyrightWidget(
          child: Column(
            children: [
              ButtonWidget(
                text: 'SHOW SHADES',
                width: context.width / 2,
                backgroundColor: Colors.black,
                onTap: _onShowShades,
              ),
            ],
          ),
        );
      case LiveStep.makeup:
        return const SizedBox.shrink();
    }
  }

  Future<void> _onShowShades() async {
    // show analysis results
    setState(() {
      _isShowShades = true;
    });

    // show bottom sheet
    await showModalBottomSheet<bool?>(
      context: context,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.transparent,
      elevation: 0,
      builder: (context) {
        return const Padding(
          padding: EdgeInsets.only(
            bottom: SizeConfig.bottomLiveMargin,
          ),
          child: SafeArea(
            bottom: true,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                STFShadesWidget(),
              ],
            ),
          ),
        );
      },
    );

    // hide analysis results
    setState(() {
      _isShowShades = false;
    });
  }
}
