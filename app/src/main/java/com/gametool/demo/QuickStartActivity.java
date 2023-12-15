package com.gametool.demo;

import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.EditText;
import android.widget.TextView;

import androidx.appcompat.app.AppCompatActivity;

import com.gametool.gtsdk.utils.GTSDK;

/**
 * Quick Start
 * Simple Access Example
 */
public class QuickStartActivity extends AppCompatActivity implements View.OnClickListener {

    private static final String TAG = "GTSDK-demo";

    private TextView initTv;
    private TextView customInitTv;
    private TextView showGtDialogTv;
    private TextView clicksTv;
    private TextView longPressTimesTv;
    private EditText userIdEt;
    private TextView loginTv;

    private long clickNum = 0;
    private long longPressNum = 0;

    /**
     * 是否初始化成功
     */
    private boolean isInitSuccess;

    /**
     * 是否是自定义初始化
     */
    private boolean isCustomInitSuccess;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        StatusUtil.setFullScreenStatus(this);
        setContentView(R.layout.activity_quick_start);

        initTv = findViewById(R.id.demo_init_gtsdk_tv);
        customInitTv = findViewById(R.id.demo_custom_init_gtsdk_tv);
        showGtDialogTv = findViewById(R.id.demo_show_gtsdk_dialog_tv);
        userIdEt = findViewById(R.id.demo_user_id_et);
        loginTv = findViewById(R.id.demo_login_tv);
        clicksTv = findViewById(R.id.demo_clicks_tv);
        longPressTimesTv = findViewById(R.id.demo_long_press_times_tv);
        clicksTv.setOnClickListener(v -> clicksTv.setText(String.format("点击次数：%1$s", ++clickNum)));
        longPressTimesTv.setOnLongClickListener(v -> {
            longPressTimesTv.setText(String.format("长按次数：%1$s", ++longPressNum));
            return true;
        });

        //接入示例相关
        initTv.setOnClickListener(this);
        customInitTv.setOnClickListener(this);
        showGtDialogTv.setOnClickListener(this);
        initTv.setOnClickListener(this);
    }

    @Override
    public void onClick(View v) {
        if (v == initTv) {
            initGTSDK();
        } else if (v == customInitTv) {
            customInitGTSDK();
        } else if (v == showGtDialogTv) {
            showGtDialog();
        } else if (v == loginTv) {
            toLogin();
        }
    }

    /**
     * 初始化GTSDK
     * GTSDK.InitListener回调会在UI线程中执行
     */
    private void initGTSDK() {
        GTSDK.initWithAppKey(this, true, new GTSDK.InitListener() {
            @Override
            public void onSuccess() {
                //初始化成功
                isInitSuccess = true;
            }

            @Override
            public void onFail(String s) {
                //初始化失败
                isInitSuccess = false;
                Log.d(TAG, "初始化失败，原因：" + s);
            }
        });
    }

    /**
     * 自定义初始化GTSDK
     * GTSDK.InitListener回调会在UI线程中执行
     */
    private void customInitGTSDK() {
        GTSDK.initWithAppKey(this, false, new GTSDK.InitListener() {
            @Override
            public void onSuccess() {
                //自定义初始化成功
                isInitSuccess = true;
                isCustomInitSuccess = true;
            }

            @Override
            public void onFail(String s) {
                //自定义初始化失败
                isInitSuccess = false;
                isCustomInitSuccess = false;
                Log.d(TAG, "自定义初始化失败，原因：" + s);
            }
        });
    }

    /**
     * 自定义初始化成功后，悬浮球不会展示，可以自定义悬浮球弹出时机；
     * 初始化成功后调用GTSDK.openDialog()展示，此方法需要在UI线程中执行
     */
    private void showGtDialog() {
        if (!isCustomInitSuccess) {
            return;
        }
        GTSDK.openDialog();
    }

    /**
     * 登录（可选接入）
     * 需要在初始化成功后才能调用登录
     */
    private void toLogin() {
        if (!isInitSuccess) {
            Log.d(TAG, "请先初始化");
            return;
        }
        userIdEt.clearFocus();
        //游戏方自己提供的针对用户的唯一标识
        String userId = userIdEt.getText().toString();
        //真正的登录API调用，userId由游戏方传
        GTSDK.loginWithUserId(userId);
    }

}