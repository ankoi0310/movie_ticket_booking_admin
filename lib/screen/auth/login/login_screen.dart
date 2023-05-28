import 'package:flutter/material.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/core.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/handler/http_response.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/screen/exception/bad_request_exception.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/util/popup_util.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  late String email;
  late String password;

  @override
  Widget build(BuildContext context) {
    final authenticationProvider = Provider.of<AuthenticationProvider>(context, listen: false);

    Future<void> login() async {
      await authenticationProvider
          .login(UserLoginRequest(
        email: email,
        password: password,
      ))
          .then((response) {
        if (response.success) {
          PopupUtil.showSuccess(
            context: context,
            message: 'Đăng nhập thành công',
            width: SizeConfig.screenWidth * 0.4,
            onPress: () async {
              await AppRouterDelegate().setPathName(AuthRouteData.dashboard.name);
            },
          );
        } else {
          PopupUtil.showError(
            context: context,
            message: response.message,
            width: SizeConfig.screenWidth * 0.4,
          );
        }
      }).catchError((onError) {
        PopupUtil.showError(
          context: context,
          width: SizeConfig.screenWidth * 0.6 * 0.6,
          message: onError is BadRequestException ? onError.message : 'Lỗi không xác định',
        );
      });
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
                child: Center(
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
              child: Form(
                key: _loginFormKey,
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
                        text: TextSpan(
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
                      Text(
                        'Email',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: SizeConfig.screenHeight * 0.01),
                      Container(
                        height: SizeConfig.screenHeight * 0.06,
                        width: SizeConfig.screenWidth * 0.4,
                        decoration: BoxDecoration(
                          color: AppColors.primaryBg,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: AppColors.primary,
                            width: 1,
                          ),
                        ),
                        child: TextFormField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: SizeConfig.screenWidth * 0.02,
                              vertical: SizeConfig.screenHeight * 0.01,
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Email is required';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            email = value!;
                          },
                        ),
                      ),
                      SizedBox(height: SizeConfig.screenHeight * 0.03),
                      Text(
                        'Password',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: SizeConfig.screenHeight * 0.01),
                      Container(
                        height: SizeConfig.screenHeight * 0.06,
                        width: SizeConfig.screenWidth * 0.4,
                        decoration: BoxDecoration(
                          color: AppColors.primaryBg,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: AppColors.primary,
                            width: 1,
                          ),
                        ),
                        child: TextFormField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: SizeConfig.screenWidth * 0.02,
                              vertical: SizeConfig.screenHeight * 0.01,
                            ),
                          ),
                          onSaved: (value) {
                            password = value!;
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Password is required';
                            }
                            return null;
                          },
                        ),
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
                            if (_loginFormKey.currentState!.validate()) {
                              _loginFormKey.currentState!.save();
                              await login();
                            }
                            // AppRouterDelegate().setPathName(AuthRouteData.dashboard.name);
                          },
                          child: Text(
                            'Login',
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
