// background.dart
part of flutter_onboarding_slider;

class Background extends StatelessWidget {
  final Widget child;
  final int totalPage;
  final List<Widget> background;
  final double speed;
  final double imageVerticalOffset;
  final double imageHorizontalOffset;
  final bool centerBackground;
  final List<Alignment> alignments;

  Background({
    required this.imageVerticalOffset,
    required this.child,
    required this.centerBackground,
    required this.totalPage,
    required this.background,
    required this.speed,
    required this.imageHorizontalOffset,
    this.alignments = const [],
  });

  @override
  Widget build(BuildContext context) {
    assert(background.length == totalPage);
    return Positioned.fill(
      child: Stack(
        children: [
          for (int i = 0; i < totalPage; i++)
            BackgroundImage(
              centerBackground: centerBackground,
              imageHorizontalOffset: imageHorizontalOffset,
              imageVerticalOffset: imageVerticalOffset,
              id: i + 1,
              speed: speed,
              background: background[i],
              alignment:
                  alignments.isNotEmpty ? alignments[i] : Alignment.center,
            ),
          child,
        ],
      ),
    );
  }
}
