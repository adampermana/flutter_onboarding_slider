// background_final_button.dart
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
      borderRadius: BorderRadius.all(Radius.circular(5.0)),
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
  final TextStyle buttonTextStyleFinish;
  final String? buttonText;
  final bool hasSkip;
  final Icon skipIcon;
  final FinishButtonStyle? finishButtonStyle;

  // ====== NEW: Arrow customization ======
  /// Tampilkan arrow di kanan label "Selanjutnya"
  final bool showNextArrow;

  /// Tampilkan arrow di kanan label "Start"
  final bool showStartArrow;

  /// Ikon panah untuk "Selanjutnya" (default: Icons.arrow_forward_rounded)
  final IconData? nextArrowIcon;

  /// Ikon panah untuk "Start" (default: Icons.arrow_forward_rounded)
  final IconData? startArrowIcon;

  /// Warna ikon panah (default mengikuti foregroundColor / text color)
  final Color? arrowColor;

  /// Ukuran ikon panah
  final double arrowSize;

  /// Jarak antara teks dan ikon
  final double arrowGap;

  BackgroundFinalButton({
    required this.currentPage,
    required this.pageController,
    required this.totalPage,
    this.onPageFinish,
    this.buttonText,
    required this.buttonTextStyleFinish,
    required this.buttonTextStyle,
    required this.addButton,
    required this.hasSkip,
    required this.skipIcon,
    this.finishButtonStyle = const FinishButtonStyle(),
    this.showNextArrow = false,
    this.showStartArrow = false,
    this.nextArrowIcon = Icons.arrow_forward_rounded,
    this.startArrowIcon = Icons.arrow_forward_rounded,
    this.arrowColor,
    this.arrowSize = 24,
    this.arrowGap = 8,
  });

  @override
  Widget build(BuildContext context) {
    final bool isFinishButton = currentPage == totalPage - 1;

    return addButton
        ? Container(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          width: MediaQuery.of(context).size.width - 60,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: finishButtonStyle?.shape,
              elevation: finishButtonStyle?.elevation ?? 0,
              foregroundColor:
                  isFinishButton
                      ? finishButtonStyle?.foregroundColor
                      : Colors.black,
              backgroundColor:
                  isFinishButton
                      ? finishButtonStyle?.backgroundColor
                      : Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 15),
            ),
            onPressed:
                () =>
                    isFinishButton
                        ? onPageFinish?.call()
                        : _goToNextPage(context),
            child:
                isFinishButton
                    ? _buildLabelWithArrow(
                      label: buttonText ?? "Start",
                      showArrow: showStartArrow,
                      iconData: startArrowIcon,
                      context: context,
                      textStyle: buttonTextStyleFinish,
                      isFinishButton: true,
                    )
                    : _buildLabelWithArrow(
                      label: "Selanjutnya",
                      showArrow: showNextArrow,
                      iconData: nextArrowIcon,
                      context: context,
                      textStyle: buttonTextStyle,
                      isFinishButton: false,
                    ),
          ),
        )
        : const SizedBox.shrink();
  }

  /// Builder label + arrow di kanan teks
  Widget _buildLabelWithArrow({
    required String label,
    required bool showArrow,
    required IconData? iconData,
    required BuildContext context,
    required TextStyle textStyle,
    required bool isFinishButton,
  }) {
    // Tentukan warna icon berdasarkan jenis button
    final Color iconColor;
    if (isFinishButton) {
      // Untuk finish button: gunakan arrowColor atau foregroundColor atau auto contrast
      final bg = finishButtonStyle?.backgroundColor;
      final autoContrast =
          (bg == null)
              ? Theme.of(context).colorScheme.onPrimary
              : (ThemeData.estimateBrightnessForColor(bg) == Brightness.dark
                  ? Colors.white
                  : Colors.black87);
      iconColor =
          arrowColor ?? finishButtonStyle?.foregroundColor ?? autoContrast;
    } else {
      // Untuk next button: gunakan arrowColor atau default hitam
      iconColor = arrowColor ?? Colors.black;
    }

    // Jika tidak tampilkan arrow, return text saja
    if (!showArrow || iconData == null) {
      return Center(
        child: Text(label, style: textStyle, textAlign: TextAlign.center),
      );
    }

    // Tampilkan text + arrow
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(label, style: textStyle),
          SizedBox(width: arrowGap),
          Icon(iconData, size: arrowSize, color: iconColor),
        ],
      ),
    );
  }

  void _goToNextPage(BuildContext context) {
    pageController.nextPage(
      duration: const Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  }
}
