import '/dependency_injection/injection_container.dart' as di;

import '/core/network/local/cache_helper.dart';
import '/core/network/network_info.dart';
import '/core/network/remote/dio_helper.dart';
import '/features/posts/data/data_sources/posts_local_data_source.dart';
import '/features/posts/data/data_sources/posts_remote_data_source.dart';
import '/features/posts/data/repos/post_repo.dart';
import '/features/posts/domain/usecases/add_new_post_usecase.dart';
import '/features/posts/domain/usecases/delete_post_usecase.dart';
import '/features/posts/domain/usecases/get_all_posts_usecase.dart';
import '/features/posts/domain/usecases/update_post_usecase.dart';
import '/features/posts/presentation/bloc/manage_post_bloc/manage_post_bloc.dart';
import '/features/posts/presentation/bloc/posts_bloc/posts_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'core/styles/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await Future.wait([CacheHelper.init(), di.init()]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => di.sl<PostsBloc>()),
        BlocProvider(create: (context) => di.sl<ManagePostBloc>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Clean Architecture',
        theme: ThemeManager.appTheme,
        home: const Scaffold(
          body: Center(
            child: Text("Flutter Clean Architecture"),
          ),
        ),
      ),
    );
  }
}
