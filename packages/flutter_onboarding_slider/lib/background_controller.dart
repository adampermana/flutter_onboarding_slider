part of flutter_onboarding_slider;

class BackgroundController extends StatelessWidget {
  final int currentPage;
  final int totalPage;
  final Color? colorIsActive;
  final Color? colorIsNotActive;
  final bool indicatorAbove;
  final double indicatorPosition;
  final bool hasFloatingButton;

  BackgroundController({
    required this.currentPage,
    required this.totalPage,
    this.colorIsActive,
    this.colorIsNotActive,
    required this.indicatorAbove,
    required this.hasFloatingButton,
    required this.indicatorPosition,
  });

  @override
  Widget build(BuildContext context) {
    return indicatorAbove
        ? Container(
            padding: EdgeInsets.only(bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _buildPageIndicator(context),
            ),
          )
        : Container(
            padding: EdgeInsets.only(bottom: 10),
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
      list.add(
        i == currentPage
            ? _indicator(true, context)
            : _indicator(false, context),
      );
    }
    return list;
  }

  /// Slide Controller / Indicator.
  Widget _indicator(bool isActive, BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.only(
        left: 8.0,
        right: 8.0,
        bottom: indicatorAbove ? indicatorPosition : 28,
      ),
      height: 8.0,
      width: 2.0,
      decoration: BoxDecoration(
        color: isActive
            ? colorIsActive ?? Colors.white
            : colorIsNotActive ?? Colors.white.withOpacity(0.5),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }
}
