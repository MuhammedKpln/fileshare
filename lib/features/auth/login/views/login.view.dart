import 'package:boilerplate/core/extensions/toast.extension.dart';
import 'package:boilerplate/core/theme/toast.dart';
import 'package:boilerplate/features/auth/controllers/auth.controller.dart';
import 'package:boilerplate/features/auth/enums.dart';
import 'package:boilerplate/features/core/controllers/app.controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

/// It's a stateless widget that contains a form with two text fields
/// The button calls the login method on the controller
class LoginView extends StatelessWidget {
  // ignore: public_member_api_docs
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final appController = context.read<AppController>();
    final controller = AuthViewController(appController);

    Future<void> login() async {
      await controller.login().then((value) {
        appController.setLoginState(LoginState.loggedIn);
        context.toast
            .showToast('Login successfull!', toastType: ToastType.success);
      }).onError((err, _) {
        context.toast.showToast('Opps!! $err', toastType: ToastType.error);
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Column(
        children: [
          TextFormField(
            controller: controller.textControllers[FormFieldType.username],
            decoration: const InputDecoration(
              label: Text('Username'),
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
              return ElevatedButton(
                onPressed: login,
                child: !controller.loading
                    ? const Text('Login')
                    : const CircularProgressIndicator(),
              );
            },
          )
        ],
      ),
    );
  }
}
