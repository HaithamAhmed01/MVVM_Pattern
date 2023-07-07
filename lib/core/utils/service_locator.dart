import 'package:bookly/Features/home/data/repo/home_repo_impl.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../network/network_info.dart';
import 'api.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.registerSingleton<Api>(
    Api(
      NetWorkInfo(
        Connectivity(),
      ),
      Dio(),
    ),
  );
  getIt.registerSingleton<HomeRepoImpl>(
    HomeRepoImpl(
      getIt.get<Api>(),
    ),
  );
}
