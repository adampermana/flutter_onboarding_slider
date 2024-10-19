import 'package:flutter/material.dart';
import 'package:flutter_onboarding_slider/page_offset_provider.dart';
import 'package:provider/provider.dart';

class BackgroundImage extends StatelessWidget {
  final int id;
  final Widget background;
  final double imageVerticalOffset;
  final double speed;
  final double imageHorizontalOffset;
  final bool centerBackground;
  final Alignment alignment;

  BackgroundImage({
    required this.id,
    required this.speed,
    required this.background,
    required this.imageVerticalOffset,
    required this.centerBackground,
    required this.imageHorizontalOffset,
    this.alignment = Alignment.center,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<PageOffsetNotifier>(
      builder: (context, notifier, child) {
        return Stack(children: [
          Positioned(
            top: imageVerticalOffset,
            left: MediaQuery.of(context).size.width * ((id - 1) * speed) -
                speed * notifier.offset +
                (centerBackground ? 0 : imageHorizontalOffset),
            child: centerBackground
                ? Container(
                    width: MediaQuery.of(context).size.width,
                    child: Align(
                      alignment: alignment,
                      child: child!,
                    ),
                  )
                : Align(
                    alignment: alignment,
                    child: child!,
                  ),
          ),
        ]);
      },
      child: Container(
        child: background,
      ),
    );
  }
}
