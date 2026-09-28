part of flutter_onboarding_slider;

class BackgroundController extends StatelessWidget {
  final int currentPage;
  final int totalPage;
  final Color? colorIsActive;
  final Color? colorIsNotActive;
  final bool indicatorAbove;
  final double indicatorPosition;
  final bool hasFloatingButton;
  final bool isTop;
  final IndicatorType indicatorType;

  BackgroundController({
    required this.currentPage,
    required this.totalPage,
    this.colorIsActive,
    this.colorIsNotActive,
    required this.indicatorAbove,
    required this.hasFloatingButton,
    required this.indicatorPosition,
    this.isTop = false,
    this.indicatorType = IndicatorType.circle,
  });

  @override
  Widget build(BuildContext context) {
    if (indicatorType == IndicatorType.line) {
      return _buildLineIndicator(context);
    }

    return Container(
      padding: EdgeInsets.only(
        top: isTop ? 8.0 : 0.0,
        bottom: isTop ? 8.0 : 10.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: _buildPageIndicator(context),
      ),
    );
  }

  /// Full-width segmented bar indicator (Figma: 476-1784).
  /// Each segment fills equal fraction of total width with 12px gaps.
  Widget _buildLineIndicator(BuildContext context) {
    const double gap = 12.0;
    const double height = 8.0;

    final List<Widget> children = [];
    for (int i = 0; i < totalPage; i++) {
      if (i > 0) children.add(const SizedBox(width: gap));
      final bool isActive = i == currentPage;
      children.add(
        Expanded(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOut,
            height: height,
            decoration: BoxDecoration(
              color: isActive
                  ? (colorIsActive ?? Colors.white)
                  : (colorIsNotActive ?? Colors.white.withValues(alpha: 0.4)),
              borderRadius: const BorderRadius.all(Radius.circular(8)),
            ),
          ),
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.only(
        left: 16.0,
        right: 16.0,
        top: isTop ? 8.0 : 0.0,
        bottom: isTop ? 8.0 : 10.0,
      ),
      child: Row(children: children),
    );
  }

  /// List of dot/bar indicators for circle, expanding, rectangle types.
  List<Widget> _buildPageIndicator(BuildContext context) {
    List<Widget> list = [];
    for (int i = 0; i < totalPage; i++) {
      list.add(
        i == currentPage
            ? _indicator(true, context)
            : _indicator(false, context),
      );
    }
    return list;
  }

  /// Dot indicator for circle / expanding / rectangle types.
  Widget _indicator(bool isActive, BuildContext context) {
    double width;
    double height;
    BorderRadius borderRadius;

    switch (indicatorType) {
      case IndicatorType.expanding:
        width = isActive ? 24.0 : 8.0;
        height = 8.0;
        borderRadius = const BorderRadius.all(Radius.circular(12));
        break;
      case IndicatorType.rectangle:
        width = isActive ? 24.0 : 8.0;
        height = 4.0;
        borderRadius = const BorderRadius.all(Radius.circular(4));
        break;
      case IndicatorType.line:
        // handled above in _buildLineIndicator
        width = 8.0;
        height = 8.0;
        borderRadius = const BorderRadius.all(Radius.circular(12));
        break;
      case IndicatorType.circle:
      default:
        width = 8.0;
        height = 8.0;
        borderRadius = const BorderRadius.all(Radius.circular(12));
        break;
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      margin: EdgeInsets.only(
        left: 4.0,
        right: 4.0,
        bottom: isTop ? 0.0 : (indicatorAbove ? indicatorPosition : 28.0),
      ),
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: isActive
            ? (colorIsActive ?? Colors.white)
            : (colorIsNotActive ?? Colors.white.withValues(alpha: 0.5)),
        borderRadius: borderRadius,
      ),
    );
  }
}
