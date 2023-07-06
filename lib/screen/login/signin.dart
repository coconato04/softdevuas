import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:softdevuas/screen/login/signup.dart';
import 'package:softdevuas/screen/navbar/navbottombar.dart';

class SignInBackend {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<UserCredential?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('Error signing in: User not found');
      } else if (e.code == 'wrong-password') {
        print('Error signing in: Wrong password');
      } else {
        print('Error signing in: $e');
      }
      return null;
    } catch (error) {
      print('Error signing in: $error');
      return null;
    }
  }

  Future<UserCredential?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        final UserCredential userCredential =
            await _auth.signInWithCredential(credential);
        return userCredential;
      } else {
        print('Google sign in aborted');
        return null;
      }
    } catch (error) {
      print('Error signing in with Google: $error');
      return null;
    }
  }

  Future<UserCredential?> signInWithApple() async {
    try {
      // Mengimplementasikan sign in dengan Apple di sini
      // ...
      // Melakukan sign in dengan credential Apple
      // ...
      // Mengembalikan userCredential
      // ...
      return null; // Hanya contoh, Anda perlu mengimplementasikan sendiri
    } catch (error) {
      print('Error signing in with Apple: $error');
      return null;
    }
  }
}

// Implementasi SignIn widget

class SignIn extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          color: Colors.black,
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'LOGIN',
                  style: TextStyle(
                    color: Colors.blue.shade900,
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 50),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  cursorColor: Colors.lightBlue.shade800,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: "Your email",
                    prefixIcon: Padding(
                      padding: EdgeInsets.all(12),
                      child: Icon(Icons.person),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "EXAMPLE: axxxx@gmail,com",
                      style: TextStyle(fontSize: 11),
                    ),
                    SizedBox(width: 12),
                    Icon(
                      Icons.arrow_forward,
                      size: 16,
                      color: Colors.transparent,
                    ),
                  ],
                ),
                SizedBox(height: 25),
                TextFormField(
                  controller: _passwordController,
                  textInputAction: TextInputAction.done,
                  obscureText: true,
                  cursorColor: Colors.lightBlue.shade800,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: "Your password",
                    prefixIcon: Padding(
                      padding: EdgeInsets.all(12),
                      child: Icon(Icons.lock),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
                SizedBox(height: 80),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      SignInBackend signInBackend = SignInBackend();
                      UserCredential? userCredential =
                          await signInBackend.signInWithEmailAndPassword(
                        _emailController.text,
                        _passwordController.text,
                      );
                      if (userCredential != null) {
                        // Login berhasil, arahkan ke halaman beranda atau halaman yang diinginkan
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => Navbar()),
                        );
                      } else {
                        // Login gagal, tampilkan pesan error
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text('Login Failed'),
                            content: Text('Invalid email or password'),
                            actions: [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('OK'),
                              ),
                            ],
                          ),
                        );
                      }
                    }
                  },
                  child: Text(
                    'LOGIN',
                    style: TextStyle(fontSize: 18),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue.shade900,
                    onPrimary: Colors.white,
                    padding:
                        EdgeInsets.symmetric(horizontal: 140, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    minimumSize:
                        Size(200, 0), // Atur lebar minimum tombol di sini
                  ),
                ),
                SizedBox(height: 15),
                Text(
                  'OR',
                  style: TextStyle(fontSize: 14),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () async {
                    SignInBackend signInBackend = SignInBackend();
                    UserCredential? userCredential =
                        await signInBackend.signInWithGoogle();
                    if (userCredential != null) {
                      // Login berhasil, arahkan ke halaman beranda atau halaman yang diinginkan
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => Navbar()),
                      );
                    } else {
                      // Login gagal, tampilkan pesan error
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('Google Sign-In Failed'),
                          content: Text('Unable to sign in with Google'),
                          actions: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('OK'),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.g_mobiledata, size: 25),
                      SizedBox(width: 20),
                      Text(
                        'SIGN IN WITH GOOGLE',
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    onPrimary: Colors.black,
                    padding: EdgeInsets.symmetric(horizontal: 70, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                      side: BorderSide(
                        width: 1,
                        color: Colors.black,
                      ),
                    ),
                    minimumSize:
                        Size(200, 0), // Atur lebar minimum tombol di sini
                  ),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () async {
                    SignInBackend signInBackend = SignInBackend();
                    UserCredential? userCredential =
                        await signInBackend.signInWithApple();
                    if (userCredential != null) {
                      // Login berhasil, arahkan ke halaman beranda atau halaman yang diinginkan
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => Navbar()),
                      );
                    } else {
                      // Login gagal, tampilkan pesan error
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('Apple Sign-In Failed'),
                          content: Text('Unable to sign in with Apple'),
                          actions: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('OK'),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.apple, size: 25),
                      SizedBox(width: 20),
                      Text(
                        'SIGN IN WITH APPLE',
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    onPrimary: Colors.black,
                    padding: EdgeInsets.symmetric(horizontal: 75, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                      side: BorderSide(
                        width: 1,
                        color: Colors.black,
                      ),
                    ),
                    minimumSize:
                        Size(200, 0), // Atur lebar minimum tombol di sini
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "DON'T HAVE AN ACCOUNT?",
                      style: TextStyle(fontSize: 12),
                    ),
                    SizedBox(width: 5),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => SignUp()),
                        );
                      },
                      child: Text(
                        'SIGN UP HERE',
                        style: TextStyle(
                            fontSize: 12, color: Colors.blue.shade900),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
