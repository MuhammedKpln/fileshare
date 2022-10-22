import 'package:auto_route/auto_route.dart';
import 'package:boilerplate/core/di/di.dart';
import 'package:boilerplate/core/extensions/toast.extension.dart';
import 'package:boilerplate/core/theme/toast.dart';
import 'package:boilerplate/features/auth/controllers/register.controller.dart';
import 'package:boilerplate/generated/assets.gen.dart';
import 'package:boilerplate/router/router.gr.dart';
import 'package:boilerplate/shared/components/button.dart';
import 'package:boilerplate/shared/components/core/custom_appbar.dart';
import 'package:boilerplate/shared/components/core/custom_divider.dart';
import 'package:boilerplate/shared/components/core/scaffold.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:ionicons/ionicons.dart';
import 'package:mobx/mobx.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final appController = getIt<RegisterViewController>();

  @override
  Widget build(BuildContext context) {
    appController.errors.observe(
      (p0) {
        context.toast.showToast(
          p0.elementChanges?.last.newValue ?? 'unkonwn',
          toastType: ToastType.error,
        );
      },
    );

    void register() {
      appController.register().then((value) async {
        context.toast.showToast('Login succes', toastType: ToastType.success);

        await context.router.replace(const MainRoute());
      });
    }

    return AppScaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: CustomAppBar(),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Assets.animations.register.lottie(
                height: MediaQuery.of(context).size.height * .25,
              ),
            ),
            Text(
              'signUpViewTitle',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.w600),
            ).tr(),
            _RegisterForm(appController: appController),
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
                  onPressed: register,
                  label: 'loginViewTitle'.tr(),
                  buttonType: ButtonType.primary,
                  loading: appController.registerFuture?.status ==
                      FutureStatus.pending,
                );
              },
            ),
            const AppDivider(),
            Button(
              onPressed: () => null,
              label: 'loginWithGoogle'.tr(),
              icon: Ionicons.logo_google,
            )
          ],
        ),
      ),
    );
  }
}

class _RegisterForm extends StatelessWidget {
  const _RegisterForm({
    required this.appController,
  });

  final RegisterViewController appController;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: appController.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          TextFormField(
            autofocus: true,
            validator: appController.usernameValidator,
            controller: appController.textControllers[FormFieldType.username],
            decoration: InputDecoration(
              label: const Text('signUpUsername').tr(),
              icon: const Icon(Ionicons.people_outline),
            ),
          ),
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
          Observer(
            builder: (_) {
              return TextFormField(
                keyboardType: TextInputType.visiblePassword,
                controller: appController
                    .textControllers[FormFieldType.passwordConfirmation],
                validator: appController.passwordValidator,
                obscureText: !appController.showPaswordField,
                decoration: InputDecoration(
                  label: const Text('registerViewPasswordConfirmation').tr(),
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
