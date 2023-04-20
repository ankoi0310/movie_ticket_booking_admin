import 'package:flutter/material.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/core.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/provider/authentication_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AppRouterDelegate _appRouterDelegate = AppRouterDelegate.instance;
  bool _isLoggingIn = false;
  bool _isObscure = true;
  String _email = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final authProvider = Provider.of<AuthenticationProvider>(context);

    Future<void> login() async {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        setState(() {
          _isLoggingIn = true;
        });
        await authProvider.login(_email, _password).then((success) async {
          if (success) {
            _appRouterDelegate.setPathName(RouteData.dashboard.name);
          } else {
            setState(() {
              _isLoggingIn = false;
            });
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Đăng nhập thất bại'),
                backgroundColor: Colors.red,
              ),
            );
          }
        });
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        height: SizeConfig.screenHeight,
        width: SizeConfig.screenWidth,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: Container(
                height: SizeConfig.screenHeight,
                color: AppColors.primary,
                child: const Center(
                  child: Text(
                    'Administator',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 48,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: SizeConfig.blockSizeHorizontal * 5),
            Expanded(
              flex: 3,
              child: _isLoggingIn
                  ? Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primary.withOpacity(0.5),
                      ),
                    )
                  : Form(
                      key: _formKey,
                      child: Container(
                        height: SizeConfig.screenHeight,
                        padding: EdgeInsets.symmetric(
                          horizontal: SizeConfig.screenWidth * 0.05,
                          vertical: SizeConfig.screenHeight * 0.05,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(height: SizeConfig.screenHeight * 0.145),
                            RichText(
                              text: const TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Welcome back, ',
                                    style: TextStyle(
                                      color: AppColors.primary,
                                      fontSize: 24,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'Admin',
                                    style: TextStyle(
                                      color: AppColors.primary,
                                      fontSize: 24,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: SizeConfig.screenHeight * 0.05),
                            TextFormField(
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              cursorColor: Colors.black,
                              cursorHeight: SizeConfig.blockSizeVertical * 0.5,
                              decoration: const InputDecoration(
                                labelText: 'Email',
                                floatingLabelAlignment: FloatingLabelAlignment.start,
                                alignLabelWithHint: true,
                                labelStyle: TextStyle(color: Colors.grey),
                                suffixIcon: Icon(
                                  Icons.email,
                                  color: Colors.grey,
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Email không được để trống';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _email = value!;
                              },
                              onFieldSubmitted: (value) {
                                login();
                              },
                            ),
                            SizedBox(height: SizeConfig.screenHeight * 0.03),
                            TextFormField(
                              obscureText: _isObscure,
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              cursorColor: Colors.black,
                              cursorHeight: SizeConfig.blockSizeVertical * 0.5,
                              decoration: InputDecoration(
                                labelText: 'Mật khẩu',
                                labelStyle: const TextStyle(color: Colors.grey),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _isObscure ? Icons.visibility : Icons.visibility_off,
                                    color: Colors.grey,
                                  ),
                                  highlightColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  onPressed: () {
                                    setState(() {
                                      _isObscure = !_isObscure;
                                    });
                                  },
                                ),
                                enabledBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Mật khẩu không được để trống';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _password = value!;
                              },
                              onFieldSubmitted: (value) {
                                login();
                              },
                            ),
                            SizedBox(height: SizeConfig.screenHeight * 0.03),
                            Container(
                              height: SizeConfig.screenHeight * 0.06,
                              width: SizeConfig.screenWidth * 0.4,
                              decoration: BoxDecoration(
                                color: AppColors.primary,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: TextButton(
                                onPressed: () async {
                                  await login();
                                },
                                child: const Text(
                                  'Đăng nhập',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
            )
          ],
        ),
      ),
    );
  }
}
