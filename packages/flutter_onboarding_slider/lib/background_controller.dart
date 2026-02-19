part of flutter_onboarding_slider;

class BackgroundController extends StatelessWidget {
  final int currentPage;
  final int totalPage;
  final Color? controllerColor;
  final bool indicatorAbove;
  final double indicatorPosition;
  final bool hasFloatingButton;

  BackgroundController({
    required this.currentPage,
    required this.totalPage,
    required this.controllerColor,
    required this.indicatorAbove,
    required this.hasFloatingButton,
    required this.indicatorPosition,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: _buildPageIndicator(context),
      ),
    );
  }

  /// List of the slides Indicators.
  List<Widget> _buildPageIndicator(BuildContext context) {
    List<Widget> list = [];
    for (int i = 0; i < totalPage; i++) {
      list.add(i == currentPage
          ? _indicator(true, context)
          : _indicator(false, context));
    }
    return list;
  }

  /// Slide Controller / Indicator.
  Widget _indicator(bool isActive, BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      height: 8.0,
      width: isActive ? 24.0 : 8.0,
      decoration: BoxDecoration(
        color: isActive
            ? controllerColor ?? const Color(0xFF6B2D8B)
            : (controllerColor ?? const Color(0xFF6B2D8B)).withOpacity(0.3),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }
}
