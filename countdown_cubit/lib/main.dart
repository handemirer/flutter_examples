import 'package:flutter/material.dart';
import 'package:countdown_cubit/cubit/countdown_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CountdownCubit(),
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
        title: Text("Countdown Cubit"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            BlocBuilder<CountdownCubit, CountdownState>(
              bloc: BlocProvider.of<CountdownCubit>(context),
              builder: (context, state) {
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Visibility(
                          visible: state is Ready,
                          child: TextButton(
                            onPressed: () {
                              BlocProvider.of<CountdownCubit>(context).d -= 10;
                            },
                            child: Row(
                              children: [
                                Icon(Icons.timer_10),
                                Icon(Icons.remove_circle),
                              ],
                            ),
                          ),
                        ),
                        Text(
                          '${state.duration}',
                          style: Theme.of(context).textTheme.headline4,
                        ),
                        Visibility(
                          visible: state is Ready,
                          child: TextButton(
                            onPressed: () {
                              BlocProvider.of<CountdownCubit>(context).d += 10;
                            },
                            child: Row(
                              children: [
                                Icon(Icons.add_circle),
                                Icon(Icons.timer_10),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    BlocBuilder<CountdownCubit, CountdownState>(
                      bloc: BlocProvider.of<CountdownCubit>(context),
                      builder: (context, state) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                BlocProvider.of<CountdownCubit>(context)
                                    .start();
                              },
                              child: Text(state is! Running
                                  ? state is Ready
                                      ? "Play"
                                      : "Continue"
                                  : "Pause"),
                            ),
                            Visibility(
                              visible: state is Running || state is Paused,
                              child: Padding(
                                padding: EdgeInsets.only(left: 8),
                                child: OutlinedButton(
                                  style: ButtonStyle(
                                      side: MaterialStateProperty.all(
                                          BorderSide(
                                              width: 2,
                                              color: Colors.deepPurple))),
                                  onPressed: () {
                                    BlocProvider.of<CountdownCubit>(context)
                                        .reset();
                                  },
                                  child: Text("Done"),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    )
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
