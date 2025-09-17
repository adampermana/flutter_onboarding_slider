// background_controller.dart
part of flutter_onboarding_slider;

class BackgroundController extends StatelessWidget {
  final int currentPage;
  final int totalPage;
  final Color? controllerColor;

  BackgroundController({
    required this.currentPage,
    required this.totalPage,
    required this.controllerColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: _buildPageIndicator(context),
      ),
    );
  }

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

  Widget _indicator(bool isActive, BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 4.0),
      height: 8.0,
      width: isActive ? 28.0 : 8.0,
      decoration: BoxDecoration(
        color:
            isActive
                ? controllerColor ?? Colors.white
                : (controllerColor ?? Colors.white).withOpacity(0.5),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }
}
