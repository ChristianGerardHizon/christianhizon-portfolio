import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sannjosevet/src/core/routing/router.dart';
import 'package:sannjosevet/src/core/widgets/app_snackbar.dart';
import 'package:sannjosevet/src/features/authentication/domain/auth_admin.dart';
import 'package:sannjosevet/src/features/authentication/domain/auth_data.dart';
import 'package:sannjosevet/src/features/authentication/domain/auth_user.dart';
import 'package:sannjosevet/src/features/authentication/presentation/controllers/auth_controller.dart';
import 'package:sannjosevet/src/features/users/data/user_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class EmailValidationPage extends HookConsumerWidget {
  const EmailValidationPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isRefreshing = useState(false);
    final attempts = useState(0);
    final countdown = useState(5);
    final timer = useRef<Timer?>(null);
    final countdownTimer = useRef<Timer?>(null);

    bool isVerified(AuthData? user) {
      if (user == null) return false;

      if (user is AuthUser) {
        return user.record.verified;
      }

      if (user is AuthAdmin) {
        return user.record.verified;
      }

      return false;
    }

    void redirectToRoot() {
      AppSnackBar.root(message: 'Your email has been verified.');
      const RootRoute().go(context);
    }

    Future<void> refresh() async {
      isRefreshing.value = true;
      await ref.read(authControllerProvider.notifier).refresh().run();
      isRefreshing.value = false;
    }

    void startCountdown() {
      countdown.value = 5;
      countdownTimer.value?.cancel();
      countdownTimer.value =
          Timer.periodic(const Duration(seconds: 1), (timer) {
        if (countdown.value <= 1) {
          timer.cancel();
        }
        countdown.value -= 1;
      });
    }

    void startAutoRefresh() {
      timer.value?.cancel();
      countdownTimer.value?.cancel();
      attempts.value = 0;

      timer.value = Timer.periodic(const Duration(seconds: 10), (t) async {
        attempts.value++;
        countdown.value = 5;
        startCountdown();

        await refresh();

        final user = ref.read(authControllerProvider).maybeWhen(
              data: (u) => u,
              orElse: () => null,
            );

        if (user != null && isVerified(user)) {
          t.cancel();
          countdownTimer.value?.cancel();
          redirectToRoot();
        } else if (attempts.value >= 10) {
          t.cancel();
          countdownTimer.value?.cancel();
          AppSnackBar.root(message: 'Verification timeout. Try again.');
        }
      });

      startCountdown();
    }

    Future<void> sendEmailVerification(String email) async {
      final result = await ref
          .read(userRepositoryProvider)
          .requestVerification(email)
          .run();
      result.fold(
        (l) => AppSnackBar.rootError(message: l.toString()),
        (r) {
          AppSnackBar.root(message: 'Email sent');
          startAutoRefresh();
        },
      );
    }

    useEffect(() {
      return () {
        timer.value?.cancel();
        countdownTimer.value?.cancel();
      };
    }, []);

    return Scaffold(
      appBar: AppBar(
        leading: CloseButton(
          onPressed: () => const LoginPageRoute().go(context),
        ),
        title: const Text('Email Validation'),
      ),
      body: ref.watch(authControllerProvider).maybeWhen(
            data: (auth) {
              final email = auth.map<String>(
                (u) => u.record.email,
                (a) => a.record.email,
              );

              final isWaiting = attempts.value > 0 && attempts.value < 10;
              final hasTimedOut = attempts.value >= 10;

              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('Check your email for validation link'),
                    Text(email),
                    const SizedBox(height: 20),
                    TextButton(
                      onPressed: (isWaiting || isRefreshing.value)
                          ? null
                          : () => sendEmailVerification(email),
                      child: Text(
                        isWaiting || isRefreshing.value
                            ? 'Verifying...'
                            : 'Send Verification',
                      ),
                    ),
                    if (isWaiting) ...[
                      const SizedBox(height: 10),
                      Text('Checking verification... (${attempts.value}/10)'),
                      const SizedBox(height: 5),
                      Text('Checking in ... ${countdown.value}s'),
                    ],
                    if (hasTimedOut) ...[
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          attempts.value = 0;
                          sendEmailVerification(email);
                        },
                        child: const Text('Try Again'),
                      ),
                    ],
                  ],
                ),
              );
            },
            orElse: () => const Center(child: CircularProgressIndicator()),
          ),
    );
  }
}
