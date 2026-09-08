package com.jlpt.android.presentation.home

import androidx.compose.foundation.layout.padding
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.automirrored.filled.MenuBook
import androidx.compose.material.icons.automirrored.filled.TrendingUp
import androidx.compose.material.icons.filled.Home
import androidx.compose.material.icons.filled.Quiz
import androidx.compose.material3.Icon
import androidx.compose.material3.NavigationBar
import androidx.compose.material3.NavigationBarItem
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.ui.Modifier
import androidx.navigation.NavGraph.Companion.findStartDestination
import androidx.navigation.NavHostController
import androidx.navigation.compose.NavHost
import androidx.navigation.compose.composable
import androidx.navigation.compose.currentBackStackEntryAsState
import androidx.navigation.compose.rememberNavController
import com.jlpt.android.core.navigation.HomeTabs
import com.jlpt.android.presentation.exam.ExamListScreen
import com.jlpt.android.presentation.progress.ProgressScreen
import com.jlpt.android.presentation.study.StudyScreen

private data class BottomTab(val route: String, val label: String, val icon: androidx.compose.ui.graphics.vector.ImageVector)

private val bottomTabs = listOf(
    BottomTab(HomeTabs.DASHBOARD, "Trang chủ", Icons.Filled.Home),
    BottomTab(HomeTabs.STUDY, "Học", Icons.AutoMirrored.Filled.MenuBook),
    BottomTab(HomeTabs.EXAMS, "Luyện thi", Icons.Filled.Quiz),
    BottomTab(HomeTabs.PROGRESS, "Tiến độ", Icons.AutoMirrored.Filled.TrendingUp)
)

/** Bottom-nav shell hosting the four main tabs; [rootNavController] is used to push full-screen
 * destinations (review, exam attempt, result) that live outside the bottom bar. */
@Composable
fun HomeShell(rootNavController: NavHostController) {
    val tabNavController = rememberNavController()

    Scaffold(
        bottomBar = {
            val backStackEntry by tabNavController.currentBackStackEntryAsState()
            val currentRoute = backStackEntry?.destination?.route
            NavigationBar {
                bottomTabs.forEach { tab ->
                    NavigationBarItem(
                        selected = currentRoute == tab.route,
                        onClick = {
                            tabNavController.navigate(tab.route) {
                                popUpTo(tabNavController.graph.findStartDestination().id) { saveState = true }
                                launchSingleTop = true
                                restoreState = true
                            }
                        },
                        icon = { Icon(tab.icon, contentDescription = tab.label) },
                        label = { Text(tab.label) }
                    )
                }
            }
        }
    ) { padding ->
        NavHost(
            navController = tabNavController,
            startDestination = HomeTabs.DASHBOARD,
            modifier = Modifier.padding(padding)
        ) {
            composable(HomeTabs.DASHBOARD) { DashboardScreen() }
            composable(HomeTabs.STUDY) { StudyScreen(rootNavController = rootNavController) }
            composable(HomeTabs.EXAMS) { ExamListScreen(rootNavController = rootNavController) }
            composable(HomeTabs.PROGRESS) { ProgressScreen(rootNavController = rootNavController) }
        }
    }
}
