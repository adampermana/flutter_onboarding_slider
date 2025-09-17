library flutter_onboarding_slider;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

part 'background_body.dart';
part 'background_controller.dart';
part 'background_final_button.dart';
part 'background_image.dart';
part 'background.dart';
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
  final bool addButton;
  final bool centerBackground;
  final List<Alignment> backgroundImageAlignments;
  final bool addController;
  final double imageVerticalOffset;
  final double imageHorizontalOffset;
  final bool hasFloatingButton;
  final bool hasSkip;
  final Icon skipIcon;

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
    this.addController = true,
    this.centerBackground = false,
    this.addButton = true,
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
                  bottom: 10,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (widget.addController)
                          Container(
                            padding: EdgeInsets.only(bottom: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: _buildPageIndicator(context),
                            ),
                          ),
                        if (widget.hasFloatingButton)
                          BackgroundFinalButton(
                            buttonTextStyle: widget.finishButtonTextStyle,
                            skipIcon: widget.skipIcon,
                            addButton: widget.addButton,
                            currentPage: _currentPage,
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
                ? widget.controllerColor ?? Colors.white
                : (widget.controllerColor ?? Colors.white).withOpacity(0.5),
        borderRadius: BorderRadius.all(Radius.circular(12)),
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
