import 'package:flutter/material.dart';
import 'package:stopwacth_cubit/cubit/stopwacth_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StopwacthCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Stopwacth Cubit"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            BlocBuilder<StopwacthCubit, StopwacthState>(
              bloc: BlocProvider.of<StopwacthCubit>(context),
              builder: (context, state) {
                String sstate = "";
                if (state is Ready) {
                  sstate = "Ready";
                } else if (state is Paused) {
                  sstate = "Paused";
                } else {
                  sstate = "Running";
                }
                return Column(
                  children: [
                    Text("$sstate"),
                    Text(
                      '${state.duration}',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ],
                );
              },
            ),
            BlocBuilder<StopwacthCubit, StopwacthState>(
              bloc: BlocProvider.of<StopwacthCubit>(context),
              builder: (context, state) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        BlocProvider.of<StopwacthCubit>(context).start();
                      },
                      child: Text((state is Ready)
                          ? "Play"
                          : (state is Paused)
                              ? "Continue"
                              : "Pause"),
                    ),
                    Visibility(
                      visible: state is! Ready,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: ElevatedButton(
                          onPressed: () {
                            BlocProvider.of<StopwacthCubit>(context).reset();
                          },
                          child: Text("Done"),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
