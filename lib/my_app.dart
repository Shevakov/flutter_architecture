import 'package:business_layer/business_layer.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final MainBloc _mainBloc;

  @override
  void initState() {
    super.initState();
    _mainBloc = GetIt.I.get<MainBloc>();
    _mainBloc.add(const MainBlocEvent.init());
  }

  @override
  Widget build(BuildContext context) {
    return Provider<MainBloc>(
      create: (_) => _mainBloc,
      lazy: false,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _mainBloc.dispose();
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<MainBlocState>(
      stream: context.read<MainBloc>().state,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final state = snapshot.data;

          return state!.map<Widget>(
            loading: (_) => Scaffold(
              appBar: AppBar(
                title: const Text('Demo'),
              ),
              body: const Center(
                child: Text('Initializing'),
              ),
            ),
            loaded: (state) => Scaffold(
              appBar: AppBar(
                title: const Text('Flutter Demo Home Page'),
              ),
              body: Center(
                child: Text(
                  state.userData.name,
                  style: Theme.of(context).textTheme.headline4,
                ),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () => context.read<MainBloc>().add(
                      MainBlocEvent.setUser(
                        userId: state.userData.id + 1,
                      ),
                    ),
                tooltip: 'Increment',
                child: const Icon(Icons.add),
              ),
            ),
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
