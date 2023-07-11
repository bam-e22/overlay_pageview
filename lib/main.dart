import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Overlay PageView'),
        ),
        body: const SizedBox(
          height: 200,
          child: OverlayPageView(),
        ),
      ),
    );
  }
}

class OverlayPageView extends StatefulWidget {
  const OverlayPageView({super.key});

  @override
  State<OverlayPageView> createState() => _OverlayPageViewState();
}

class _OverlayPageViewState extends State<OverlayPageView> {
  late PageController _pageController;
  double _currentPage = 0;
  List<Color> colors = [Colors.red, Colors.amber, Colors.green];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    _pageController.addListener(() {
      _currentPage = _pageController.page ?? 0;
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _pageController,
      builder: (context, child) {
        return PageView.builder(
          controller: _pageController,
          itemCount: 3,
          itemBuilder: (context, index) {
            double opacity = 1.0;
            double scale = 1.0;
            if (index == _currentPage.floor()) {
              // 현재 페이지
              opacity = 1.0 - (_currentPage - index);
              scale = 1.0 - (_currentPage - index);
            } else if (index == _currentPage.floor() + 1) {
              // 다음 페이지
              opacity = (_currentPage - index) + 1.0;
              scale = (_currentPage - index) + 1.0;
            }
            // 페이지 위젯
            return Opacity(
              opacity: opacity,
              child: Transform.scale(
                scale: scale,
                child: Container(
                  color: colors[index],
                  child: Center(
                    child: Text(
                      'Page $index',
                      style: const TextStyle(
                        fontSize: 24,
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
