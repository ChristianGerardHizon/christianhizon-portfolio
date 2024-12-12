import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gym_system/src/core/common_widgets/app_snackbar.dart';
import 'package:gym_system/src/core/routing/router.dart';
import 'package:gym_system/src/features/authentication/presentation/controllers/auth_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';


class RegistrationPage extends HookConsumerWidget {
  const RegistrationPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(authControllerProvider.notifier);

    final emailController = useTextEditingController();
    final nameController = useTextEditingController();
    final passwordController = useTextEditingController();
    final passwordConfirmController = useTextEditingController();
    final contactNumberController = useTextEditingController();
    final isLoading = useState(false);

    onRegister() async {
      isLoading.value = true;
      final result = await notifier
          .register(
            email: emailController.text,
            password: passwordController.text,
            name: nameController.text,
            passwordConfirm: passwordConfirmController.text,
            contactNumber: contactNumberController.text,
          )
          .run();
      isLoading.value = false;
      result.fold(
        (l) {
          log('Registration failed');
          log(l.toString());
          if (context.mounted) isLoading.value = false;
          AppSnackBar.rootFailure(l);
        },
        (r) {
          log('Registration successful');
          log(r.toString());

          if (context.mounted) const RootRoute().go(context);
          AppSnackBar.root(message: 'success');
        },
      );
    }

    final passwordVisibility = useState(false);
    final passwordConfirmVisibility = useState(false);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: Builder(
        builder: (context) {
          if (isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          return Column(
            children: [
              ListTile(
                title: const Text('Email'),
                subtitle: TextField(
                  controller: emailController,
                ),
              ),
              ListTile(
                title: const Text('Name'),
                subtitle: TextField(
                  controller: nameController,
                ),
              ),
              ListTile(
                title: const Text('Contact Number'),
                subtitle: TextField(
                  controller: contactNumberController,
                  keyboardType: TextInputType.phone,
                  maxLength: 10,
                  decoration: const InputDecoration(
                    prefixText: '+63',
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                ),
              ),
              ListTile(
                title: const Text('Password'),
                subtitle: TextField(
                  controller: passwordController,
                  obscureText: !passwordVisibility.value,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: () =>
                          passwordVisibility.value = !passwordVisibility.value,
                      icon: !passwordVisibility.value
                          ? const Icon(Icons.visibility)
                          : const Icon(Icons.visibility_off),
                    ),
                  ),
                ),
              ),
              ListTile(
                title: const Text('Confirm Password'),
                subtitle: TextField(
                  controller: passwordConfirmController,
                  obscureText: !passwordConfirmVisibility.value,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: () => passwordConfirmVisibility.value =
                          !passwordConfirmVisibility.value,
                      icon: !passwordConfirmVisibility.value
                          ? const Icon(Icons.visibility)
                          : const Icon(Icons.visibility_off),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: FilledButton(
                    onPressed: onRegister,
                    child: const Text('Register'),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
