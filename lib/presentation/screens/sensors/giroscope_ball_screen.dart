import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscelaneos/presentation/providers/providers.dart';

class GiroscopeBallScreen extends ConsumerWidget {
  const GiroscopeBallScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final gyroscope$ = ref.watch(giroscopeProvider);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Giroscopio Ball'),
        ),
        body: SizedBox.expand(
          child: gyroscope$.when(
            data: (data) => MovingBall(x: data.x, y: data.y),
            error: (error, stackTrace) => Text('$error'),
            loading: () => const CircularProgressIndicator(),
          ),
        ));
  }
}

class MovingBall extends StatelessWidget {
  final double x;
  final double y;
  const MovingBall({super.key, required this.x, required this.y});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double screenWidth = size.width;
    double screenHeight = size.height;

    double currentYPos = (y * 300);
    double currentXPos = (x * 300);

    return Stack(
      alignment: Alignment.center,
      children: [
        AnimatedPositioned(
          left: (currentYPos - 25) + (screenWidth / 2),
          top: (currentXPos - 25) + (screenHeight / 2),
          duration: const Duration(milliseconds: 1000),
          curve: Curves.easeInOut,
          child: const Ball(),
        ),
        Text('''
x: $x,
y; $y
    '''),
      ],
    );
  }
}

class Ball extends StatelessWidget {
  const Ball({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: const BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
    );
  }
}
