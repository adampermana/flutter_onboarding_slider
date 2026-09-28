part of flutter_onboarding_slider;

class OnBoardingNavigationBar extends StatelessWidget
    implements PreferredSizeWidget {
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
  Size get preferredSize => const Size.fromHeight(44);

  @override
  Widget build(BuildContext context) {
    final Widget trailingWidget;
    if (currentPage == totalPage - 1) {
      trailingWidget = finishButton == null
          ? const SizedBox.shrink()
          : TextButton(
              onPressed: () => onFinish?.call(),
              child: finishButton!,
            );
    } else {
      trailingWidget = skipTextButton == null
          ? const SizedBox.shrink()
          : TextButton(
              onPressed: () {
                if (skipFunctionOverride == null) {
                  onSkip();
                } else {
                  skipFunctionOverride!();
                }
              },
              child: skipTextButton!,
            );
    }

    return Container(
      height: 44,
      color: headerBackgroundColor,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          leading ?? const SizedBox.shrink(),
          if (middle != null) middle!,
          trailingWidget,
        ],
      ),
    );
  }
}
