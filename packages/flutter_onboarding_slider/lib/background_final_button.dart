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
  });

  @override
  Widget build(BuildContext context) {
    return addButton
        ? Container(
          padding: EdgeInsets.symmetric(horizontal: 30),
          width: MediaQuery.of(context).size.width - 60,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: finishButtonStyle?.shape,
              elevation: finishButtonStyle?.elevation ?? 0,
              foregroundColor: finishButtonStyle?.foregroundColor,
              backgroundColor: finishButtonStyle?.backgroundColor,
              padding: EdgeInsets.symmetric(vertical: 15),
            ),
            onPressed:
                () =>
                    currentPage == totalPage - 1
                        ? onPageFinish?.call()
                        : _goToNextPage(context),
            child:
                currentPage == totalPage - 1
                    ? Text(buttonText ?? "Start", style: buttonTextStyle)
                    : Text("Selanjutnya", style: buttonTextStyle),
          ),
        )
        : SizedBox.shrink();
  }

  void _goToNextPage(BuildContext context) {
    pageController.nextPage(
      duration: Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  }
}
