part of flutter_onboarding_slider;

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
        double screenWidth = MediaQuery.of(context).size.width;
        double screenHeight = MediaQuery.of(context).size.height;
        double offset = notifier.offset;
        double pagePosition = (id - 1) * screenWidth - offset;

        return Positioned(
          top: 0,
          left: pagePosition,
          child: SizedBox(
            width: screenWidth,
            height: screenHeight,
            child: child!,
          ),
        );
      },
      child: ClipRect(
        child: SizedBox.expand(
          child: FittedBox(
            fit: BoxFit.cover,
            alignment: alignment,
            child: background,
          ),
        ),
      ),
    );
  }
}
