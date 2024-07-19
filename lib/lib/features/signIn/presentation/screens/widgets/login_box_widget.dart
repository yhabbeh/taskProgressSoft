import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/components/custum_text_field.dart';
import '../../../../../utils/constants/images.dart';
import '../../../../../utils/constants/text_strings_eng.dart';
import '../../../../../utils/theme/custom_themes/elevated_button_theme.dart';
import '../../../../signUp/presentation/screens/sign_up_page.dart';
import '../bloc/sign_in_bloc.dart';
import '../bloc/sign_in_event.dart';

class LoginBoxWidget extends StatelessWidget {
  const LoginBoxWidget({
    super.key,
    required GlobalKey<FormState> formKey,
    required TextEditingController usernameController,
    required TextEditingController passwordController,
  })  : _formKey = formKey,
        _usernameController = usernameController,
        _passwordController = passwordController;

  final GlobalKey<FormState> _formKey;
  final TextEditingController _usernameController;
  final TextEditingController _passwordController;

  @override
  Widget build(BuildContext context) {
    final LoginBloc authBloc = BlocProvider.of<LoginBloc>(context);
    return BlocProvider(
      create: (context) => LoginBloc(),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(TImages.logo),
              CustomTextField(
                hintText: '962xxxxxxxxxx',
                labelText: TTextsEnglish.txtUserNameHint,
                keyboardType: const TextInputType.numberWithOptions(signed: true),
                controller: _usernameController,
              ),
              CustomTextField(
                hintText: TTextsEnglish.txtPassNameHint,
                labelText: TTextsEnglish.txtPassNameHint,
                controller: _passwordController,
                isObscureText: true,
              ),
              InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => RegisterScreen(),
                    ));
                  },
                  child: const Text(TTextsEnglish.txtRegister,
                      style: TextStyle(decoration: TextDecoration.underline,fontSize: 12))),

              Container(
                width: MediaQuery.of(context).size.width*0.28,
                height: 50,
                child: ElevatedButton(
                  onPressed: () async {
                    authBloc.add(
                      LoginButtonPressed(
                        '+${_usernameController.text}@gmail.com',
                        _passwordController.text,
                      ),
                    );
                  },
                  // async => await _login(context: context),
                  child: const Text(TTextsEnglish.txtLogin),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
