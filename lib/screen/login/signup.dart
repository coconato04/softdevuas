import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:softdevuas/screen/login/signin.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String extractUsernameFromEmail(String email) {
    int atIndex = email.indexOf('@');
    if (atIndex != -1) {
      return email.substring(0, atIndex);
    }
    return email;
  }

  Future<void> createSubCollection(String userId) async {
    final userDocRef =
        FirebaseFirestore.instance.collection('Users').doc(userId);

    final subCollectionRef = userDocRef.collection('Tasks');
    await subCollectionRef.add({});
    print('Subcollection "Tasks" created');
  }

  Future<UserCredential?> signUpWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // Tambahkan data pengguna ke Firestore
      await _firestore.collection('Users').doc(userCredential.user!.uid).set({
        'Email': email,
      });
      return userCredential;
    } catch (error) {
      print('Error signing up: $error');
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

  Future<UserCredential?> signUpWithApple() async {
    try {
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        accessToken: appleCredential.authorizationCode,
      );

      final UserCredential userCredential =
          await _auth.signInWithCredential(oauthCredential);
      return userCredential;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

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
                  'SIGN UP',
                  style: TextStyle(
                    color: Colors.blue.shade900,
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 50),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  controller: _emailController,
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
                SizedBox(height: 20),
                TextFormField(
                  textInputAction: TextInputAction.next,
                  obscureText: true,
                  controller: _passwordController,
                  cursorColor: Colors.lightBlue.shade800,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a password';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: "New password",
                    prefixIcon: Padding(
                      padding: EdgeInsets.all(12),
                      child: Icon(Icons.lock),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  textInputAction: TextInputAction.done,
                  obscureText: true,
                  controller: _confirmPasswordController,
                  cursorColor: Colors.lightBlue.shade800,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please confirm your password';
                    }
                    if (value != _passwordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: "Confirm password",
                    prefixIcon: Padding(
                      padding: EdgeInsets.all(12),
                      child: Icon(Icons.lock),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
                SizedBox(height: 60),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      String email = _emailController.text.trim();
                      String password = _passwordController.text.trim();

                      UserCredential? userCredential =
                          await signUpWithEmailAndPassword(email, password);

                      if (userCredential != null) {
                        // Login berhasil, arahkan ke halaman beranda atau halaman yang diinginkan
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => SignIn()),
                        );

                        // Simpan data pengguna ke Firestore
                        String userId = userCredential
                            .user!.uid; // ID pengguna dari FirebaseAuth
                        String? userEmail = userCredential.user!.email;
                        String username = extractUsernameFromEmail(
                            userEmail!); // Ambil nama pengguna dari alamat email

                        await FirebaseFirestore.instance
                            .collection('Users')
                            .doc(userId)
                            .set({
                          'email': userEmail,
                          'username': username,
                          // Tambahkan data pengguna tambahan sesuai kebutuhan
                        });
                        await createSubCollection(userId);
                      } else {
                        // Sign up gagal, tampilkan pesan error
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text('Sign Up Failed'),
                            content: Text(
                                'Unable to sign up with the provided credentials'),
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
                    'SIGN UP',
                    style: TextStyle(fontSize: 18),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue.shade900,
                    onPrimary: Colors.white,
                    padding:
                        EdgeInsets.symmetric(horizontal: 130, vertical: 15),
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
                    UserCredential? userCredential = await signInWithGoogle();

                    if (userCredential != null) {
                      // Login berhasil, arahkan ke halaman beranda atau halaman yang diinginkan
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => SignIn()),
                      );

                      // Simpan data pengguna ke Firestore
                      String userId = userCredential
                          .user!.uid; // ID pengguna dari FirebaseAuth
                      String? userEmail = userCredential.user!.email;
                      String username = extractUsernameFromEmail(
                          userEmail!); // Ambil nama pengguna dari alamat email

                      await FirebaseFirestore.instance
                          .collection('Users')
                          .doc(userId)
                          .set({
                        'email': userEmail,
                        'username': username,
                        // Tambahkan data pengguna tambahan sesuai kebutuhan
                      });
                      await createSubCollection(userId);
                    } else {
                      // Sign up dengan Google gagal, tampilkan pesan error
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('Sign Up Failed'),
                          content:
                              Text('Unable to sign up with Google credentials'),
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
                    UserCredential? userCredential = await signUpWithApple();

                    if (userCredential != null) {
                      // Sign up dengan Apple berhasil, arahkan ke halaman sign in atau halaman lain yang diinginkan
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => SignIn(),
                        ),
                      );
                    } else {
                      // Sign up dengan Apple gagal, tampilkan pesan error
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('Sign Up Failed'),
                          content:
                              Text('Unable to sign up with Apple credentials'),
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
                      Icon(Icons.login_rounded, size: 25),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
