import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/controllers/auth_provider.dart';
import 'package:shop_app/models/auth_model.dart';
import 'package:shop_app/views/screens/login_screen.dart';
import 'package:shop_app/views/widgets/custom_button.dart';
import 'package:shop_app/views/widgets/custom_text_form_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  bool isVisible = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up', style: TextStyle(fontWeight: FontWeight.bold)),
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
                    hText: 'Name',
                    pIcon: Icon(Icons.person),
                    controller: nameController,
                  ),
                  SizedBox(height: 16),
                  CustomTextFormField(
                    hText: 'Phone',
                    pIcon: Icon(Icons.phone),
                    controller: phoneController,
                  ),
                  SizedBox(height: 16),
                  CustomTextFormField(
                    hText: 'Email',
                    pIcon: Icon(Icons.email),
                    isEmail: true,
                    controller: emailController,
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
                        final resilt = await context
                            .read<AuthProvider>()
                            .register(
                              AuthRequest(
                                email: emailController.text,
                                password: passController.text,
                                phone: phoneController.text,
                                name: nameController.text,
                              ),
                            );
                        if (resilt) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return LoginScreen();
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
                        : Text('Sign Up'),
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Have an account?'),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return LoginScreen();
                              },
                            ),
                          );
                        },
                        child: Text('Login'),
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