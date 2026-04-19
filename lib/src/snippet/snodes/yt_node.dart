// ignore_for_file: constant_identifier_names
import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/material.dart';
import 'package:fsdui/fsdui.dart';
import 'package:fsdui/src/snippet/pnodes/decimal_pnode.dart';
import 'package:fsdui/src/snippet/pnodes/fyi_pnodes.dart';
import 'package:fsdui/src/snippet/pnodes/int_pnode.dart';
import 'package:fsdui/src/snippet/pnodes/string_pnode.dart';
import 'package:fsdui/src/snippet/snodes/iframe/iframe.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';

// import 'package:youtube_player_iframe/youtube_player_iframe.dart';

part 'yt_node.mapper.dart';

@MappableClass()
class YTNode extends CL with YTNodeMappable {
  String ytEmbedHtml;
  double scale;

  YTNode({
    super.name,
    this.ytEmbedHtml =
        '<iframe width="560" height="315" src="https://www.youtube.com/embed/u1FAoLEG16c?si=YN1UucqLyPLntjYJ" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>',
    this.scale = 1.0,
    // this.iframeWidth = 560, // not 595?
    // this.iframeHeight = 316, // not 842?
  });

  @override
  List<PNode> propertyNodes(BuildContext context, SNode? parentSNode) => [
    FlutterDocPNode(
      buttonLabel: 'IFrame',
      webLink: 'https://pub.dev/packages/webview_flutter_web',
      snode: this,
      name: 'fyi',
    ),
    StringPNode(
      snode: this,
      name: 'Youtube Url',
      stringValue: ytEmbedHtml,
      onStringChange: (newValue) => refreshWithUpdate(
        context,
        () => ytEmbedHtml = newValue ?? ytEmbedHtml,
      ),
      calloutButtonSize: const Size(280, 20),
      calloutWidth: 280,
    ),
    DecimalPNode(
      snode: this,
      name: 'starts (secs)',
      decimalValue: scale,
      onDoubleChange: (newValue) =>
          refreshWithUpdate(context, () => scale = newValue ?? 1.0),
      calloutButtonSize: const Size(120, 20),
    ),
  ];

  @override
  Widget build(BuildContext context, SNode? parentNode) {
    try {
      setParent(parentNode); // propagating parents down from root
      //ScrollControllerName? scName = EditablePage.name(context);
      //possiblyHighlightSelectedNode(scName);
      // final ytId = getIdFromUrl(ytUrl??'') ?? 'zWh3CShX_do';
      // final controller = YoutubePlayerController.fromVideoId(
      //   videoId: ytId,
      //   autoPlay: false,
      //   params: const YoutubePlayerParams(showFullscreenButton: true),
      // );
      // Extract width, height, src URL and optional start/end from ytEmbedHtml.
      final wMatch = RegExp(r"""width=["'](\d+)["']""").firstMatch(ytEmbedHtml);
      final double w = double.tryParse(wMatch?.group(1) ?? '') ?? 560;

      final hMatch = RegExp(r"""height=["'](\d+)["']""").firstMatch(ytEmbedHtml);
      final double h = double.tryParse(hMatch?.group(1) ?? '') ?? 316;

      final srcMatch = RegExp(r"""src=["']([^"']+)["']""").firstMatch(ytEmbedHtml);
      final String srcUrl = srcMatch?.group(1) ?? '';
      final uri = Uri.tryParse(srcUrl.replaceAll('&amp;', '&'));
      final int? start = int.tryParse(uri?.queryParameters['start'] ?? '');
      final int? end = int.tryParse(uri?.queryParameters['end'] ?? '');

      String embedUrl = srcUrl;
      if (start != null) embedUrl += '&amp;start=$start';
      if (end != null) embedUrl += '&amp;end=$end';
      embedUrl += '&amp;rel=0';

      return SizedBox(
        width: w,
        height: h,
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: fsdui.canEditAnyContent()
              ? Stack(
                  children: [
                    IFrame(
                      key: createNodeWidgetGK(),
                      src: embedUrl,
                      iframeW: w * scale,
                      iframeH: h * scale,
                    ),
                    Positioned.fill(
                      child: PointerInterceptor(child: SizedBox.expand()),
                    ),
                  ],
                )
              : IFrame(
                  key: createNodeWidgetGK(),
                  src: embedUrl,
                  iframeW: w * scale,
                  iframeH: h * scale,
                ),
        ),
      );
    } catch (e) {
      return Error(
        key: createNodeWidgetGK(),
        FLUTTER_TYPE,
        color: Colors.red,
        size: 16,
        errorMsg: e.toString(),
      );
    }

    // YoutubePlayer(
    // key: createNodeGK(),
    // controller: controller,
    // aspectRatio: 16 / 9,
    // );
  }

  String? extractUrlFromIframe(String? iframeTag) {
    if (iframeTag == null) return null;
    RegExp exp = RegExp(r'(?:(?:https?|ftp):\/\/)?[\w/\-?=%.]+\.[\w/\-?=%.]+');
    Iterable<RegExpMatch> matches = exp.allMatches(iframeTag);
    return matches.first.group(0);
  }

  // @override
  // String toSource(BuildContext context) {
  //   return '''YT($YT)''';
  // }

  @override
  Widget? widgetLogo() =>
      Image.asset(fsdui.asset('lib/assets/images/pub.dev.png'), width: 16);

  @override
  String toString() => FLUTTER_TYPE;

  static const String FLUTTER_TYPE = "YT";
}
