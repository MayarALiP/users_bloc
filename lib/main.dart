import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:users_bloc/bloc/app_states.dart';
import 'package:users_bloc/models/user_model.dart';
import 'package:users_bloc/repo/repository.dart';
import 'bloc/app_bloc.dart';
import 'bloc/app_event.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: RepositoryProvider(
        create: (context) => UserRepository(),
        child: const Home(),
      ),
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserBloc(
        RepositoryProvider.of<UserRepository>(context),
      )..add(LoadUserEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('The Bloc App'),
        ),
        body: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            if (state is UserLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is UserLoadedState) {
              List<UserModel> userList = state.users;
              //print(userList);
              return ListView.builder(
                  itemCount: userList.length,
                  itemBuilder: (_, index) {
                    return Card(
                      color: Colors.deepPurpleAccent,
                      elevation: 4,
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: ListTile(
                        title: Text(
                          "${userList[index].first_name} ${userList[index].last_name}",
                          style: const TextStyle(color: Colors.white),
                        ),
                        subtitle: Text(
                          userList[index].email,
                          style: const TextStyle(color: Colors.white),
                        ),
                        trailing: CircleAvatar(
                          backgroundImage: NetworkImage(userList[index].avatar),
                        ),
                      ),
                    );
                  });
            }

            if (state is DataErrorState) {
              return const Center(
                child: Text("Error has been occurred "),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
