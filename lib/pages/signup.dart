import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:notes/controllers/auth.dart';
import 'package:notes/pages/home.dart';
import 'package:notes/pages/login.dart';
import 'package:notes/widgets/custom_button.dart';
import 'package:notes/widgets/custom_check_box.dart';
import 'package:notes/widgets/custom_text_input.dart';

class Signup extends HookWidget {
  Signup({super.key});
  final AuthController _authController = AuthController();
  @override
  Widget build(BuildContext context) {
    final formKey = useMemoized(GlobalKey<FormState>.new);
    final nameController = useTextEditingController(text: "");
    final mobileController = useTextEditingController(text: "");
    final passwordController = useTextEditingController(text: "");
    final confirmPasswordController = useTextEditingController(text: "");
    final isObscured = useState(true);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 64.0, left: 20, right: 20),
        child: Column(
          children: [
            Text(
              "Register Account",
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              "Complete your details to continue",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Form(
              key: formKey,
              child: Column(
                children: [
                  CustomTextField(
                    keyboardType: TextInputType.text,
                    controller: nameController,
                    validator:
                        (value) => value!.isEmpty ? "Missing Name" : null,
                    prefixIcon: Icon(
                      Icons.contact_emergency,
                      color: Colors.blue,
                    ),
                    text: "Name",
                  ),
                  SizedBox(height: 16),
                  CustomTextField(
                    maxLength: 11,
                    controller: mobileController,
                    keyboardType: TextInputType.number,
                    validator:
                        (value) =>
                            value!.isEmpty ? "Missing Mobile Number" : null,
                    prefixIcon: Icon(Icons.phone, color: Colors.blue),
                    text: "Mobile Number",
                  ),
                  SizedBox(height: 8),
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
                  CustomTextField(
                    keyboardType: TextInputType.text,
                    isObscured: isObscured.value,
                    controller: confirmPasswordController,
                    validator:
                        (value) =>
                            value!.isEmpty ? "Missing confirm Password" : null,
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
                    text: "Confirm Password",
                  ),
                  SizedBox(height: 32),
                  CustomCheckBox(text: "Agree to Terms & Condition"),
                  SizedBox(height: 16),
                  SizedBox(
                    width: 120,
                    child: CustomButton(
                      text: "REGISTER",
                      onPress: () async {
                        formKey.currentState!.validate();
                        if (confirmPasswordController.text ==
                            passwordController.text) {
                          await _authController.signup(
                            nameController.text,
                            mobileController.text,
                            passwordController.text,
                          );
                        }
                        Navigator.of(
                          context,
                        ).push(MaterialPageRoute(builder: (context) => Home()));
                      },
                    ),
                  ),
                  SizedBox(height: 16),
                  SizedBox(
                    width: 120,
                    child: CustomButton(
                      text: "LOG IN",
                      onPress: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => Login()),
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
