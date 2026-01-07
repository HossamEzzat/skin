import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:skin/features/article/presentation/bloc/article_bloc.dart';
import 'package:skin/features/chat/presentation/bloc/chat_bloc.dart';
import 'package:skin/features/prediction/presentation/bloc/prediction_bloc.dart';
import 'package:skin/features/disease/presentation/bloc/disease_bloc.dart';
import 'package:skin/features/scan_history/presentation/bloc/scan_history_bloc.dart';

import 'core/di/injection_container.dart' as di;
import 'core/theme/app_theme.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/auth/presentation/widgets/auth_wrapper.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await di.init();
  runApp(const Medics());
}

class Medics extends StatelessWidget {
  const Medics({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => di.sl<AuthBloc>()),
            BlocProvider(create: (_) => di.sl<PredictionBloc>()),
            BlocProvider(
              create: (_) => ChatBloc(
                getChatsUseCase: di.sl(),
                getMessagesUseCase: di.sl(),
                sendMessageUseCase: di.sl(),
              ),
            ),
            BlocProvider(
              create: (_) => ArticleBloc(getArticlesUseCase: di.sl()),
            ),
            BlocProvider(create: (_) => DiseaseBloc()),
            BlocProvider(create: (_) => di.sl<ScanHistoryBloc>()),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            home: const AuthWrapper(),
          ),
        );
      },
    );
  }
}
