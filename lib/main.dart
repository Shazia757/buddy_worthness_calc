import 'dart:io';
import 'package:buddy_worthness_calc/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

void main() {
  runApp(const MyApp());
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
      home: const MyHomePage(title: 'Buddy Worthness Calc'),
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

    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      _statusText = "🧠 Calculating body part values...";
    });

    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      _statusText = "📊 Generating report...";
    });

    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      _isGenerating = false;
      _fakeReport = {
        'Left Kidney': '₹87,000',
        'Right Eye': '₹25,000',
        'Brain (Used)': '₹8.50',
        'Heart': '₹1,20,000',
        'Smile': 'Priceless 😄',
      };
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
        title: Text(widget.title),
        backgroundColor: Colors.black,
        foregroundColor: Colors.greenAccent,
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
