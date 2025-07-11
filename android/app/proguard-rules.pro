# Kustom API (do not change this)
-keepattributes Signature,Exceptions,*Annotation*,SourceFile,LineNumberTable,EnclosingMethod
-keep class org.kustom.**
-keepclassmembers class org.kustom.** { *; }

# Keep classes that are referenced in the AndroidManifest.xml file.
-keep public class * extends android.content.ContentProvider

# Keep the Kustom API-generated classes.
-keep class org.bitbucket.frankmonza.kustomapi.** { *; }

# Keep the Kustom Preset-generated classes.
-keep class org.bitbucket.frankmonza.kustompreset.** { *; }

# Apply the default ProGuard rules that are packaged with the Android Gradle plugin.

# Your own rules here.

################################################################################################
# You can specify any path and filename.
# -printconfiguration app/build/tmp/full-r8-config.txt

