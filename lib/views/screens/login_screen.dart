import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/controllers/auth_provider.dart';
import 'package:shop_app/controllers/get_products_provider.dart';
import 'package:shop_app/models/auth_model.dart';
import 'package:shop_app/views/screens/home_screen.dart';
import 'package:shop_app/views/screens/register_screen.dart';
import 'package:shop_app/views/widgets/custom_button.dart';
import 'package:shop_app/views/widgets/custom_text_form_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passController = TextEditingController();
  bool isVisible = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 80,
                    child: Icon(Icons.shopping_cart, size: 70),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Shopping',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),

                  SizedBox(height: 16),
                  CustomTextFormField(
                    controller: emailController,
                    hText: 'Email',
                    pIcon: Icon(Icons.email),
                    isEmail: true,
                  ),
                  SizedBox(height: 16),
                  CustomTextFormField(
                    controller: passController,
                    hText: 'Password',
                    pIcon: Icon(Icons.lock),
                    isPass: isVisible,
                    sIcon: IconButton(
                      onPressed: () {
                        isVisible = !isVisible;
                        setState(() {});
                      },
                      icon: Icon(
                        isVisible ? Icons.visibility : Icons.visibility_off,
                      ),
                    ),
                  ),
                  SizedBox(height: 24),
                  CustomButton(
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        final result = await context.read<AuthProvider>().login(
                          AuthRequest(
                            email: emailController.text,
                            password: passController.text,
                          ),
                        );
                        if (result) {
                          context.read<GetProductsProvider>().getProducts();
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return HomeScreen();
                              },
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Something Went Wrong'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      }
                    },
                    child: context.watch<AuthProvider>().isLoading
                        ? CircularProgressIndicator()
                        : Text('Login'),
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Don\'t have an account?'),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return RegisterScreen();
                              },
                            ),
                          );
                        },
                        child: Text('Sign Up'),
                      ),
                    ],
                  ),
                  SizedBox(height: 50),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}