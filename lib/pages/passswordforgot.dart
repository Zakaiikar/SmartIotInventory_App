import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff14141d),
      appBar: AppBar(
        title: Text("Change Password"),
        backgroundColor: Color(0xff14141d),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Enter your email address and new password.",
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                hintText: "Enter Your Email",
                hintStyle: TextStyle(color: const Color.fromARGB(255, 226, 179, 179)),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _newPasswordController,
              decoration: InputDecoration(
                hintText: "Enter New Password",
                hintStyle: TextStyle(color: const Color.fromARGB(255, 226, 179, 179)),
                filled: true,
                fillColor: Colors.white,
              ),
              obscureText: true, // Hide the password input
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                String email = _emailController.text.trim();
                String newPassword = _newPasswordController.text.trim();
                
                if (email.isNotEmpty && newPassword.isNotEmpty) {
                  try {
                    // Check if the email is registered
                    final signInMethods = await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);
                    
                    // Log the sign-in methods for debugging
                    print('Sign-in methods for $email: $signInMethods');

                    if (signInMethods.isNotEmpty) {
                      // Sign in to update the password
                      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                        email: email,
                        password: 'current_password', // Use the actual current password here
                      );

                      // Update the password
                      await userCredential.user!.updatePassword(newPassword);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Password changed successfully!'),
                        duration: Duration(seconds: 3),
                      ));
                      Navigator.pop(context); // Go back or navigate to another page
                    } else {
                      // Inform the user that no account was found
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('No account found for this email.'),
                        duration: Duration(seconds: 3),
                      ));
                    }
                  } on FirebaseAuthException catch (e) {
                    // Handle Firebase-specific errors
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Error: ${e.message}'),
                      duration: Duration(seconds: 3),
                    ));
                  } catch (e) {
                    // Handle any other errors
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('An unexpected error occurred. Please try again.'),
                      duration: Duration(seconds: 3),
                    ));
                  }
                } else {
                  // Prompt the user to enter their email and new password
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Please fill in both fields.'),
                    duration: Duration(seconds: 3),
                  ));
                }
              },
              child: Text("Change Password"),
            ),
          ],
        ),
      ),
    );
  }
}