// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../providers/auth_provider.dart';
// import '../providers/app_state_provider.dart';

// class CustomDrawer extends StatelessWidget {
//   const CustomDrawer({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final auth = context.watch<AuthProvider>();

//     return Drawer(
//       child: Column(
//         children: [
//           const SizedBox(height: 50),
//           Text(auth.user?.name ?? "User"),

//           ListTile(
//             title: const Text("Home"),
//             onTap: () => Navigator.pushNamed(context, '/home'),
//           ),

//           ListTile(
//             title: const Text("Favorites"),
//             onTap: () => Navigator.pushNamed(context, '/favorites'),
//           ),

//           ListTile(
//             title: const Text("Profile"),
//             onTap: () => Navigator.pushNamed(context, '/edit-profile'),
//           ),

//           ListTile(
//             title: const Text("Theme"),
//             onTap: () => context.read<AppStateProvider>().toggleTheme(),
//           ),

//           ListTile(
//             title: const Text("Logout"),
//             onTap: () {
//               context.read<AuthProvider>().signOut();
//               Navigator.pushReplacementNamed(context, '/login');
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }