import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: Home()),
    ),
  );
}

enum ColorType {
  red(color: Colors.red),
  green(color: Colors.green),
  yellow(color: Colors.yellow),
  blue(color: Colors.blue);

  final Color color;

  const ColorType({required this.color});
}

class ColorService extends ChangeNotifier {
  int _redCount = 0;
  int _greenCount = 0;
  int _yellowCount = 0;
  int _blueCount = 0;

  int get redCount => _redCount;
  int get greenCount => _greenCount;
  int get yellowCount => _yellowCount;
  int get blueCount => _blueCount;

  void incrementRed() { _redCount++; notifyListeners(); }
  void incrementGreen() { _greenCount++; notifyListeners(); }
  void incrementYellow() { _yellowCount++; notifyListeners(); }
  void incrementBlue() { _blueCount++; notifyListeners(); }
}

final colorService = ColorService();

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          _currentIndex == 0
              ? ColorTapsScreen()
              : StatisticsScreen(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.tap_and_play),
            label: 'Taps',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Statistics',
          ),
        ],
      ),
    );
  }
}

class ColorTapsScreen extends StatelessWidget {

  const ColorTapsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Color Taps')),
      body: ListenableBuilder(
        listenable: colorService,
        builder: (context, child) => Column(
          children: [
            ColorTap(type: ColorType.red, tapCount: colorService.redCount),
            ColorTap(type: ColorType.green, tapCount: colorService.greenCount),
            ColorTap(type: ColorType.yellow, tapCount: colorService.yellowCount),
            ColorTap(type: ColorType.blue, tapCount: colorService.blueCount),
          ],
        ),
      ),
    );
  }
}

class ColorTap extends StatelessWidget {
  final ColorType type;
  final int tapCount;

  const ColorTap({
    super.key,
    required this.type,
    required this.tapCount,
  });

  void handleTap() {
    switch (type) {
      case ColorType.red: colorService.incrementRed(); break;
      case ColorType.green: colorService.incrementGreen(); break;
      case ColorType.yellow: colorService.incrementYellow(); break;
      case ColorType.blue: colorService.incrementBlue(); break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: handleTap,
      child: Container(
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: type.color,
          borderRadius: BorderRadius.circular(10),
        ),
        width: double.infinity,
        height: 100,
        child: Center(
          child: Text(
            'Taps: $tapCount',
            style: TextStyle(fontSize: 24, color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class StatisticsScreen extends StatelessWidget {

  const StatisticsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Statistics')),
      body: ListenableBuilder(
        listenable: colorService,
        builder: (context, child) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Red Taps: ${colorService.redCount}', style: TextStyle(fontSize: 24)),
              Text('Green Taps: ${colorService.greenCount}', style: TextStyle(fontSize: 24)),
              Text('Yellow Taps: ${colorService.yellowCount}', style: TextStyle(fontSize: 24)),
              Text('Blue Taps: ${colorService.blueCount}', style: TextStyle(fontSize: 24)),
            ],
          ),
        ),
      ),
    );
  }
}
