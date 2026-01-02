// import 'package:agri_scan/features/account_link/account_link.dart';
// import 'package:agri_scan/features/login/models/login_request.dart';
// import 'package:agri_scan/routes/routes.dart';
// import 'package:flutter/material.dart';
// import 'package:agri_scan/features/login/controllers/login_controller.dart';
// import 'package:get/get.dart';

// class Login extends StatefulWidget {
//   const Login({super.key});

//   @override
//   State<Login> createState() => LoginState();
// }

// class LoginState extends State<Login> {
//   final formKey = GlobalKey<FormState>();
//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();

//   final LoginController loginController = Get.put(LoginController());

//   bool isPasswordVisible = false;

//   Future<void> login() async {
//     final requestData = LoginRequest.fromJson({
//       'email': emailController.text.trim(),
//       'password': passwordController.text.trim(),
//     });

//     try {
//       await loginController.login(requestData);

//       Get.snackbar(
//         "Success",
//         "Login Successful",
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: Colors.green,
//         colorText: Colors.white,
//       );

//       Get.offAllNamed(MyRoutes.homeRoute);
//     } catch (e) {
//       Get.snackbar(
//         "Login Failed",
//         "Invalid email or password",
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: Colors.red,
//         colorText: Colors.white,
//       );
//     }
//   }

//   void showRegistrationPage() {
//     Get.toNamed('/Signup');
//   }

//   @override
//   void dispose() {
//     emailController.dispose();
//     passwordController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.white, size: 24),
//           onPressed: () {
//             Get.off(const AccountLink());
//           },
//         ),
//         title: const Text(
//           'Login',
//           style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w500),
//         ),
//         backgroundColor: const Color(0xFF4CAF50),
//         foregroundColor: Colors.white,
//         elevation: 0,
//       ),
//       backgroundColor: Colors.white,
//       body: Center(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(24.0),
//           child: Form(
//             key: formKey,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 Container(
//                   width: 120,
//                   height: 120,
//                   decoration: const BoxDecoration(
//                     shape: BoxShape.circle,
//                     gradient: LinearGradient(
//                       colors: [
//                         Color.fromARGB(255, 121, 255, 126),
//                         Color.fromARGB(255, 89, 199, 93),
//                         Colors.green,
//                         Color.fromARGB(255, 43, 103, 45),
//                         Color.fromARGB(255, 34, 83, 36),
//                         Color.fromARGB(255, 27, 68, 28),
//                       ],
//                     ),
//                   ),
//                   child: const Icon(Icons.eco, size: 80, color: Colors.white),
//                 ),
//                 const SizedBox(height: 16.0),
//                 const Text(
//                   "Detect Plant Disease instantly with AI",
//                   style: TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.green,
//                     fontFamily: 'Poppins',
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//                 const SizedBox(height: 32.0),

//                 TextFormField(
//                   controller: emailController,
//                   keyboardType: TextInputType.emailAddress,
//                   decoration: InputDecoration(
//                     labelText: 'Email',
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(8.0),
//                     ),
//                     prefixIcon: const Icon(
//                       Icons.email,
//                       color: Color(0xFF4caf50),
//                     ),
//                   ),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter your email';
//                     }
//                     if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
//                       return 'Please enter a valid email';
//                     }
//                     return null;
//                   },
//                 ),

//                 const SizedBox(height: 16.0),

//                 TextFormField(
//                   controller: passwordController,
//                   obscureText: !isPasswordVisible,
//                   decoration: InputDecoration(
//                     labelText: 'Password',
//                     prefixIcon: const Icon(
//                       Icons.lock_open_outlined,
//                       color: Color(0xFF4caf50),
//                     ),
//                     suffixIcon: IconButton(
//                       icon: Icon(
//                         isPasswordVisible
//                             ? Icons.visibility
//                             : Icons.visibility_off,
//                         color: const Color(0xFF4caf50),
//                       ),
//                       onPressed: () {
//                         setState(() {
//                           isPasswordVisible = !isPasswordVisible;
//                         });
//                       },
//                     ),
//                     border: const OutlineInputBorder(
//                       borderRadius: BorderRadius.all(Radius.circular(8)),
//                     ),
//                   ),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter your password';
//                     }
//                     if (value.length < 6) {
//                       return 'Password must be at least 6 characters';
//                     }
//                     return null;
//                   },
//                 ),

//                 const SizedBox(height: 24.0),

//                 Obx(() {
//                   return SizedBox(
//                     width: double.infinity,
//                     height: 56,
//                     child: ElevatedButton(
//                       onPressed: loginController.isLoading.value ? null : login,
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: const Color(0xFF4CAF50),
//                         foregroundColor: Colors.white,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(8.0),
//                         ),
//                       ),
//                       child: loginController.isLoading.value
//                           ? const SizedBox(
//                               width: 24,
//                               height: 24,
//                               child: CircularProgressIndicator(
//                                 color: Colors.white,
//                                 strokeWidth: 2,
//                               ),
//                             )
//                           : const Text(
//                               'Login',
//                               style: TextStyle(
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.bold,
//                                 fontFamily: 'Poppins',
//                               ),
//                             ),
//                     ),
//                   );
//                 }),

//                 const SizedBox(height: 16.0),

//                 SizedBox(
//                   width: double.infinity,
//                   height: 56,
//                   child: OutlinedButton(
//                     onPressed: showRegistrationPage,
//                     style: OutlinedButton.styleFrom(
//                       foregroundColor: const Color(0xFF4caf50),
//                       side: const BorderSide(color: Color(0xFF4caf50)),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8.0),
//                       ),
//                     ),
//                     child: const Text(
//                       'Create New Account',
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                         fontFamily: 'Poppins',
//                       ),
//                     ),
//                   ),
//                 ),

//                 const SizedBox(height: 20),

//                 const Text(
//                   'Powered by AI for Farmers',
//                   style: TextStyle(
//                     fontSize: 16,
//                     color: Color(0xFF4caf50),
//                     fontFamily: 'Poppins',
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
