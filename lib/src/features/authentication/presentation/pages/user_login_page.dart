import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sannjosevet/src/core/assets/i18n/strings.g.dart';
import 'package:sannjosevet/src/core/widgets/app_snackbar.dart';
import 'package:sannjosevet/src/core/widgets/loading_filled_button.dart';
import 'package:sannjosevet/src/core/routing/router.dart';
import 'package:sannjosevet/src/core/models/type_defs.dart';
import 'package:sannjosevet/src/core/utils/form_utils.dart';
import 'package:sannjosevet/src/core/widgets/logo.dart';
import 'package:sannjosevet/src/features/authentication/domain/auth_data.dart';
import 'package:sannjosevet/src/features/authentication/presentation/controllers/auth_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:responsive_builder/responsive_builder.dart';

class UserLoginPage extends HookConsumerWidget {
  const UserLoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());
    final isLoading = useState(false);
    final isPasswordVisible = useState(false);

    Future<void> onLogin() async {
      isLoading.value = true;
      final result = await TaskResult.Do(($) async {
        final form = await $(FormUtils.getFormState(formKey.currentState));
        final values = await $(FormUtils.getFormValues(form));
        return $(
          ref
              .read(authControllerProvider.notifier)
              .login(AuthDataType.users, values),
        );
      }).run();
      isLoading.value = false;

      result.fold(
        (l) {
          // make sure yung page is still open.
          if (context.mounted) isLoading.value = false;
          AppSnackBar.rootFailure(l);
        },
        (r) {
          if (context.mounted) const RootRoute().go(context);
          AppSnackBar.root(message: context.t.authentication.loginSuccess);
        },
      );
    }

    void togglePasswordVisibility() {
      isPasswordVisible.value = !isPasswordVisible.value;
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        actions: [
          IconButton(
            icon: Icon(MIcons.earth),
            onPressed: () {
              if (LocaleSettings.currentLocale == AppLocale.en) {
                LocaleSettings.setLocale(AppLocale.tl);
              } else {
                LocaleSettings.setLocale(AppLocale.en);
              }
            },
          ),
        ],
      ),
      body: ResponsiveBuilder(builder: (context, si) {
        final form = Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            children: [
              FormBuilder(
                key: formKey,
                enabled: !isLoading.value,
                child: Column(
                  children: [
                    Logo(width: 250, height: 250),
                    FormBuilderTextField(
                      name: 'email',
                      onSubmitted: (_) => onLogin(),
                      decoration: const InputDecoration(
                        labelText: 'Email',
                      ),
                    ),
                    FormBuilderTextField(
                      name: 'password',
                      obscureText: !isPasswordVisible.value,
                      onSubmitted: (_) => onLogin(),
                      decoration: InputDecoration(
                        labelText: 'Password',
                        suffixIcon: IconButton(
                          onPressed: togglePasswordVisibility,
                          icon: Icon(
                            !isPasswordVisible.value
                                ? MIcons.eyeOutline
                                : MIcons.eyeOffOutline,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              ///
              /// Login Button
              ///
              const SizedBox(height: 20),
              LoadingFilledButton(
                onPressed: onLogin,
                showText: false,
                isLoading: isLoading.value,
                child: Text(context.t.authentication.login),
              ),

              SizedBox(height: 20),

              TextButton(
                onPressed: () => const AdminLoginPageRoute().push(context),
                child: RichText(
                  text: TextSpan(
                    text: context.t.authentication.loginAsAdminList[0],
                    style: Theme.of(context).textTheme.bodyMedium,
                    children: <TextSpan>[
                      TextSpan(
                        text: context.t.authentication.loginAsAdminList[1],
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Theme.of(context).colorScheme.primary),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        );

        if (si.isMobile) {
          return form;
        }

        return Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: 500,
              maxHeight: 500,
            ),
            child: form,
          ),
        );
      }),
    );
  }
}
