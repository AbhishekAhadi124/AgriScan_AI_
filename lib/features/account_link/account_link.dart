// import 'package:flutter/material.dart';
// import 'package:agri_scan/routes/routes.dart';
// //import 'package:agri_scan/features/login/login.dart';
// //import 'package:get/get_navigation/src/routes/get_route.dart';
// import 'package:get/get.dart';
// //import '../login/bindings/login_bindings.dart';

// class AccountLink extends StatelessWidget {
//   const AccountLink({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color.fromARGB(255, 186, 247, 191),
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(24.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Container(
//                 width: 120,
//                 height: 120,
//                 decoration: const BoxDecoration(
//                   shape: BoxShape.circle,
//                   gradient: LinearGradient(
//                     colors: [
//                       Color.fromARGB(255, 121, 255, 126),
//                       Color.fromARGB(255, 89, 199, 93),
//                       Colors.green,
//                       Color.fromARGB(255, 43, 103, 45),
//                       Color.fromARGB(255, 34, 83, 36),
//                       Color.fromARGB(255, 27, 68, 28),
//                     ],
//                     begin: Alignment.topLeft,
//                     end: Alignment.bottomRight,
//                   ),
//                 ),
//                 child: const Icon(Icons.eco, size: 80, color: Colors.white),
//               ),
//               const SizedBox(height: 24),

//               const Text(
//                 "Welcome to AgriScan",
//                 style: TextStyle(
//                   fontSize: 22,
//                   fontWeight: FontWeight.bold,
//                   fontFamily: 'Poppins',
//                   color: Colors.green,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//               const SizedBox(height: 8),
//               const Text(
//                 "Detect Plant Diseases Instantly with AI",
//                 style: TextStyle(
//                   fontSize: 16,
//                   color: Colors.black54,
//                   fontFamily: 'Poppins',
//                 ),
//                 textAlign: TextAlign.center,
//               ),

//               const SizedBox(height: 40),

//               SizedBox(
//                 width: double.infinity,
//                 height: 56,
//                 child: ElevatedButton(
//                   onPressed: () {
//                     Get.offNamed(MyRoutes.loginRoute);
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: const Color(0xFF4caf50),
//                     foregroundColor: Colors.white,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8.0),
//                     ),
//                   ),
//                   child: const Text(
//                     "Login",
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                       fontFamily: 'Poppins',
//                     ),
//                   ),
//                 ),
//               ),

//               const SizedBox(height: 16),

//               SizedBox(
//                 width: double.infinity,
//                 height: 56,
//                 child: OutlinedButton(
//                   onPressed: () {
//                     Get.offNamed(MyRoutes.signUpRoute);
//                   },
//                   style: OutlinedButton.styleFrom(
//                     foregroundColor: const Color(0xFF4caf50),
//                     backgroundColor: Colors.white,
//                     side: const BorderSide(color: Color(0xFF4caf50)),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8.0),
//                     ),
//                   ),
//                   child: const Text(
//                     "Create Account",
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                       fontFamily: 'Poppins',
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
