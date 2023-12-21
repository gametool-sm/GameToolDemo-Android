package com.gametool.demo;

import android.app.Dialog;
import android.content.Context;
import android.graphics.Color;
import android.graphics.drawable.ColorDrawable;
import android.os.Bundle;
import android.view.Window;
import android.widget.TextView;

import androidx.annotation.NonNull;

public class SwitchInitTypeDialog extends Dialog {

    private TextView cancelTv;
    private TextView ensureTv;

    public SwitchInitTypeDialog(@NonNull Context context) {
        super(context);
        setContentView(R.layout.dialog_switch_init_type);
        setCancelable(false);
        setCanceledOnTouchOutside(false);
    }

    @Override
    protected void onStart() {
        super.onStart();
        Window window = getWindow();
        if (window == null) {
            return;
        }
        window.setWindowAnimations(R.style.Dialog_Animation_Style);
        window.setBackgroundDrawable(new ColorDrawable(Color.TRANSPARENT));
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        cancelTv = findViewById(R.id.cancel_tv);
        ensureTv = findViewById(R.id.ensure_tv);
        cancelTv.setOnClickListener(v -> dismiss());
        ensureTv.setOnClickListener(v -> System.exit(0));
    }
}
