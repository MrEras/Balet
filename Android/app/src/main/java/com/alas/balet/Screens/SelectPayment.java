package com.alas.balet.Screens;

import android.content.Intent;
import android.os.Bundle;
import android.support.v7.app.ActionBar;
import android.support.v7.app.AppCompatActivity;
import android.view.MenuItem;
import android.widget.TextView;

import com.alas.balet.MainActivity;
import com.alas.balet.R;
import com.google.firebase.auth.FirebaseAuth;

public class SelectPayment extends AppCompatActivity {
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.select_payment);

        ActionBar actionBar = getSupportActionBar();
        actionBar.setDisplayOptions(ActionBar.DISPLAY_SHOW_CUSTOM);
        actionBar.setCustomView(R.layout.nav_bar);
        actionBar.setDisplayHomeAsUpEnabled(true);

        TextView barName = findViewById(R.id.txtTitle);
        barName.setText("Pagos");



    }
    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        switch (item.getItemId()) {
            case android.R.id.home:
                if(FirebaseAuth.getInstance().getCurrentUser() == null){
                    onBackPressed();
                    return true;
                }
                else{
                    Intent intent = new Intent(SelectPayment.this, MainActivity.class);
                    startActivity(intent);
                    return true;
                }

        }

        return super.onOptionsItemSelected(item);
    }

}
