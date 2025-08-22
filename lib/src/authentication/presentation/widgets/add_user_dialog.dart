import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tdd_tutorial/src/authentication/presentation/cubit/auth_cubit.dart';

class AddUserDialog extends StatelessWidget {
  const AddUserDialog({required this.nameController, super.key});
  final TextEditingController nameController;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 8),
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text('Create user', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            const SizedBox(height: 12),
            TextField(
              controller: nameController,
              textInputAction: TextInputAction.done,
              decoration: const InputDecoration(
                labelText: 'Username',
                hintText: 'Enter a name',
              ),
              onSubmitted: (_) {},
            ),
            const SizedBox(height: 16),
            ValueListenableBuilder<TextEditingValue>(
              valueListenable: nameController,
              builder: (context, value, _) {
                final isValid = value.text.trim().isNotEmpty;
                return FilledButton.icon(
                  onPressed: isValid
                      ? () {
                          final name = value.text.trim();
                          context.read<AuthCubit>().createUser(
                                name: name,
                                avatar:
                                    'https://cdn.jsdelivr.net/gh/faker-js/assets-person-portrait/male/512/70.jpg',
                                createdAt: DateTime.now().toIso8601String(),
                              );
                        }
                      : null,
                  icon: const Icon(Icons.person_add_alt_1),
                  label: const Text('Create user'),
                );
              },
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}