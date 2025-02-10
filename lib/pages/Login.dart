import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smartinventory/pages/SignUp.dart';
import 'package:smartinventory/pages/Dashboard.dart'; // Import your Dashboard page
import 'package:smartinventory/pages/passswordforgot.dart'; // Import ForgotPassword page

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> login() async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    if (email.isNotEmpty && password.isNotEmpty) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
        
        // Navigate to Dashboard after successful login
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Dashboard()),
        );

      } on FirebaseAuthException catch (e) {
        String message;

        if (e.code == 'user-not-found') {
          message = 'No user found for that email.';
        } else if (e.code == 'wrong-password') {
          message = 'Wrong password provided for that user.';
        } else {
          message = 'An unexpected error occurred. Please try again.';
        }

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(message),
          duration: Duration(seconds: 3),
        ));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Please fill all fields.'),
        duration: Duration(seconds: 3),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff14141d),
      body: Stack(
        children: [
          // Background image
          Image.asset(
            "image/signup.jpeg",
            fit: BoxFit.cover, // Make the image fill the screen
            width: double.infinity,
            height: double.infinity,
          ),
          // Form container
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 100,),
                  Text(
                    "Welcome! ",
                    style: TextStyle(
                        color: const Color.fromARGB(255, 248, 248, 248),
                        fontSize: 34,
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    "Login ",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 44,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  _buildTextField(_emailController, "Enter Your Email", Icons.email, false),
                  SizedBox(height: 10),
                  _buildTextField(_passwordController, "Enter Your Password", Icons.lock, true),
                  SizedBox(height: 14),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ForgotPassword())); // Navigate to ForgotPassword
                    },
                    child: Container(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "Forgot Password?",
                        style: TextStyle(
                            color: Color(0xff6b63ff),
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  SizedBox(height: 24),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Signup()));
                        },
                        child: Container(
                          width: 120,
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(18)),
                          child: Center(
                            child: Text(
                              "Sign Up",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 90),
                      GestureDetector(
                        onTap: login, // Call login function on tap
                        child: Container(
                          width: 120,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(18)),
                          child: Center(
                            child: Text(
                              "Login",
                              style: TextStyle(
                                  color: Color(0xff14141d),
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to build text fields
  Widget _buildTextField(TextEditingController controller, String hint, IconData icon, bool obscure) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          hint.split(' ')[0], // Display only the label without "Enter Your"
          style: TextStyle(
              color: const Color.fromARGB(255, 226, 176, 176),
              fontSize: 20,
              fontWeight: FontWeight.w500),
        ),
        TextField(
          controller: controller,
          obscureText: obscure,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white.withOpacity(0.1),
            hintText: hint,
            hintStyle: TextStyle(color: const Color.fromARGB(255, 226, 179, 179)),
            suffixIcon: Icon(icon, color: Colors.white),
          ),
        ),
      ],
    );
  }
}