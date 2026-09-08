package com.jlpt.android.presentation.auth

import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.text.KeyboardOptions
import androidx.compose.foundation.verticalScroll
import androidx.compose.material3.Button
import androidx.compose.material3.CircularProgressIndicator
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.OutlinedTextField
import androidx.compose.material3.Text
import androidx.compose.material3.TextButton
import androidx.compose.runtime.Composable
import androidx.compose.runtime.collectAsState
import androidx.compose.runtime.getValue
import androidx.compose.ui.Modifier
import androidx.compose.ui.text.input.KeyboardType
import androidx.compose.ui.text.input.PasswordVisualTransformation
import androidx.compose.ui.unit.dp
import androidx.hilt.navigation.compose.hiltViewModel
import com.jlpt.android.presentation.common.EmptyState
import com.jlpt.android.presentation.common.LevelDropdown

@Composable
fun RegisterScreen(
    onRegisterSuccess: () -> Unit,
    onNavigateToLogin: () -> Unit,
    viewModel: RegisterViewModel = hiltViewModel()
) {
    val state by viewModel.uiState.collectAsState()

    Column(
        modifier = Modifier.fillMaxSize().verticalScroll(rememberScrollState()).padding(24.dp)
    ) {
        Text("Tạo tài khoản", style = MaterialTheme.typography.headlineMedium)

        OutlinedTextField(
            value = state.displayName,
            onValueChange = viewModel::onDisplayNameChange,
            label = { Text("Tên hiển thị") },
            singleLine = true,
            modifier = Modifier.fillMaxWidth().padding(top = 24.dp)
        )
        OutlinedTextField(
            value = state.email,
            onValueChange = viewModel::onEmailChange,
            label = { Text("Email") },
            singleLine = true,
            keyboardOptions = KeyboardOptions(keyboardType = KeyboardType.Email),
            modifier = Modifier.fillMaxWidth().padding(top = 8.dp)
        )
        OutlinedTextField(
            value = state.password,
            onValueChange = viewModel::onPasswordChange,
            label = { Text("Mật khẩu (tối thiểu 8 ký tự)") },
            singleLine = true,
            visualTransformation = PasswordVisualTransformation(),
            keyboardOptions = KeyboardOptions(keyboardType = KeyboardType.Password),
            modifier = Modifier.fillMaxWidth().padding(top = 8.dp)
        )

        Text("Mục tiêu trình độ", style = MaterialTheme.typography.labelLarge, modifier = Modifier.padding(top = 16.dp))
        LevelDropdown(
            selected = state.targetLevel ?: com.jlpt.android.domain.model.JlptLevel.N5,
            onSelected = viewModel::onTargetLevelChange,
            modifier = Modifier.padding(top = 4.dp)
        )

        if (state.error != null) {
            EmptyState(message = state.error!!, modifier = Modifier.padding(top = 8.dp))
        }

        Button(
            onClick = { viewModel.register(onRegisterSuccess) },
            enabled = !state.isLoading,
            modifier = Modifier.fillMaxWidth().padding(top = 24.dp)
        ) {
            if (state.isLoading) {
                CircularProgressIndicator(modifier = Modifier.padding(2.dp))
            } else {
                Text("Đăng ký")
            }
        }

        TextButton(onClick = onNavigateToLogin, modifier = Modifier.fillMaxWidth().padding(top = 8.dp)) {
            Text("Đã có tài khoản? Đăng nhập")
        }
    }
}
