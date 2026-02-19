part of flutter_onboarding_slider;

class FinishButtonStyle {
  final OutlinedBorder? shape;

  final double? elevation;
  final double? focusElevation;
  final double? hoverElevation;
  final double? highlightElevation;
  final double? disabledElevation;

  final Color? foregroundColor;
  final Color? backgroundColor;
  final Color? focusColor;
  final Color? hoverColor;
  final Color? splashColor;

  const FinishButtonStyle({
    this.shape = const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(30.0),
      ),
    ),
    this.elevation = 0,
    this.focusElevation,
    this.hoverElevation,
    this.highlightElevation,
    this.disabledElevation,
    this.foregroundColor,
    this.backgroundColor,
    this.focusColor,
    this.hoverColor,
    this.splashColor,
  });
}

class BackgroundFinalButton extends StatelessWidget {
  final int currentPage;
  final PageController pageController;
  final int totalPage;
  final bool addButton;
  final Function? onPageFinish;
  final TextStyle buttonTextStyle;
  final String? buttonText;
  final bool hasSkip;
  final Icon skipIcon;
  final FinishButtonStyle? finishButtonStyle;
  final String? nextButtonText;

  BackgroundFinalButton({
    required this.currentPage,
    required this.pageController,
    required this.totalPage,
    this.onPageFinish,
    this.buttonText,
    required this.buttonTextStyle,
    required this.addButton,
    required this.hasSkip,
    required this.skipIcon,
    this.finishButtonStyle = const FinishButtonStyle(),
    this.nextButtonText,
  });

  @override
  Widget build(BuildContext context) {
    if (!addButton) return const SizedBox.shrink();

    final bool isLastPage = currentPage == totalPage - 1;
    final String label =
        isLastPage ? (buttonText ?? 'Get Started') : (nextButtonText ?? 'Next');

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      child: SizedBox(
        width: double.infinity,
        height: 54,
        child: ElevatedButton(
          onPressed: () {
            if (isLastPage) {
              onPageFinish?.call();
            } else {
              _goToNextPage(context);
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor:
                finishButtonStyle?.backgroundColor ?? const Color(0xFF6B2D8B),
            foregroundColor: finishButtonStyle?.foregroundColor ?? Colors.white,
            elevation: finishButtonStyle?.elevation ?? 0,
            shape: finishButtonStyle?.shape ??
                const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
          ),
          child: Text(
            label,
            style: buttonTextStyle,
          ),
        ),
      ),
    );
  }

  /// Switch to Next Slide.
  void _goToNextPage(BuildContext context) {
    pageController.nextPage(
      duration: const Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  }
}
