import 'package:auto_route/auto_route.dart';
import 'package:boilerplate/core/di/di.dart';
import 'package:boilerplate/core/extensions/toast.extension.dart';
import 'package:boilerplate/core/theme/toast.dart';
import 'package:boilerplate/features/auth/controllers/auth.controller.dart';
import 'package:boilerplate/generated/assets.gen.dart';
import 'package:boilerplate/router/router.gr.dart';
import 'package:boilerplate/shared/components/button.dart';
import 'package:boilerplate/shared/components/core/custom_divider.dart';
import 'package:boilerplate/shared/components/core/scaffold.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:ionicons/ionicons.dart';
import 'package:mobx/mobx.dart';

/// Login form
class LoginView extends StatelessWidget {
  // ignore: public_member_api_docs
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final appController = getIt<AuthViewController>();

    appController.errors.observe(
      (p0) {
        context.toast.showToast(
          p0.elementChanges?.last.newValue ?? 'unkonwn',
          toastType: ToastType.error,
        );
      },
    );

    void login() {
      appController.login().then((value) async {
        context.toast.showToast('Login succes', toastType: ToastType.success);

        await context.router.replace(const MainRoute());
      });
    }

    void signUp() {
      context.router.navigate(const RegisterRoute());
    }

    return AppScaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Assets.animations.login.lottie(
            height: MediaQuery.of(context).size.height * .40,
          ),
          Text(
            'loginViewTitle',
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(fontWeight: FontWeight.w600),
          ).tr(),
          _LoginForm(appController: appController),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () => null,
              child: const Text('forgotPassword').tr(),
            ),
          ),
          Observer(
            builder: (_) {
              return Button(
                onPressed: login,
                label: 'loginViewTitle'.tr(),
                buttonType: ButtonType.primary,
                loading: appController.s?.status == FutureStatus.pending,
              );
            },
          ),
          const AppDivider(),
          Button(
            onPressed: signUp,
            label: 'signUpViewTitle'.tr(),
            buttonType: ButtonType.primary,
          ),
          Button(
            onPressed: () => null,
            label: 'loginWithGoogle'.tr(),
            icon: Ionicons.logo_google,
          )
        ],
      ),
    );
  }
}

class _LoginForm extends StatelessWidget {
  const _LoginForm({
    required this.appController,
  });

  final AuthViewController appController;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: appController.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            autofocus: true,
            validator: appController.emailValidator,
            controller: appController.textControllers[FormFieldType.email],
            decoration: InputDecoration(
              label: const Text('loginViewEmail').tr(),
              icon: const Icon(Ionicons.at_circle_outline),
            ),
          ),
          Observer(
            builder: (_) {
              return TextFormField(
                keyboardType: TextInputType.visiblePassword,
                controller:
                    appController.textControllers[FormFieldType.password],
                validator: appController.passwordValidator,
                obscureText: !appController.showPaswordField,
                decoration: InputDecoration(
                  label: const Text('loginViewPassword').tr(),
                  icon: const Icon(Ionicons.key_outline),
                  suffixIcon: IconButton(
                    onPressed: appController.toggleShowPasswordField,
                    icon: appController.showPaswordField
                        ? const Icon(Ionicons.eye_outline)
                        : const Icon(Ionicons.eye_off_outline),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
