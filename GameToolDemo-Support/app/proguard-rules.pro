# 代码混淆压缩比，在0和7之间
-optimizationpasses 5
# 包名不混合大小写
-dontusemixedcaseclassnames
# 指定不去忽略非公共的库和类，不要跳过对非公开类的处理，默认情况下是跳过的
-dontskipnonpubliclibraryclasses
# 优化，不优化输入的类文件
-dontoptimize
# 忽略警告
-ignorewarnings
# 指定不去忽略非公共的库的类的成员
-dontskipnonpubliclibraryclassmembers
# 不做预校验
-dontpreverify
# 混淆时记录日志
-verbose
# 指定混淆时采用的算法
-optimizations !code/simplification/arithmetic,!field/*,!class/merging/*
-keepattributes Exceptions,InnerClasses,Signature,Deprecated,SourceFile,LineNumberTable,*Annotation*,EnclosingMethod
# 不压缩
-dontshrink
# 保存包名
-keeppackagenames
###############################################################################################
# 保留自定义控件（继承自View）不被混淆
-keep public class * extends android.view.View {
    *** get*();
    void set*(***);
    public <init>(android.content.Context);
    public <init>(android.content.Context, android.util.AttributeSet);
    public <init>(android.content.Context, android.util.AttributeSet, int);
}

# 保留Parcelable序列化的类不被混淆
-keep class * implements android.os.Parcelable {
    public static final android.os.Parcelable$Creator *;
}

# 保留Serializable序列化的类不被混淆
-keepclassmembers class * implements java.io.Serializable {
    static final long serialVersionUID;
    private static final java.io.ObjectStreamField[] serialPersistentFields;
    !static !transient <fields>;
    !private <fields>;
    !private <methods>;
    private void writeObject(java.io.ObjectOutputStream);
    private void readObject(java.io.ObjectInputStream);
    java.lang.Object writeReplace();
    java.lang.Object readResolve();
}

# 不混淆资源类
-keep class **.R{*;}
-keep class **.R$*{*;}
-keepclassmembers class **.R$*{
    public static <fields>;
}

# android
-dontwarn android.**
-dontwarn androidx.**
-dontwarn com.android.**
-dontwarn android.support.v4.**

-keep class android.** {*;}
-keep class androidx.** {*;}
-keep class com.android.** {*;}
-keep class android.support.v4.**{*;}

-keep public class * extends android.app.Fragment
-keep public class * extends androidx.fragment.app.Fragment
-keep public class * extends android.app.Activity
-keep public class * extends android.app.Application
-keep public class * extends android.app.Service
-keep public class * extends android.content.BroadcastReceiver
-keep public class * extends android.content.ContentProvider
-keep public class * extends android.app.backup.BackupAgentHelper
-keep public class * extends android.preference.Preference
-keep public class * extends android.support.v4.app.Fragment
######################################## 以上通用 ##############################################

##################################### 以下是必须配置的 ##########################################
# 保留所有的本地native方法不被混淆
-keepclasseswithmembernames class * {
    native <methods>;
}

# JavascriptInterface注解标注的不被混淆
-keepclassmembers class * {
    @android.webkit.JavascriptInterface <methods>;
}

# 枚举类不能被混淆
-keepclassmembers enum * {
    public static **[] values();
    public static ** valueOf(java.lang.String);
}

#eventbus
-keepattributes *Annotation*
-keepclassmembers class * {
    @org.greenrobot.eventbus.Subscribe <methods>;
}
-keep enum org.greenrobot.eventbus.ThreadMode {*;}
-keepclassmembers class * extends org.greenrobot.eventbus.util.ThrowableFailureEvent {
    <init>(java.lang.Throwable);
}

#litePal
-keep class org.litepal.** {*;}
-keep class * extends org.litepal.crud.LitePalSupport {*;}

#google
-keep class com.google.** {*;}
#GT接口数据 bean 类不混淆
-keep class com.gametool.base.network.bean.** {*;}
#GT加速初始化回调接口不被混淆
-keep interface com.gametool.speedup.callback.ISpeedupConfigCallback{*;}