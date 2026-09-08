package com.jlpt.android.core.navigation

import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.collectAsState
import androidx.compose.runtime.getValue
import androidx.hilt.navigation.compose.hiltViewModel
import androidx.navigation.NavType
import androidx.navigation.compose.NavHost
import androidx.navigation.compose.composable
import androidx.navigation.compose.rememberNavController
import androidx.navigation.navArgument
import com.jlpt.android.presentation.auth.LoginScreen
import com.jlpt.android.presentation.auth.RegisterScreen
import com.jlpt.android.presentation.auth.SessionState
import com.jlpt.android.presentation.auth.SessionViewModel
import com.jlpt.android.presentation.common.LoadingIndicator
import com.jlpt.android.presentation.exam.AttemptResultScreen
import com.jlpt.android.presentation.exam.ExamAttemptScreen
import com.jlpt.android.presentation.home.HomeShell
import com.jlpt.android.presentation.review.ReviewScreen

@Composable
fun JlptNavGraph(sessionViewModel: SessionViewModel = hiltViewModel()) {
    val navController = rememberNavController()
    val sessionState by sessionViewModel.state.collectAsState()

    if (sessionState is SessionState.Loading) {
        LoadingIndicator()
        return
    }

    val startDestination = if (sessionState is SessionState.SignedIn) Routes.HOME else Routes.LOGIN

    // When the session flips to signed-out (logout, or a failed token refresh), snap back to login.
    LaunchedEffect(sessionState) {
        if (sessionState is SessionState.SignedOut) {
            navController.navigate(Routes.LOGIN) {
                popUpTo(0) { inclusive = true }
            }
        }
    }

    NavHost(navController = navController, startDestination = startDestination) {
        composable(Routes.LOGIN) {
            LoginScreen(
                onLoginSuccess = {
                    navController.navigate(Routes.HOME) { popUpTo(0) { inclusive = true } }
                },
                onNavigateToRegister = { navController.navigate(Routes.REGISTER) }
            )
        }
        composable(Routes.REGISTER) {
            RegisterScreen(
                onRegisterSuccess = {
                    navController.navigate(Routes.HOME) { popUpTo(0) { inclusive = true } }
                },
                onNavigateToLogin = { navController.popBackStack() }
            )
        }
        composable(Routes.HOME) {
            HomeShell(rootNavController = navController)
        }
        composable(
            route = Routes.REVIEW,
            arguments = listOf(navArgument("itemType") { type = NavType.StringType })
        ) {
            ReviewScreen(onBack = { navController.popBackStack() })
        }
        composable(
            route = Routes.EXAM_ATTEMPT,
            arguments = listOf(navArgument("attemptId") { type = NavType.StringType })
        ) {
            ExamAttemptScreen(
                onSubmitted = { attemptId ->
                    navController.navigate(Routes.attemptResult(attemptId)) {
                        popUpTo(Routes.HOME)
                    }
                }
            )
        }
        composable(
            route = Routes.ATTEMPT_RESULT,
            arguments = listOf(navArgument("attemptId") { type = NavType.StringType })
        ) {
            AttemptResultScreen(onBack = { navController.popBackStack() })
        }
    }
}
