# proguard-rules.pro

# Keep annotation attributes
-keepattributes *Annotation*

# Keep errorprone annotation classes if referenced
-dontwarn com.google.errorprone.**
-keep class com.google.errorprone.** { *; }

# Keep javax.annotation API classes
-dontwarn javax.annotation.**
-keep class javax.annotation.** { *; }

# Tink: keep classes referenced reflectively (conservative)
-dontwarn com.google.crypto.tink.**
-keep class com.google.crypto.tink.** { *; }

# Keep proto/auto-generated classes sometimes used by libs
-keep class com.google.protobuf.** { *; }
-dontwarn com.google.protobuf.**

# If libraries use javax.annotation.concurrent, keep it
-dontwarn javax.annotation.concurrent.**
-keep class javax.annotation.concurrent.** { *; }
