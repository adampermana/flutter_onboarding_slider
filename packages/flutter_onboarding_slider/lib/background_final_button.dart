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

/// Style for the slide / next button shown on non-last pages.
class SlideButtonStyle {
  /// Background color. Default: `rgba(255,255,255,0.08)`.
  final Color? backgroundColor;

  /// Border color. Default: `rgba(232,232,232,0.16)`.
  final Color? borderColor;

  /// Border width. Default: `1.0`.
  final double? borderWidth;

  /// Corner radius. Default: `12.0`.
  final double? borderRadius;

  /// Text / foreground color. Default: `Colors.white`.
  final Color? foregroundColor;

  const SlideButtonStyle({
    this.backgroundColor,
    this.borderColor,
    this.borderWidth,
    this.borderRadius,
    this.foregroundColor,
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

  /// Custom style for the slide / next button.
  final SlideButtonStyle? slideButtonStyle;

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
    this.slideButtonStyle,
  });

  @override
  Widget build(BuildContext context) {
    if (!addButton) return const SizedBox.shrink();

    final bool isLastPage = currentPage == totalPage - 1;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
      child: SizedBox(
        width: double.infinity,
        height: 48,
        child: isLastPage ? _buildFinishButton() : _buildSlideButton(context),
      ),
    );
  }

  /// Finish button (489:3082): bg #007D56, radius 14, padding 24x16.
  Widget _buildFinishButton() {
    final String label = buttonText ?? 'Get Started';
    return Material(
      color: finishButtonStyle?.backgroundColor ?? const Color(0xFF007D56),
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: () => onPageFinish?.call(),
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Text(
            label,
            style: buttonTextStyle.copyWith(
              fontSize: buttonTextStyle.fontSize ?? 15,
              fontWeight: buttonTextStyle.fontWeight ?? FontWeight.bold,
              color: buttonTextStyle.color ?? Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  /// Slide / next button (489:3085): customizable via [slideButtonStyle].
  Widget _buildSlideButton(BuildContext context) {
    final String label = nextButtonText ?? 'Next';
    final double radius = slideButtonStyle?.borderRadius ?? 12.0;
    final Color bgColor = slideButtonStyle?.backgroundColor ??
        Colors.white.withValues(alpha: 0.08);
    final Color borderColor = slideButtonStyle?.borderColor ??
        const Color(0xFFE8E8E8).withValues(alpha: 0.16);
    final double borderWidth = slideButtonStyle?.borderWidth ?? 1.0;
    final Color textColor = slideButtonStyle?.foregroundColor ??
        buttonTextStyle.color ??
        Colors.white;

    return Material(
      color: bgColor,
      borderRadius: BorderRadius.circular(radius),
      child: InkWell(
        borderRadius: BorderRadius.circular(radius),
        onTap: () => _goToNextPage(context),
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              side: BorderSide(
                width: borderWidth,
                color: borderColor,
              ),
              borderRadius: BorderRadius.circular(radius),
            ),
          ),
          child: Text(
            label,
            style: buttonTextStyle.copyWith(
              fontSize: buttonTextStyle.fontSize ?? 15,
              fontWeight: buttonTextStyle.fontWeight ?? FontWeight.bold,
              color: textColor,
            ),
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
