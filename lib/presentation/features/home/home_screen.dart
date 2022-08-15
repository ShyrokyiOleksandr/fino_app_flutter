import 'package:fino/presentation/common/ui/app_try_again_error.dart';
import 'package:fino/presentation/common/ui/loading/app_loading_overlay.dart';
import 'package:fino/presentation/features/home/home_cubit.dart';
import 'package:fino/presentation/features/home/home_state.dart';
import 'package:fino/service_locator/app_service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jiffy/jiffy.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final _screenBloc = getIt<HomeCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      bloc: _screenBloc,
      builder: (context, state) {
        return Scaffold(
          body: Stack(
            children: [
              ListView(
                children: state.transactions
                    .map(
                      (e) => Card(
                        child: ListTile(
                          leading: Text(e.value.toString()),
                          title: Text(e.comment),
                          subtitle: Text(Jiffy(e.date).format('dd.MM.yyy')),
                        ),
                      ),
                    )
                    .toList(),
              ),
              if (state.isLoading) ...{
                const AppLoadingOverlay(),
              } else if (state.loadingException != null) ...{
                AppTryAgainError(
                  message: state.loadingException.toString(),
                  onTryAgain: _screenBloc.loadTransactions,
                ),
              },
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}
