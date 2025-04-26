import 'package:alumni_connect/features/auth/login_view.dart';
import 'package:alumni_connect/features/auth/register_view.dart';
import 'package:alumni_connect/features/homepage/home_page.dart';
import 'package:alumni_connect/features/homepagefeatures/alumnimanagementsection/create_alumni_account.dart';
import 'package:alumni_connect/features/homepagefeatures/alumnimanagementsection/update_alumni_page.dart';
import 'package:alumni_connect/features/homepagefeatures/eventPage/check_permission.dart';
import 'package:alumni_connect/features/homepagefeatures/eventPage/create_event.dart';
import 'package:alumni_connect/features/homepagefeatures/profile_page.dart';
import 'package:alumni_connect/features/homepagefeatures/searchingAlumni/search_alumni.dart';
import 'package:alumni_connect/features/homepagefeatures/searchingAlumni/search_alumni_by_location.dart';
import 'package:alumni_connect/features/homepagefeatures/searchingAlumni/search_alumni_by_series.dart';
import 'package:alumni_connect/features/homepagefeatures/tuitionpage/add_tution.dart';
import 'package:alumni_connect/features/homepagefeatures/tuitionpage/edit_tuition.dart';
import 'package:alumni_connect/features/homepagefeatures/tuitionpage/tution_page.dart';
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
    GoRoute(
        name:RouteNames.createAlumni,
        path: "/createAlumni",
        builder: (context,state) => const JoinOurCommunity(),
    ),
    GoRoute(
        name:RouteNames.updateAlumni,
        path: "/updateAlumni",
        builder: (context,state) => const UpdateAlumniPage(),
    ),
    GoRoute(
        name:RouteNames.tuitionPage,
        path: "/tuitionPage",
        builder: (context,state) => const TuitionPage(),
    ),
    GoRoute(
        name:RouteNames.searchAlumni,
        path: "/searchAlumni",
        builder: (context,state) => const SearchLocationPage(),
    ),
    GoRoute(
        name:RouteNames.searchBySeries,
        path: "/searchBySeries",
        builder: (context,state) => const SearchBySeries(),
    ),

]);