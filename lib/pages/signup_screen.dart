import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moviebookingapp/pages/login_screen.dart';
import 'package:moviebookingapp/utils/errorhandling.dart';
import 'package:moviebookingapp/utils/social_buttons.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../utils/mytheme.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool loading = false;
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailcontroller.dispose();
    passwordcontroller.dispose();
  }



  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.black));
    return Scaffold(
      backgroundColor: Colors.black,
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.025,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Hero(
                  tag: 'logo',
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Image.asset(
                      'assets/icons/logo.png',
                      // height: MediaQuery.of(context).size.height*0.1,
                      width: MediaQuery.of(context).size.width * 0.45,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.0025,
            ),
            Text("   Welcome Buddies! \nGrab Your Seats Today",
                style: GoogleFonts.montserrat(
                    fontSize: 18,
                    color: const Color(0xFFe0c56e),
                    fontWeight: FontWeight.w600)),
            Container(
              height: MediaQuery.of(context).size.height * 0.66,
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color(0xFFe0c56e),
              ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text("SignUp to Your Account",
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          )),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.015,
                    ),
                    Form(
                      key: _formkey,
                      child: Column(
                        children: [
                          TextFormField(
                            cursorHeight: 24,
                            controller: emailcontroller,
                            cursorColor: Colors.black,
                            style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 16,
                              height:
                                  MediaQuery.of(context).size.height * 0.0015,
                            ),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                              hintText: 'Email',
                              fillColor: Colors.black26,
                              filled: true,
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter Email';
                              } else if (value == " ") {
                                return 'Enter Email';
                              } else
                                return null;
                            },
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.023,
                          ),
                          TextFormField(
                            cursorHeight: 24,
                            controller: passwordcontroller,
                            cursorColor: Colors.black,
                            obscureText: true,
                            style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 16,
                              height:
                                  MediaQuery.of(context).size.height * 0.0015,
                            ),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                              hintText: 'Password',
                              fillColor: Colors.black26,
                              filled: true,
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter Password';
                              } else if (value == " ") {
                                return 'Enter Password';
                              } else
                                return null;
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .030,
                    ),

                    // SizedBox(
                    //   height: MediaQuery.of(context).size.height*.0001
                    // ),

                    // ElevatedButton(
                    //   onPressed: () {},
                    //   child: Center(
                    //     child: Padding(
                    //       padding: const EdgeInsets.all(12.0),
                    //       child: Text("LOGIN",
                    //           style: GoogleFonts.poppins(
                    //             fontSize: 18,
                    //             color: Colors.black,
                    //             fontWeight: FontWeight.w600,
                    //           )
                    //       ),
                    //     ),
                    //   ),
                    // )
                    Material(
                      elevation: 10,
                      borderRadius: BorderRadius.circular(10),
                      child: InkWell(
                        onTap: () {
                          if (_formkey.currentState!.validate()) {
                            setState(() {
                              loading = true;
                            });
                            _auth
                                .createUserWithEmailAndPassword(
                                    email: emailcontroller.text.toString(),
                                    password:
                                        passwordcontroller.text.toString())
                                .then((value) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                      const LoginScreen()));
                              setState(() {
                                loading = false;
                              });
                            }).onError((error, stackTrace) {
                              ErrorHandling().Message(error.toString());
                              setState(() {
                                loading = false;
                              });
                            });
                          }
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.080,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // SizedBox(
                              //   width: MediaQuery.of(context).size.width * 0.28,
                              // ),
                              loading
                                  ? Padding(
                                    padding:EdgeInsets.only(left:10),
                                    child: CircularProgressIndicator(
                                        strokeWidth: 4,
                                        color: MyTheme.main,
                                      ),
                                  )
                                  : Text(
                                      "SIGN UP",
                                      style: GoogleFonts.montserrat(
                                        fontSize: 19,
                                        color: Color(0xFFe0c56e),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                              // Container(
                              //   margin: EdgeInsets.only(bottom: 5),
                              //   child: const Icon(
                              //     Icons.lock,
                              //     color: Color(0xFFe0c56e),
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // SizedBox(
                    //   height: MediaQuery.of(context).size.height*.010,
                    // ),
                    // Row(
                    //   children: [
                    //     Expanded(
                    //       child: Divider(
                    //         color: Colors.black.withOpacity(0.3),
                    //       ),
                    //     ),
                    //     Text("  Or  ",style: GoogleFonts.montserrat(
                    //       fontSize: 14,
                    //       color: Colors.black,
                    //       fontWeight: FontWeight.w600,
                    //     ),),
                    //     Expanded(
                    //       child: Divider(
                    //         color: Colors.black.withOpacity(0.3),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    // SizedBox(
                    //   height: MediaQuery.of(context).size.height*.010,
                    // ),
                    // SocialLoginButtons(onGoogleClick: (){}, onFbClick: (){}),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .010,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Row(
                        children: [
                          Text("Already have an Account?",
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                              )),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const LoginScreen()));
                            },
                            child: Text("LogIn",
                                style: GoogleFonts.poppins(
                                  decoration: TextDecoration.underline,
                                  fontSize: 12,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                )),
                          ),
                        ],
                      ),
                    ),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
