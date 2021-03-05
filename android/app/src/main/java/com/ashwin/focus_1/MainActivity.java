package com.ashwin.focus_1;

import android.content.Intent;
import android.os.Build;
import android.os.Bundle;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;


public class MainActivity extends FlutterActivity {

    private Intent forService;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
//        GeneratedPluginRegistrant.registerWith(this);

        forService = new Intent(MainActivity.this, MyService.class);

        new MethodChannel(getFlutterEngine().getDartExecutor().getBinaryMessenger(), "com.ashwin.focus_1")
                .setMethodCallHandler(new MethodChannel.MethodCallHandler() {
                    @Override
                    public void onMethodCall(MethodCall methodCall, MethodChannel.Result result) {
                        if (methodCall.method.equals("startService")) {
                            startService();
                            result.success("Service Started");
                        }
                    }
                });


    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
        stopService(forService);
    }

    private void startService() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            startForegroundService(forService);
        } else {
            startService(forService);
        }
    }


}
//package com.ashwin.focus_1;
//
//import android.content.Intent;
//import android.os.Build;
//import android.os.Bundle;
//
//import androidx.annotation.NonNull;
//import androidx.annotation.Nullable;
//
//import java.lang.reflect.Method;
//

//import io.flutter.plugin.common.MethodCall;
//import io.flutter.plugin.common.MethodChannel;
//import io.flutter.plugins.GeneratedPluginRegistrant;
//
//public class MainActivity extends FlutterActivity {
//    private Intent forService;
//    @Override
//    protected void onCreate(@Nullable Bundle savedInstanceState) {
//        super.onCreate(savedInstanceState);
//        GeneratedPluginRegistrant.registerWith(this);
//
//        forService = new Intent(MainActivity.this,MyService.class);
//        new MethodChannel(getFlutterView(),"com.ashwin.focus_1")
//                .setMethodCallHandler(new MethodChannel.MethodCallHandler() {
//            @Override
//            public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
//                if (call.method.equals("startService")){
//                    startService();
//                    result.success("serviceStarted");
//
//                }
//
//            }
//        });
//    }
//private void startService(){
//    if(Build.VERSION.SDK_INT >=Build.VERSION_CODES.O){
//        startForegroundService(forService);
//    }else{
//        startService(forService);
//    }
//}
//}

