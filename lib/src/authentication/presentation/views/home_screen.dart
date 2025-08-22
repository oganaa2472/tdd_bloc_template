import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tdd_tutorial/src/authentication/presentation/cubit/auth_cubit.dart';
import 'package:tdd_tutorial/src/authentication/presentation/cubit/auth_state.dart';
import 'package:tdd_tutorial/src/authentication/presentation/widgets/add_user_dialog.dart';
import 'package:tdd_tutorial/src/authentication/presentation/widgets/loading_column.dart';
import 'package:tdd_tutorial/src/authentication/presentation/widgets/empty_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void getUsers() {
    context.read<AuthCubit>().getUsers();
  }
  final TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    getUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if(state is AuthError){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
        }
        else if(state is UserCreated){
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('User created')));
          getUsers();
        }
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(title: const Text('Users')),
          body: state is GettingUser
              ? const LoadingColumn(message: 'Fetching Users')
              : state is GreatingUser
                  ? const LoadingColumn(message: 'Creating User')
                  : state is UsersLoaded
                      ? (state.users.isEmpty
                          ? EmptyState(
                              message: 'No users yet',
                              actionLabel: 'Add user',
                              onAction: () => _openCreateSheet(context),
                            )
                          : RefreshIndicator(
                              onRefresh: () async => getUsers(),
                              child: ListView.separated(
                                physics: const AlwaysScrollableScrollPhysics(),
                                itemCount: state.users.length,
                                separatorBuilder: (_, __) => const Divider(height: 0),
                                itemBuilder: (context, index) {
                                  final user = state.users[index];
                                  return ListTile(
                                    leading: CircleAvatar(backgroundImage: NetworkImage(user.avatar)),
                                    title: Text(user.name),
                                    subtitle: Text(_formatDate(user.createdAt)),
                                  );
                                },
                              ),
                            ))
                      : const SizedBox.shrink(),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () => _openCreateSheet(context),
            icon: const Icon(Icons.add),
            label: const Text('Add User'),
          ),
        );
      },
    );
  }

  void _openCreateSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: AddUserDialog(nameController: nameController),
      ),
    );
  }

  String _formatDate(String iso) {
    try {
      final dt = DateTime.parse(iso).toLocal();
      final two = (int n) => n.toString().padLeft(2, '0');
      return '${dt.year}-${two(dt.month)}-${two(dt.day)} ${two(dt.hour)}:${two(dt.minute)}';
    } catch (_) {
      return iso;
    }
  }
}
