import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:notes/controllers/auth.dart';
import 'package:notes/pages/home.dart';
import 'package:notes/pages/signup.dart';
import 'package:notes/widgets/custom_button.dart';
import 'package:notes/widgets/custom_check_box.dart';
import 'package:notes/widgets/custom_text_input.dart';

class Login extends HookWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController _authController = AuthController();
    final formKey = useMemoized(GlobalKey<FormState>.new);
    final mobileController = useTextEditingController(text: "");
    final passwordController = useTextEditingController(text: "");
    final isObscured = useState(true);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 64.0, left: 20, right: 20),
        child: Column(
          children: [
            Text(
              "Welcome to SAHQ Notes",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              "Sign in with your mobile number and password",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 46),
            Form(
              key: formKey,
              child: Column(
                children: [
                  CustomTextField(
                    keyboardType: TextInputType.text,
                    controller: mobileController,
                    validator:
                        (value) =>
                            value!.isEmpty ? "Missing Mobile Number" : null,
                    prefixIcon: Icon(Icons.phone, color: Colors.blue),
                    text: "Mobile Number",
                  ),
                  SizedBox(height: 16),
                  CustomTextField(
                    keyboardType: TextInputType.text,
                    isObscured: isObscured.value,
                    controller: passwordController,
                    validator:
                        (value) => value!.isEmpty ? "Missing password" : null,
                    prefixIcon: Icon(Icons.lock, color: Colors.blue),
                    suffixIcon: IconButton(
                      icon: Icon(
                        color: Colors.blue,
                        isObscured.value
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: () {
                        isObscured.value = !isObscured.value;
                      },
                    ),
                    text: "Password",
                  ),
                  SizedBox(height: 16),
                  CustomCheckBox(text: "Remember me"),
                  SizedBox(height: 16),
                  SizedBox(
                    width: 120,
                    child: CustomButton(
                      text: "LOGIN",
                      onPress: () async {
                        final user = await _authController.login(
                          mobileController.text,
                          passwordController.text,
                        );
                        if (user != null) {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => Home()),
                          );
                        }
                      },
                    ),
                  ),
                  SizedBox(height: 60),
                  Text(
                    "Don't have an account?",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  SizedBox(height: 6),
                  SizedBox(
                    width: 120,
                    child: CustomButton(
                      text: "SIGN UP",
                      onPress: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => Signup()),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 16),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
