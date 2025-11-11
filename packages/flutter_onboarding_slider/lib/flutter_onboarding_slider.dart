library flutter_onboarding_slider;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

part 'background.dart';
part 'background_body.dart';
part 'background_controller.dart';
part 'background_final_button.dart';
part 'background_image.dart';
part 'page_offset_provider.dart';

class OnBoardingSlider extends StatefulWidget {
  final int totalPage;
  final List<Widget> background;
  final double speed;
  final Color? pageBackgroundColor;
  final Gradient? pageBackgroundGradient;
  final Function? onFinish;
  final List<Widget> pageBodies;
  final FinishButtonStyle? finishButtonStyle;
  final String? finishButtonText;
  final TextStyle finishButtonTextStyle;
  final Color? controllerColor;
  final Color? controllerColorBold;
  final bool addButton;
  final bool centerBackground;
  final List<Alignment> backgroundImageAlignments;
  final bool addController;
  final double imageVerticalOffset;
  final double imageHorizontalOffset;
  final bool hasFloatingButton;
  final bool hasSkip;
  final bool showNextArrow;
  final bool showStartArrow;
  final Icon skipIcon;

  final IconData? startArrowIcon;

  final Color? arrowColor;

  final double arrowSize;

  final double arrowGap;

  OnBoardingSlider({
    required this.totalPage,
    required this.background,
    required this.speed,
    required this.pageBodies,
    this.onFinish,
    this.pageBackgroundColor,
    this.pageBackgroundGradient,
    this.finishButtonStyle,
    this.finishButtonText,
    this.controllerColor,
    this.controllerColorBold,
    this.addController = true,
    this.startArrowIcon,
    this.arrowColor,
    this.arrowSize = 20,
    this.arrowGap = 8,
    this.centerBackground = false,
    this.addButton = true,
    this.showNextArrow = false,
    this.showStartArrow = false,
    this.imageVerticalOffset = 0,
    this.imageHorizontalOffset = 0,
    this.hasFloatingButton = true,
    this.hasSkip = true,
    this.finishButtonTextStyle = const TextStyle(
      fontSize: 20,
      color: Colors.white,
    ),
    this.skipIcon = const Icon(Icons.arrow_forward, color: Colors.white),
    this.backgroundImageAlignments = const [],
  });

  @override
  _OnBoardingSliderState createState() => _OnBoardingSliderState();
}

class _OnBoardingSliderState extends State<OnBoardingSlider> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => PageOffsetNotifier(_pageController),
      child: Scaffold(
        backgroundColor:
            widget.pageBackgroundColor ??
            Theme.of(context).scaffoldBackgroundColor,
        body: Stack(
          children: [
            Background(
              centerBackground: widget.centerBackground,
              imageHorizontalOffset: widget.imageHorizontalOffset,
              imageVerticalOffset: widget.imageVerticalOffset,
              background: widget.background,
              speed: widget.speed,
              totalPage: widget.totalPage,
              alignments: widget.backgroundImageAlignments,
              child: SizedBox(),
            ),
            Stack(
              children: [
                // Content area yang bisa di-scroll
                BackgroundBody(
                  controller: _pageController,
                  function: slide,
                  totalPage: widget.totalPage,
                  bodies: widget.pageBodies,
                ),
                // Fixed bottom section untuk indicator dan button
                Positioned(
                  bottom: 20,
                  left: 0,
                  right: 0,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: SizedBox(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        spacing: 60,
                        children: [
                          if (widget.addController)
                            Padding(
                              padding: EdgeInsets.only(bottom: 10),
                              child: SizedBox(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: _buildPageIndicator(context),
                                ),
                              ),
                            ),
                          if (widget.hasFloatingButton)
                            BackgroundFinalButton(
                              buttonTextStyleFinish:
                                  widget.finishButtonTextStyle,
                              skipIcon: widget.skipIcon,
                              addButton: widget.addButton,
                              currentPage: _currentPage,
                              showNextArrow: widget.showNextArrow,
                              showStartArrow: widget.showStartArrow,
                              startArrowIcon: widget.startArrowIcon,
                              arrowColor: widget.arrowColor,
                              arrowSize: widget.arrowSize,
                              arrowGap: widget.arrowGap,
                              pageController: _pageController,
                              totalPage: widget.totalPage,
                              onPageFinish: widget.onFinish,
                              finishButtonStyle: widget.finishButtonStyle,
                              buttonText: widget.finishButtonText,
                              hasSkip: widget.hasSkip,
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildPageIndicator(BuildContext context) {
    List<Widget> list = [];
    for (int i = 0; i < widget.totalPage; i++) {
      list.add(
        i == _currentPage
            ? _indicatorBold(true, context)
            : _indicator(false, context),
      );
    }
    return list;
  }

  Widget _indicatorBold(bool isActive, BuildContext context) {
    final base = widget.controllerColor ?? Colors.white;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      height: 8.0,
      width: 8.0,
      decoration: BoxDecoration(
        color: isActive ? base : base.withOpacity(0.4),
        shape: BoxShape.circle,
      ),
    );
  }

  Widget _indicator(bool isActive, BuildContext context) {
    final base = widget.controllerColorBold ?? Colors.white;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      height: 8.0,
      width: 8.0,
      decoration: BoxDecoration(
        color: isActive ? base : base,
        shape: BoxShape.circle,
      ),
    );
  }

  void slide(int page) {
    setState(() {
      _currentPage = page;
    });
  }

  void _onSkip() {
    _pageController.jumpToPage(widget.totalPage - 1);
    setState(() {
      _currentPage = widget.totalPage - 1;
    });
  }
}
