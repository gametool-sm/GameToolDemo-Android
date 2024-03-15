package com.gametool.demo;

import android.content.Context;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.text.TextUtils;
import android.util.Log;
import android.view.View;
import android.widget.EditText;
import android.widget.TextView;
import android.widget.Toast;

import com.gametool.gtsdk.utils.GTSDK;

/**
 * Quick Start
 * Simple Access Example
 */
public class QuickStartActivity extends AppCompatActivity implements View.OnClickListener {

    private static final String TAG = "GTSDK-demo";
    private static final String SP_CURRENT_INIT_YPE = "spCurrentInitType";
    /**
     * 默认初始化类型启动
     */
    private static final int INIT_TYPE_DEFAULT = 0;

    /**
     * 自定义初始化类型启动
     */
    private static final int INIT_TYPE_CUSTOM = 1;

    private SharedPreferences sp;
    private TextView initTypeTv;
    private TextView switchInitTypeTv;
    private EditText userIdEt;
    private TextView loginTv;
    private TextView showGtDialogTv;

    /**
     * 是否默认初始化成功
     */
    private boolean isInitSuccess;

    /**
     * 是否自定义初始化成功
     */
    private boolean isCustomInitSuccess;

    private void toastMessage(String msg) {
        Toast.makeText(this, msg, Toast.LENGTH_SHORT).show();
    }

    private int getCurrentInitType() {
        return sp.getInt(SP_CURRENT_INIT_YPE, INIT_TYPE_DEFAULT);
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        sp = getSharedPreferences("GTSDK-DEMO", Context.MODE_PRIVATE);
        StatusUtil.setFullScreenStatus(this);
        setContentView(R.layout.activity_quick_start);

        initTypeTv = findViewById(R.id.demo_init_gtsdk_type_tv);
        switchInitTypeTv = findViewById(R.id.demo_switch_init_gtsdk_type_tv);
        userIdEt = findViewById(R.id.demo_user_id_et);
        loginTv = findViewById(R.id.demo_login_gtsdk_tv);
        showGtDialogTv = findViewById(R.id.demo_show_gtsdk_dialog_tv);

        switchInitTypeTv.setOnClickListener(this);
        loginTv.setOnClickListener(this);
        showGtDialogTv.setOnClickListener(this);

        //GTSDK初始化
        int currentInitType = getCurrentInitType();
        if (currentInitType == INIT_TYPE_DEFAULT) {
            //默认类型初始化
            initGTSDK();
            initTypeTv.setText("初始化类型：默认");
            switchInitTypeTv.setText("自定义");
            showGtDialogTv.setVisibility(View.GONE);
        } else if (currentInitType == INIT_TYPE_CUSTOM) {
            //自定义类型初始化
            customInitGTSDK();
            initTypeTv.setText("初始化类型：自定义");
            switchInitTypeTv.setText("默认");
            showGtDialogTv.setVisibility(View.VISIBLE);
        }
    }

    @Override
    public void onClick(View v) {
        if (v == switchInitTypeTv) {
            switchInitType();
        } else if (v == loginTv) {
            toLogin();
        } else if (v == showGtDialogTv) {
            showGtDialog();
        }
    }

    private void switchInitType() {
        int currentInitType = getCurrentInitType();
        if (currentInitType == INIT_TYPE_DEFAULT) {
            //切换到自定义类型初始化
            sp.edit().putInt(SP_CURRENT_INIT_YPE, INIT_TYPE_CUSTOM).apply();
            initTypeTv.setText("初始化类型：自定义");
            switchInitTypeTv.setText("默认");
            showGtDialogTv.setVisibility(View.VISIBLE);
        } else if (currentInitType == INIT_TYPE_CUSTOM) {
            //切换到默认类型初始化
            sp.edit().putInt(SP_CURRENT_INIT_YPE, INIT_TYPE_DEFAULT).apply();
            initTypeTv.setText("初始化类型：默认");
            switchInitTypeTv.setText("自定义");
            showGtDialogTv.setVisibility(View.GONE);
        }

        new SwitchInitTypeDialog(this).show();
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
                Log.e(TAG, "默认初始化失败，原因：" + s);
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
                Log.e(TAG, "自定义初始化失败，原因：" + s);
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
            return;
        }
        //游戏方自己提供的针对用户的唯一标识
        String userId = userIdEt.getText().toString();
        if (TextUtils.isEmpty(userId)) {
            toastMessage("请先输入userId");
        }
        userIdEt.clearFocus();
        //真正的登录API调用，参数为用户唯一标识
        GTSDK.loginWithUserId(userId);
    }

}