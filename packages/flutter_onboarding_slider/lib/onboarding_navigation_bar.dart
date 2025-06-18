part of flutter_onboarding_slider;

class OnBoardingNavigationBar extends StatelessWidget
    implements ObstructingPreferredSizeWidget {
  final int currentPage;
  final Function onSkip;
  final int totalPage;
  final Function? onFinish;
  final Widget? finishButton;
  final Widget? skipTextButton;
  final Color headerBackgroundColor;
  final Widget? leading;
  final Widget? middle;
  final Function? skipFunctionOverride;

  OnBoardingNavigationBar({
    required this.currentPage,
    required this.onSkip,
    required this.headerBackgroundColor,
    required this.totalPage,
    this.onFinish,
    this.finishButton,
    this.skipTextButton,
    this.leading,
    this.middle,
    this.skipFunctionOverride,
  });

  @override
  Size get preferredSize => Size.fromHeight(40);

  @override
  bool shouldFullyObstruct(BuildContext context) {
    return true;
  }

  @override
  Widget build(BuildContext context) {
    if (hideNavigationBar) return SizedBox.shrink();

    return Container(
      height: preferredSize.height + MediaQuery.of(context).padding.top,
      decoration: BoxDecoration(
        color: headerBackgroundColor,
        border: Border(
          bottom: BorderSide(color: Colors.transparent),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Leading widget
              leading ?? SizedBox(),

              // Middle widget
              Expanded(
                child: Center(
                  child: middle ?? SizedBox.shrink(),
                ),
              ),

              // Trailing widget
              SizedBox(
                width: 44,
                child: currentPage == totalPage - 1
                    ? finishButton == null
                        ? SizedBox.shrink()
                        : TextButton(
                            onPressed: () => onFinish?.call(),
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              minimumSize: Size.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: finishButton!,
                          )
                    : skipTextButton == null
                        ? SizedBox.shrink()
                        : TextButton(
                            onPressed: () {
                              if (skipFunctionOverride == null) {
                                onSkip();
                              } else {
                                skipFunctionOverride!();
                              }
                            },
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              minimumSize: Size.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: skipTextButton!,
                          ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool get hideNavigationBar {
    if (currentPage == totalPage - 1) {
      return finishButton == null;
    }
    return skipTextButton == null;
  }
}
