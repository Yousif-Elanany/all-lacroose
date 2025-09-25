import 'package:easy_localization/easy_localization.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/Local/sharedPref/sharedPref.dart';
import '../../layout/Tabs/BaseScreen.dart';
import '../data/manager/cubit/auth_cubit.dart';
import '../data/manager/cubit/auth_states.dart';
import '../widgets/button_default.dart';
import '../widgets/textFeild_default.dart';
import 'registerPage1.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthStates>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => Basescreen()),
          );
        }
        if (state is LoginFailure) {
          if (state.errorMessage =="Your account is not activated yet"){
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("account_not_activated".tr()),
                backgroundColor: Colors.red,
              ),
            );
          }else{
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage.tr()),
                backgroundColor: Colors.red,
              ),
            );
          }

        }
      },
      builder: (context, state) {
        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            backgroundColor: Colors.white,
            body: Stack(
              children: [
                Image.asset("assets/images/auth.jpeg"),
                SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.04,
                  ).copyWith(top: 70),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// Header
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.white.withOpacity(0.1),
                              radius: 30.5,
                              child: const Image(
                                image: AssetImage("assets/images/logo.png"),
                                fit: BoxFit.cover,
                              ),
                            ),
                            Spacer(),
                            GestureDetector(
                              onTap: () async {
                                await CacheHelper.saveData(
                                    key: "roles", value: "Visitor");
                                navigateAndFinish(context, Basescreen());
                              },
                              child: Text(
                                'as_visitor'.tr(),
                                style: TextStyle(
                                  color: Color(0xff328361),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 32),

                        /// Welcome
                        Text(
                          "Welcome".tr(),
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "Login".tr(),
                          style: TextStyle(
                            color: Color(0xff207954),
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 24),

                        /// Email
                        defaultFormField(
                          label: "email".tr(),
                          maxLines: 1,
                          type: TextInputType.emailAddress,
                          controller: _emailController,
                          validate: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Required'.tr();
                            }
                            if (!EmailValidator.validate(value)) {
                              return 'inـvalidـemail'.tr();
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20),

                        /// Password
                        defaultFormField(
                          label: "password".tr(),
                          maxLines: 1,
                          isPassword: true,
                          type: TextInputType.visiblePassword,
                          controller: _passwordController,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2,
                            height: 1.5,
                          ),
                          validate: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Required'.tr();
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 24),

                        /// Forget password
                        // Row(
                        //   children: [
                        //     Text(
                        //       "forget_password".tr(),
                        //       style: TextStyle(
                        //         color: Color(0xff999999),
                        //         fontSize: 16,
                        //       ),
                        //     ),
                        //     Text(
                        //       "click_her".tr(),
                        //       style: TextStyle(
                        //         color: Color(0xff207954),
                        //         fontSize: 16,
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        SizedBox(height: 25),

                        /// Login button with loading state
                        GestureDetector(
                          onTap: () {
                            if (formKey.currentState!.validate()) {
                              BlocProvider.of<AuthCubit>(context).loginUser(
                                email: _emailController.text,
                                pass: _passwordController.text,
                              );
                            }
                          },
                          child: state is LoginLoading
                              ? Center(
                            child: CircularProgressIndicator(
                              color: Color(0xff207954),
                            ),
                          )
                              : Button_default(
                            height: 56,
                            title: "Login".tr(),
                            color: Color(0xff207954),
                            colortext: Colors.white,
                          ),
                        ),
                        SizedBox(height: 24),

                        /// OR
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "or".tr(),
                              style: TextStyle(
                                color: Color(0xff999999),
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 24),

                        /// Sign up
                        GestureDetector(
                          child: Button_default(
                            height: 56,
                            title: "Sign_up".tr(),
                            color: Color(0xff207954).withOpacity(0.08),
                            colortext: Color(0xff207954),
                          ),
                          onTap: () {
                            navigateTo(context, Registerpage1());
                          },
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

void navigateTo(context, widget) => Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => widget),
);

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
  context,
  MaterialPageRoute(builder: (context) => widget),
      (route) => false,
);
