import 'dart:developer';
import 'dart:io';
import 'package:buddy_worthness_calc/image_picker.dart';
import 'package:flutter/material.dart';
// import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

void main() {
  runApp(const MyApp());
}

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 30),
              Text(
                '💰 Buddy Worthness Calc',
                style: TextStyle(
                  color: Colors.greenAccent,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Courier',
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Text(
                'Upload your buddy\'s photo and let the scanner reveal their market *worth* (all in good humor 👀).',
                style: TextStyle(
                  color: Colors.greenAccent.shade100,
                  fontSize: 14,
                  fontFamily: 'Courier',
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              Lottie.asset(
                'assets/scan.json',
                width: 250,
                repeat: true,
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) {
                      return const MyHomePage(title: 'Buddy Worthness Calc');
                    },
                  ));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.greenAccent,
                  foregroundColor: Colors.black,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text(
                  '⚡ Start Scanning',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Courier',
                  ),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Buddy Worthness Calc',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
        colorScheme: const ColorScheme.dark(
          primary: Colors.greenAccent,
          secondary: Colors.green,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.greenAccent.shade400,
            foregroundColor: Colors.black,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            textStyle: const TextStyle(fontWeight: FontWeight.bold),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: Colors.redAccent,
          ),
        ),
      ),
      home: WelcomeScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  XFile? _pickedImage;
  bool _isGenerating = false;
  String _statusText = '';
  Map<String, String>? _fakeReport;
  int _currentTypedLine = 0;

  final List<MapEntry<String, String>> _reportLines = [];

  void _generateReport() async {
    setState(() {
      _isGenerating = true;
      _statusText = "📸 Scanning photo...";
      _fakeReport = null;
      _reportLines.clear();
      _currentTypedLine = 0;
    });

    await Future.delayed(const Duration(seconds: 1));

    bool isHuman = false;
    if (_pickedImage != null) {
      try {
        isHuman = true;
      } catch (e) {
        log(e.toString());
      }
    }

    if (!isHuman) {
      setState(() {
        _isGenerating = false;
        _statusText = "❌ No human detected in the image.";
      });
      return;
    }

    setState(() {
      _statusText = "🧠 Calculating body part values...";
    });

    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      _statusText = "📊 Generating report...";
    });

    await Future.delayed(const Duration(seconds: 2));

    final List<MapEntry<String, String>> allEntries = [
      MapEntry('Left Kidney', '₹96,420'),
      MapEntry('Right Kidney', '₹95,000'),
      MapEntry('Left Lung', '₹75,000 (with 30% pollution tax)'),
      MapEntry('Right Eye', '₹27,000'),
      MapEntry('Left Eye', '₹25,000 (slightly blurry)'),
      MapEntry('Liver', '₹1,10,000 (marinated)'),
      MapEntry('Heart', '₹1,50,000 (with feelings)'),
      MapEntry('Brain', '₹5 (lightly used)'),
      MapEntry('Brain (Unused)', '₹2,00,000 (rare find)'),
      MapEntry('Spinal Cord', '₹60,000 (includes free backbone)'),
      MapEntry('Sense of Humor', '₹₹₹ Off the charts 😂'),
      MapEntry('Left Thumb', '₹2,500 (used for scrolling)'),
      MapEntry('Smile', 'Priceless 😄'),
      MapEntry('Tears', '₹15 per drop (wholesale available)'),
      MapEntry('Eyebrows', '₹1,000 per brow (shaped)'),
      MapEntry('Nose', '₹12,000 (has smell memory)'),
      MapEntry('Ego', '₹99,999 (non-refundable)'),
      MapEntry('Common Sense', 'Out of stock ❌'),
      MapEntry('Hair', '₹300 per strand (premium quality)'),
      MapEntry('Socks Smell', '₹-500 (we’ll pay to take it)'),
      MapEntry('Left Ear', '₹9,000 (includes gossip filter)'),
      MapEntry('Patience', '₹0 (expired)'),
      MapEntry('Sarcasm Level', '999+'),
      MapEntry('Sleep Debt', '₹75,000 (EMI applicable)'),
      MapEntry('WiFi Absorption', '₹18,000 (5G compatible)'),
      MapEntry('Screen Time Eyes', '₹5,000 (pixelated)'),
      MapEntry('Snack Storage Capacity', '₹7,500'),
      MapEntry('Confidence', '₹1,00,000 (self-generated)'),
      MapEntry('Stomach', '₹40,000 (curry-compatible)'),
      MapEntry('Inner Peace', 'Lost in 2018 ❌'),
      MapEntry('Laugh Track', 'Free with every giggle 😆'),
    ];

    allEntries.shuffle();
    setState(() {
      _isGenerating = false;
      _fakeReport = Map.fromEntries(allEntries.take(5));
      _reportLines.addAll(_fakeReport!.entries);
      _currentTypedLine = 0;
    });

    _startTypingLines();
  }

  void _startTypingLines() async {
    for (int i = 0; i < _reportLines.length; i++) {
      await Future.delayed(const Duration(milliseconds: 200));
      setState(() {
        _currentTypedLine = i + 1;
      });
    }
  }

  Widget _buildScanningAnimation() {
    return Positioned.fill(
      child: IgnorePointer(
        ignoring: true,
        child: Lottie.asset(
          'assets/scan.json',
          fit: BoxFit.cover,
          repeat: true,
          delegates: LottieDelegates(
            values: [
              ValueDelegate.color(
                const ['**'],
                value: Colors.greenAccent,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMatrixBackground() {
    return Positioned.fill(
      child: Stack(
        children: [
          Lottie.asset(
            'assets/matrix.json',
            fit: BoxFit.cover,
            repeat: true,
            delegates: LottieDelegates(
              values: [
                ValueDelegate.color(
                  const ['**'],
                  value: Colors.greenAccent,
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black.withOpacity(0.7),
                  Colors.black.withOpacity(0.9),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildTypedReport() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(_currentTypedLine, (i) {
        final entry = _reportLines[i];
        return AnimatedTextKit(
          animatedTexts: [
            TyperAnimatedText(
              "> ${entry.key.toUpperCase()}: ${entry.value}",
              textStyle: const TextStyle(
                fontFamily: 'Courier',
                fontSize: 14,
                color: Colors.greenAccent,
              ),
              speed: const Duration(milliseconds: 50),
            )
          ],
          totalRepeatCount: 1,
          isRepeatingAnimation: false,
          displayFullTextOnTap: true,
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 4,
        centerTitle: true,
        title: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            'Buddy Worthness Calculator',
            style: TextStyle(
              fontSize: 18,
              fontFamily: 'Courier',
              fontWeight: FontWeight.bold,
              letterSpacing: 1.0,
              foreground: Paint()
                ..shader = const LinearGradient(
                  colors: [Colors.greenAccent, Colors.lightGreenAccent],
                ).createShader(const Rect.fromLTWH(0.0, 0.0, 300.0, 70.0)),
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline, color: Colors.greenAccent),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  backgroundColor: Colors.black87,
                  title: const Text("About App",
                      style: TextStyle(color: Colors.greenAccent)),
                  content: const Text(
                    "This app calculates the worth of your body parts, just for fun! 😂",
                    style: TextStyle(color: Colors.white70),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Close",
                          style: TextStyle(color: Colors.greenAccent)),
                    )
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          _buildMatrixBackground(),
          Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  if (_pickedImage != null)
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.file(
                            File(_pickedImage!.path),
                            height: 250,
                            fit: BoxFit.cover,
                          ),
                        ),
                        if (_isGenerating) _buildScanningAnimation(),
                      ],
                    )
                  else
                    const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        "📷 No image selected",
                        style:
                            TextStyle(fontSize: 16, color: Colors.greenAccent),
                      ),
                    ),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.upload),
                    label: const Text('Upload Photo'),
                    onPressed: () async {
                      final image = await pickImage(context);
                      if (image != null) {
                        setState(() {
                          _pickedImage = image;
                        });
                        _generateReport();
                      }
                    },
                  ),
                  if (_pickedImage != null && !_isGenerating)
                    TextButton.icon(
                      icon: const Icon(Icons.delete_outline),
                      label: const Text("Remove Photo"),
                      onPressed: () {
                        setState(() {
                          _pickedImage = null;
                          _fakeReport = null;
                          _reportLines.clear();
                          _currentTypedLine = 0;
                        });
                      },
                    ),
                  const SizedBox(height: 30),
                  if (_isGenerating) ...[
                    const CircularProgressIndicator(color: Colors.greenAccent),
                    const SizedBox(height: 20),
                    Text(
                      _statusText,
                      style: const TextStyle(
                          fontSize: 16, color: Colors.greenAccent),
                    ),
                  ],
                  if (_fakeReport != null) ...[
                    const SizedBox(height: 20),
                    const Text(
                      "🧾 Your Body Report:",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.greenAccent,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.all(16),
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                            color: Colors.greenAccent.withOpacity(0.5)),
                      ),
                      child: _buildTypedReport(),
                    ),
                  ]
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
