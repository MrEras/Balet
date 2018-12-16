package com.alas.balet;

import android.os.Bundle;
import android.support.v7.app.ActionBar;
import android.support.v7.app.AppCompatActivity;
import android.widget.TextView;

public class GetLocation extends AppCompatActivity {
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_get_location);
        getSupportActionBar().setDisplayOptions(ActionBar.DISPLAY_SHOW_CUSTOM);
        getSupportActionBar().setCustomView(R.layout.nav_bar);
        getSupportActionBar().setDisplayHomeAsUpEnabled(true);

        TextView location = findViewById(R.id.test);
        String sessionId= getIntent().getStringExtra("location");
        location.setText(sessionId);
    }
    @Override
    public boolean onSupportNavigateUp(){
        finish();
        return true;
    }
}
