import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:http/http.dart' as http;
import '../network/network_info.dart';
import '../../features/auth/data/datasources/auth_remote_data_source.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/usecases/login_usecase.dart';
import '../../features/auth/presentation/bloc/auth_bloc.dart';

import 'package:skin/features/auth/domain/usecases/register_usecase.dart';
import 'package:skin/features/auth/domain/usecases/forgot_password_usecase.dart';
import 'package:skin/features/auth/domain/usecases/logout_usecase.dart';
import 'package:skin/features/prediction/data/datasources/prediction_remote_data_source.dart';
import 'package:skin/features/prediction/data/datasources/prediction_remote_data_source_impl.dart';
import 'package:skin/features/prediction/data/repositories/prediction_repository_impl.dart';
import 'package:skin/features/prediction/domain/repositories/prediction_repository.dart';
import 'package:skin/features/prediction/domain/usecases/predict_burn_usecase.dart';
import 'package:skin/features/prediction/domain/usecases/predict_skin_cancer_usecase.dart';
import 'package:skin/features/prediction/presentation/bloc/prediction_bloc.dart';

import 'package:skin/features/chat/data/datasources/chat_remote_data_source.dart';
import 'package:skin/features/chat/data/repositories/chat_repository_impl.dart';
import 'package:skin/features/chat/domain/repositories/chat_repository.dart';
import 'package:skin/features/chat/domain/usecases/get_chats_usecase.dart';
import 'package:skin/features/chat/domain/usecases/get_messages_usecase.dart';
import 'package:skin/features/chat/domain/usecases/send_message_usecase.dart';
import 'package:skin/features/chat/presentation/bloc/chat_bloc.dart';

import 'package:skin/features/article/data/datasources/article_remote_data_source.dart';
import 'package:skin/features/article/data/repositories/article_repository_impl.dart';
import 'package:skin/features/article/domain/repositories/article_repository.dart';
import 'package:skin/features/article/domain/usecases/get_articles_usecase.dart';
import 'package:skin/features/article/presentation/bloc/article_bloc.dart';

import 'package:skin/features/scan_history/data/datasources/scan_history_remote_data_source.dart';
import 'package:skin/features/scan_history/data/datasources/scan_history_remote_data_source_impl.dart';
import 'package:skin/features/scan_history/data/repositories/scan_history_repository_impl.dart';
import 'package:skin/features/scan_history/domain/repositories/scan_history_repository.dart';
import 'package:skin/features/scan_history/domain/usecases/delete_scan_usecase.dart';
import 'package:skin/features/scan_history/domain/usecases/get_user_scans_usecase.dart';
import 'package:skin/features/scan_history/domain/usecases/save_scan_usecase.dart';
import 'package:skin/features/scan_history/presentation/bloc/scan_history_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - Auth
  // ... (existing sl registrations)

  //! Features - Article
  // Bloc
  sl.registerFactory(() => ArticleBloc(getArticlesUseCase: sl()));

  // Use cases
  sl.registerLazySingleton(() => GetArticlesUseCase(sl()));

  // Repository
  sl.registerLazySingleton<ArticleRepository>(
    () => ArticleRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()),
  );

  // Data sources
  sl.registerLazySingleton<ArticleRemoteDataSource>(
    () => ArticleRemoteDataSourceImpl(firestore: sl()),
  );
  // ... (existing sl registrations)

  //! Features - Chat
  // Bloc
  sl.registerFactory(
    () => ChatBloc(
      getChatsUseCase: sl(),
      getMessagesUseCase: sl(),
      sendMessageUseCase: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => GetChatsUseCase(sl()));
  sl.registerLazySingleton(() => GetMessagesUseCase(sl()));
  sl.registerLazySingleton(() => SendMessageUseCase(sl()));

  // Repository
  sl.registerLazySingleton<ChatRepository>(
    () => ChatRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()),
  );

  // Data sources
  sl.registerLazySingleton<ChatRemoteDataSource>(
    () => ChatRemoteDataSourceImpl(firestore: sl(), auth: sl()),
  );
  // Bloc
  sl.registerFactory(
    () => AuthBloc(
      loginUseCase: sl(),
      registerUseCase: sl(),
      forgotPasswordUseCase: sl(),
      logoutUseCase: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => RegisterUseCase(sl()));
  sl.registerLazySingleton(() => ForgotPasswordUseCase(sl()));
  sl.registerLazySingleton(() => LogoutUseCase(sl()));

  // Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()),
  );

  // Data sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(sl(), sl()),
  );

  //! Features - Prediction
  // Bloc
  sl.registerFactory(
    () => PredictionBloc(
      predictBurnUseCase: sl(),
      predictSkinCancerUseCase: sl(),
      saveScanUseCase: sl(),
      firebaseAuth: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => PredictBurnUseCase(sl()));
  sl.registerLazySingleton(() => PredictSkinCancerUseCase(sl()));

  // Repository
  sl.registerLazySingleton<PredictionRepository>(
    () => PredictionRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()),
  );

  // Data sources
  sl.registerLazySingleton<PredictionRemoteDataSource>(
    () => PredictionRemoteDataSourceImpl(client: sl()),
  );

  //! Features - Scan History
  // Bloc
  sl.registerFactory(
    () => ScanHistoryBloc(getUserScansUseCase: sl(), deleteScanUseCase: sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => SaveScanUseCase(sl()));
  sl.registerLazySingleton(() => GetUserScansUseCase(sl()));
  sl.registerLazySingleton(() => DeleteScanUseCase(sl()));

  // Repository
  sl.registerLazySingleton<ScanHistoryRepository>(
    () => ScanHistoryRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()),
  );

  // Data sources
  sl.registerLazySingleton<ScanHistoryRemoteDataSource>(
    () => ScanHistoryRemoteDataSourceImpl(firestore: sl()),
  );

  //! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //! External
  sl.registerLazySingleton(() => FirebaseAuth.instance);
  sl.registerLazySingleton(() => FirebaseFirestore.instance);
  sl.registerLazySingleton(() => InternetConnectionChecker());
  sl.registerLazySingleton(() => http.Client());
}
