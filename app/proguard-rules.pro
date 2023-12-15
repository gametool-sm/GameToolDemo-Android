# 代码混淆压缩比，在0和7之间，默认为5，一般不需要改
-optimizationpasses 5
# 包名不混合大小写。ProGuard就会默认混用大小写文件名，会导致class文件相互覆盖。
-dontusemixedcaseclassnames
# 指定不去忽略非公共的库和类，不要跳过对非公开类的处理，默认情况下是跳过的
-dontskipnonpubliclibraryclasses
# 优化，不优化输入的类文件
-dontoptimize
# 忽略警告
-ignorewarnings
# 指定不去忽略非公共的库的类的成员
-dontskipnonpubliclibraryclassmembers
# 不做预校验，preverify是proguard的4个步骤之一，Android不需要preverify，去掉这一步可加快混淆速度
-dontpreverify
# 混淆时是否记录日志，混淆后就会生成映射文件，可以使用printmapping指定映射文件的名称
-verbose
# 指定混淆时采用的算法，后面的参数是一个过滤器，这个过滤器是谷歌推荐的算法，一般不改变
-optimizations !code/simplification/arithmetic,!field/*,!class/merging/*
# 保护代码中的Annotation不被混淆，这在JSON实体映射时非常重要，比如fastJson
-keepattributes *Annotation*,InnerClasses
# 避免混淆泛型，这在JSON实体映射时非常重要，比如fastJson
-keepattributes Signature
# 抛出异常时保留代码行号，在异常分析中可以方便定位
-keepattributes Exceptions,InnerClasses,Signature,Deprecated,SourceFile,LineNumberTable,*Annotation*,EnclosingMethod
# 不压缩，ProGuard会收缩代码，它会删除所有未使用的类和类成员
-dontshrink
# 保存包名
-keeppackagenames
#============================oaid相关混淆==============================
-keep class com.bun.miitmdid.core.** {*;}
-keep class com.bun.lib.**{*;}
-keep class com.bun.miitmdid.**{*;}
-keep interface com.bun.supplier.** { *; }
-keep class XI.CA.XI.**{*;}
-keep class XI.K0.XI.**{*;}
-keep class XI.XI.K0.**{*;}
-keep class XI.xo.XI.XI.**{*;}
-keep public class com.netease.nis.sdkwrapper.Utils {public <methods>;}
# asus
-keep class com.asus.msa.SupplementaryDID.**{*;}
-keep class com.asus.msa.sdid.**{*;}
# huawei
-keep class com.huawei.hms.ads.** {*;}
-keep class com.huawei.hms.ads.identifier.**{*;}
-keep interface com.huawei.hms.ads.** {*;}
# lenovo
-keep class com.zui.deviceidservice.** {*;}
-keep class com.zui.opendeviceidlibrary.** {*;}
# meizu
-keep class com.meizu.flyme.openidsdk.** {*;}
# nubia
-keep class com.bun.miitmdid.provider.nubia.NubiaIdentityImpl {*;}
# oppo
-keep class com.heytap.openid.** {*;}
# samsung
-keep class com.samsung.android.deviceidservice.**{*;}
# vivo
-keep class com.vivo.identifier.** {*;}
# xiaomi
-keep class com.bun.miitmdid.provider.xiaomi.IdentifierManager {*;}
# zte
-keep class com.bun.lib.** { *; }
# coolpad
-keep class com.coolpad.deviceidsupport.** { *; }
#=====================================================================
# 保留所有的本地native方法不被混淆
-keepclasseswithmembernames class * {
    native <methods>;
}

# 枚举类不能被混淆
-keepclassmembers enum * {
    public static **[] values();
    public static ** valueOf(java.lang.String);
}

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
-keep class android.** { *; }
-dontwarn android.**
-keep class androidx.**{*;}
-dontwarn androidx.**
-keep class com.android.** { *; }
-dontwarn android.support.**
-dontwarn android.support-v4.**
-dontwarn android.support.v4.**
-keep class android.support.v4.**{*;}
-keep interface android.support.v4.app.**{*;}

-keepnames class * extends android.app.Fragment
-keepnames class * extends androidx.fragment.app.Fragment
-keep public class * extends android.app.Activity
-keep public class * extends android.app.Application
-keep public class * extends android.app.Service
-keep public class * extends android.content.BroadcastReceiver
-keep public class * extends android.content.ContentProvider
-keep public class * extends android.app.backup.BackupAgentHelper
-keep public class * extends android.preference.Preference
#如果有引用v4包可以添加下面这行
-keep public class * extends android.support.v4.app.Fragment
-keepclassmembers class * extends android.app.Activity {
   public void *(android.view.View);
}

-dontwarn com.google.**
-dontwarn com.google.gson.**
-keep class com.google.**{*;}
-keep class com.google.gson.** {*;}
-dontwarn org.json.**
-keep class org.json.** {*;}
-keepclassmembers class * {
   public <init>(org.json.JSONObject);
}
-dontwarn okhttp3.**
-keep class okhttp3.**{*;}

-dontwarn okio.**
-keep class okio.**{*;}

-dontwarn com.squareup.wire.**
-keep class com.squareup.wire.** {*;}

-keep class android.net.compatibility.** { *; }
-keep class android.net.http.** { *; }

-keepclassmembers class * {
    @android.webkit.JavascriptInterface <methods>;
}

-dontwarn android.content.pm.**
-dontwarn com.xiaomi.**
-dontwarn com.huawei.**
-keep class android.content.pm.**{*;}
-keep class com.xiaomi.** {*;}
-keep class com.huawei.** {*;}
#############################################################################################
########################                 以上通用           ##################################
#############################################################################################
#eventbus
-keepattributes *Annotation*
-keepclassmembers class * {
    @org.greenrobot.eventbus.Subscribe <methods>;
}
-keep enum org.greenrobot.eventbus.ThreadMode { *; }
-keepclassmembers class * extends org.greenrobot.eventbus.util.ThrowableFailureEvent {
    <init>(java.lang.Throwable);
}

#litePal
-keep class org.litepal.** {*;}
-keep class * extends org.litepal.crud.LitePalSupport {*;}

#gms相关混淆
-keep class com.google.android.gms.common.ConnectionResult {
    int SUCCESS;
}
-keep class com.google.android.gms.ads.identifier.AdvertisingIdClient {
    com.google.android.gms.ads.identifier.AdvertisingIdClient$Info getAdvertisingIdInfo(android.content.Context);
}
-keep class com.google.android.gms.ads.identifier.AdvertisingIdClient$Info {
    java.lang.String getId();
    boolean isLimitAdTrackingEnabled();
}

-keep class com.gametool.base.utils.ScreenUtil{*;}
-keep class com.gametool.gtsdk.utils.GTSDK{*;}
-keep class com.gametool.gtsdk.utils.GTSDK$InitListener{*;}
#接口数据 bean 类不混淆
-keep class com.gametool.base.network.bean.**{
    <fields>;
    <methods>;
}
-keep class com.smwl.x7encrypt.**{*;}
-dontwarn com.smwl.x7encrypt.**

# ContentProvider的继承类不能被混淆
#-keep class com.gametool.speedup.plugin.GtSpeedupProvider{*;}

# filedownloader不能被混淆
-keep class com.liulishuo.filedownloader.**{*;}