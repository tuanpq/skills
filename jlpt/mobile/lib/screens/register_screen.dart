import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../models/common.dart';
import '../state/auth_provider.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _displayNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String _targetLevel = 'N5';
  bool _isSubmitting = false;
  String? _errorMessage;

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _isSubmitting = true;
      _errorMessage = null;
    });
    try {
      await ref.read(authProvider.notifier).register(
            email: _emailController.text.trim(),
            password: _passwordController.text,
            displayName: _displayNameController.text.trim(),
            targetLevel: _targetLevel,
          );
    } catch (e) {
      setState(() => _errorMessage = 'Đăng ký thất bại. Email có thể đã được sử dụng.');
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text('Đăng ký', style: Theme.of(context).textTheme.headlineSmall),
                    const SizedBox(height: 4),
                    const Text('Tạo tài khoản để bắt đầu học JLPT'),
                    const SizedBox(height: 24),
                    TextFormField(
                      controller: _displayNameController,
                      decoration: const InputDecoration(labelText: 'Tên hiển thị'),
                      validator: (value) => (value == null || value.isEmpty) ? 'Vui lòng nhập tên' : null,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(labelText: 'Email'),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) => (value == null || value.isEmpty) ? 'Vui lòng nhập email' : null,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _passwordController,
                      decoration: const InputDecoration(labelText: 'Mật khẩu (tối thiểu 8 ký tự)'),
                      obscureText: true,
                      validator: (value) =>
                          (value == null || value.length < 8) ? 'Mật khẩu cần tối thiểu 8 ký tự' : null,
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      initialValue: _targetLevel,
                      decoration: const InputDecoration(labelText: 'Mục tiêu cấp độ'),
                      items: jlptLevels
                          .map((level) => DropdownMenuItem(value: level, child: Text(level)))
                          .toList(),
                      onChanged: (value) => setState(() => _targetLevel = value ?? 'N5'),
                    ),
                    if (_errorMessage != null) ...[
                      const SizedBox(height: 12),
                      Text(_errorMessage!, style: const TextStyle(color: Colors.red)),
                    ],
                    const SizedBox(height: 20),
                    FilledButton(
                      onPressed: _isSubmitting ? null : _submit,
                      child: Text(_isSubmitting ? 'Đang đăng ký...' : 'Đăng ký'),
                    ),
                    const SizedBox(height: 12),
                    TextButton(
                      onPressed: () => context.go('/login'),
                      child: const Text('Đã có tài khoản? Đăng nhập'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
