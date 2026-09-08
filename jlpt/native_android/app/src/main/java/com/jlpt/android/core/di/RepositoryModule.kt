package com.jlpt.android.core.di

import com.jlpt.android.data.repository.AuthRepositoryImpl
import com.jlpt.android.data.repository.ContentRepositoryImpl
import com.jlpt.android.data.repository.ExamRepositoryImpl
import com.jlpt.android.data.repository.StudyRepositoryImpl
import com.jlpt.android.domain.repository.AuthRepository
import com.jlpt.android.domain.repository.ContentRepository
import com.jlpt.android.domain.repository.ExamRepository
import com.jlpt.android.domain.repository.StudyRepository
import dagger.Binds
import dagger.Module
import dagger.hilt.InstallIn
import dagger.hilt.components.SingletonComponent
import javax.inject.Singleton

@Module
@InstallIn(SingletonComponent::class)
abstract class RepositoryModule {

    @Binds
    @Singleton
    abstract fun bindAuthRepository(impl: AuthRepositoryImpl): AuthRepository

    @Binds
    @Singleton
    abstract fun bindContentRepository(impl: ContentRepositoryImpl): ContentRepository

    @Binds
    @Singleton
    abstract fun bindStudyRepository(impl: StudyRepositoryImpl): StudyRepository

    @Binds
    @Singleton
    abstract fun bindExamRepository(impl: ExamRepositoryImpl): ExamRepository
}
