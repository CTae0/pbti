import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:share_plus/share_plus.dart';

/// RepaintBoundary로 감싼 위젯을 PNG 이미지로 캡처하여 공유한다.
class ShareService {
  ShareService._();

  static Future<void> shareBoundaryAsImage({
    required GlobalKey boundaryKey,
    required String fileName,
    String? shareText,
  }) async {
    final boundary =
        boundaryKey.currentContext?.findRenderObject() as RenderRepaintBoundary?;
    if (boundary == null) {
      throw StateError('RepaintBoundary를 찾을 수 없습니다.');
    }

    // 고해상도 캡처 (웹/레티나 대응)
    final image = await boundary.toImage(pixelRatio: 2.5);
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    if (byteData == null) {
      throw StateError('이미지 인코딩에 실패했습니다.');
    }

    final Uint8List pngBytes = byteData.buffer.asUint8List();

    await Share.shareXFiles(
      [XFile.fromData(pngBytes, name: fileName, mimeType: 'image/png')],
      text: shareText,
    );
  }

  /// 이미지 없이 텍스트와 링크만 공유한다.
  static Future<void> shareText(String text) async {
    await Share.share(text);
  }
}
