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
    required this.buttonTextStyle,
    required this.addButton,
    required this.hasSkip,
    required this.skipIcon,
    this.finishButtonStyle = const FinishButtonStyle(),

    // defaults (boleh diubah sesuai preferensi)
    this.showNextArrow = false,
    this.showStartArrow = false,
    this.nextArrowIcon = Icons.arrow_forward_rounded,
    this.startArrowIcon = Icons.arrow_forward_rounded,
    this.arrowColor,
    this.arrowSize = 20,
    this.arrowGap = 8,
  });

  @override
  Widget build(BuildContext context) {
    return addButton
        ? Container(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          width: MediaQuery.of(context).size.width - 60,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: finishButtonStyle?.shape,
              elevation: finishButtonStyle?.elevation ?? 0,
              foregroundColor: finishButtonStyle?.foregroundColor,
              backgroundColor: finishButtonStyle?.backgroundColor,
              padding: const EdgeInsets.symmetric(vertical: 15),
            ),
            onPressed:
                () =>
                    currentPage == totalPage - 1
                        ? onPageFinish?.call()
                        : _goToNextPage(context),
            child:
                currentPage == totalPage - 1
                    ? _buildLabelWithArrow(
                      label: buttonText ?? "Start",
                      showArrow: showStartArrow,
                      iconData: startArrowIcon,
                      context: context,
                    )
                    : _buildLabelWithArrow(
                      label: "Selanjutnya",
                      showArrow: showNextArrow,
                      iconData: nextArrowIcon,
                      context: context,
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
  }) {
    // Warna ikon prioritas:
    // 1) arrowColor (jika di-set)
    // 2) finishButtonStyle.foregroundColor (jika ada)
    // 3) kontras otomatis dari background tombol
    final bg = finishButtonStyle?.backgroundColor;
    final autoContrast =
        (bg == null)
            ? Theme.of(context).colorScheme.onPrimary
            : (ThemeData.estimateBrightnessForColor(bg) == Brightness.dark
                ? Colors.white
                : Colors.black87);
    final Color resolvedIconColor =
        arrowColor ?? finishButtonStyle?.foregroundColor ?? autoContrast;

    // Jika tak ingin panah → teks saja
    if (!showArrow || iconData == null) {
      return Center(
        child: Text(label, style: buttonTextStyle, textAlign: TextAlign.center),
      );
    }

    // Row dibungkus Center agar konten benar-benar center di tombol lebar
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(label, style: buttonTextStyle),
          SizedBox(width: arrowGap),
          Icon(iconData, size: arrowSize, color: resolvedIconColor),
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
