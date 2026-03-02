part of flutter_onboarding_slider;

class PageOffsetNotifier with ChangeNotifier {
  double _offset = 0;
  double _page = 0;

  late final VoidCallback _listener;
  final PageController _pageController;

  PageOffsetNotifier(this._pageController) {
    _listener = () {
      if (_pageController.hasClients) {
        _offset = _pageController.offset;
        _page = _pageController.page ?? 0;
        notifyListeners();
      }
    };
    _pageController.addListener(_listener);
  }

  @override
  void dispose() {
    _pageController.removeListener(_listener);
    super.dispose();
  }

  double get offset => _offset;
  double get page => _page;
}
