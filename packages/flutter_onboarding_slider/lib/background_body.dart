part of flutter_onboarding_slider;

class BackgroundBody extends StatelessWidget {
  final PageController controller;
  final Function function;
  final int totalPage;
  final List<Widget> bodies;

  BackgroundBody({
    required this.controller,
    required this.function,
    required this.totalPage,
    required this.bodies,
  });

  @override
  Widget build(BuildContext context) {
    assert(bodies.length == totalPage);
    return PageView(
      physics: ClampingScrollPhysics(),
      controller: controller,
      onPageChanged: (value) {
        function(value);
      },
      children: bodies,
    );
  }
}
