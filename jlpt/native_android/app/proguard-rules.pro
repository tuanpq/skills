# Retrofit / OkHttp
-dontwarn okhttp3.**
-dontwarn retrofit2.**
-keepattributes Signature
-keepattributes *Annotation*

# kotlinx.serialization: keep serializer() for our DTOs
-keepclassmembers class com.jlpt.android.data.remote.dto.** {
    *** Companion;
}
-keepclasseswithmembers class com.jlpt.android.data.remote.dto.** {
    kotlinx.serialization.KSerializer serializer(...);
}
-keep,includedescriptorclasses class com.jlpt.android.data.remote.dto.**$$serializer { *; }
