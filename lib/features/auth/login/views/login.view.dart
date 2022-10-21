import 'package:boilerplate/core/di/di.dart';
import 'package:boilerplate/core/extensions/toast.extension.dart';
import 'package:boilerplate/core/theme/toast.dart';
import 'package:boilerplate/features/auth/controllers/auth.controller.dart';
import 'package:boilerplate/services/app.service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

/// It's a stateless widget that contains a form with two text fields
/// The button calls the login method on the controller
class LoginView extends StatelessWidget {
  // ignore: public_member_api_docs
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final appController = getIt<AppService>();
    final controller = getIt<AuthViewController>();

    Future<void> login() async {
      await controller.login().then((value) {
        context.toast
            .showToast('Login successfull!', toastType: ToastType.success);
      }).onError((err, _) {
        context.toast.showToast('Opps!! $err', toastType: ToastType.error);
      });
    }

    Future<void> register() async {
      await controller.register().then((value) {
        context.toast
            .showToast('Login successfull!', toastType: ToastType.success);
      }).catchError((err, _) {
        context.toast.showToast('Opps!! $err.', toastType: ToastType.error);
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Column(
        children: [
          TextFormField(
            controller: controller.textControllers[FormFieldType.email],
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              label: Text('Email'),
            ),
          ),
          TextFormField(
            controller: controller.textControllers[FormFieldType.password],
            decoration: const InputDecoration(
              label: Text('Password'),
            ),
          ),
          Observer(
            builder: (context) {
              return Column(
                children: [
                  ElevatedButton(
                    onPressed: login,
                    child: !controller.loading
                        ? const Text('Login')
                        : const CircularProgressIndicator(),
                  ),
                  ElevatedButton(
                    onPressed: register,
                    child: !controller.loading
                        ? const Text('Register')
                        : const CircularProgressIndicator(),
                  ),
                  ElevatedButton(
                    onPressed: controller.logout,
                    child: !controller.loading
                        ? const Text('Logout')
                        : const CircularProgressIndicator(),
                  ),
                ],
              );
            },
          )
        ],
      ),
    );
  }
}
