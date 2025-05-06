import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gym_system/src/core/models/type_defs.dart';

class WorkInProgressPage extends StatelessWidget {
  const WorkInProgressPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(MIcons.hammerWrench, size: 80),
              const SizedBox(height: 16),
              const Text(
                'This page is under construction',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              const Text(
                'We’re working hard to bring this feature to you soon!',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              if (context.canPop())
                TextButton(
                  onPressed: () => context.pop(),
                  child: const Text('Go back'),
                )
            ],
          ),
        ),
      ),
    );
  }
}
