import 'package:flutter/material.dart';
import 'package:webf/webf.dart';
import 'package:webf_carousel_slider/webf_carousel_slider.dart';

void main() {
  // Initialize WebF
  WebFControllerManager.instance.initialize(
    WebFControllerManagerConfig(
      maxAliveInstances: 2,
      maxAttachedInstances: 1,
    ),
  );

  // Install the carousel slider component
  installWebFCarouselSlider();

  runApp(const CarouselSliderExample());
}

class CarouselSliderExample extends StatelessWidget {
  const CarouselSliderExample({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WebF Carousel Slider Example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const CarouselSliderPage(),
    );
  }
}

class CarouselSliderPage extends StatefulWidget {
  const CarouselSliderPage({super.key});

  @override
  State<CarouselSliderPage> createState() => _CarouselSliderPageState();
}

class _CarouselSliderPageState extends State<CarouselSliderPage> {
  late WebFController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebFController(
      defaultBundle: WebFBundle.fromUrl('assets/index.html'),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('WebF Carousel Slider Example'),
      ),
      body: SafeArea(
        child: WebFWidget(controller: _controller),
      ),
    );
  }
}
