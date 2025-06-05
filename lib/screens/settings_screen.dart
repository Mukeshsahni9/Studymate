import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/settings/settings_bloc.dart';
import '../blocs/settings/settings_event.dart';
import '../blocs/settings/settings_state.dart';
import '../utils/app_theme.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.error != null) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Error: ${state.error}',
                  style: AppTheme.bodyLarge.copyWith(color: Colors.red),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    context.read<SettingsBloc>().add(LoadSettings());
                  },
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Settings',
              style: AppTheme.titleLarge.copyWith(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                _buildSection(
                  'Notifications',
                  [
                    SwitchListTile(
                      title: const Text('Enable Notifications'),
                      value: state.notificationsEnabled,
                      onChanged: (value) {
                        context.read<SettingsBloc>().add(ToggleNotifications(value));
                      },
                    ),
                    SwitchListTile(
                      title: const Text('Sound Effects'),
                      value: state.soundEnabled,
                      onChanged: (value) {
                        context.read<SettingsBloc>().add(ToggleSound(value));
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                _buildSection(
                  'Language',
                  [
                    ListTile(
                      title: const Text('Language'),
                      subtitle: Text(state.language),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        // TODO: Show language selection dialog
                      },
                    ),
                  ],
                ),
               
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTheme.titleLarge,
        ),
        const SizedBox(height: 8),
        Card(
          child: Column(
            children: children,
          ),
        ),
      ],
    );
  }
} 