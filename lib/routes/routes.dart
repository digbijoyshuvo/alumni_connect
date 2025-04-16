import 'package:alumni_connect/features/auth/login_view.dart';
import 'package:alumni_connect/features/auth/register_view.dart';
import 'package:alumni_connect/features/homepage/home_page.dart';
import 'package:alumni_connect/features/homepagefeatures/eventPage/check_permission.dart';
import 'package:alumni_connect/features/homepagefeatures/eventPage/create_event.dart';
import 'package:alumni_connect/features/homepagefeatures/profile_page.dart';
import 'package:alumni_connect/features/homepagefeatures/tuitionpage/add_tution.dart';
import 'package:alumni_connect/features/homepagefeatures/tuitionpage/edit_tuition.dart';
import 'package:alumni_connect/features/landing/landing_page.dart';
import 'package:alumni_connect/routes/route_names.dart';
import 'package:go_router/go_router.dart';

import '../data/auth/check_session.dart';

final GoRouter router = GoRouter(routes: [
    GoRoute(
    name:RouteNames.landing,
    path: "/",
    builder: (context,state) => const LandingPage(),
    ),

    GoRoute(
        name:RouteNames.login,
        path: "/login",
        builder: (context,state) => const LoginView(),
    ),

    GoRoute(
        name:RouteNames.register,
        path: "/register",
        builder: (context,state) => const RegisterView(),
    ),

    GoRoute(
        name:RouteNames.profile,
        path: "/profile",
        builder: (context,state) => const ProfilePage(),
    ),

    GoRoute(
        name:RouteNames.homepage,
        path: "/homepage",
        builder: (context,state) => const HomePage(),
    ),

    GoRoute(
        name:RouteNames.checkSession,
        path: "/checkSession",
        builder: (context,state) => const CheckSession(),
    ),

    GoRoute(
        name:RouteNames.addTuition,
        path: "/addTuition",
        builder: (context,state) => const AddTuition(),
    ),

    GoRoute(
        name:RouteNames.editTuition,
        path: "/editTuition",
        builder: (context,state) => const EditTuition(),
    ),

    GoRoute(
        name:RouteNames.checkPermission,
        path: "/checkPermission",
        builder: (context,state) => const CheckPermission(),
    ),

    GoRoute(
        name:RouteNames.createEvent,
        path: "/createEvent",
        builder: (context,state) => const CreateEvent(),
    ),

]);