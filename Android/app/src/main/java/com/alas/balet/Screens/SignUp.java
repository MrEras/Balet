package com.alas.balet.Screens;

import android.content.Intent;
import android.os.Bundle;
import android.support.v7.app.ActionBar;
import android.support.v7.app.AppCompatActivity;
import android.view.MenuItem;
import android.view.View;
import android.widget.EditText;
import android.widget.TextView;

import com.alas.balet.R;

public class SignUp extends AppCompatActivity {
    EditText phoneEditText;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.sign_up);

        ActionBar actionBar = getSupportActionBar();
        actionBar.setDisplayOptions(ActionBar.DISPLAY_SHOW_CUSTOM);
        actionBar.setCustomView(R.layout.nav_bar);
        actionBar.setDisplayHomeAsUpEnabled(true);

        TextView barName = findViewById(R.id.txtTitle);
        barName.setText("Registro");

        phoneEditText = findViewById(R.id.editText);


    }

    public void sendPhone(View v)
    {
        String mobile = phoneEditText.getText().toString().trim();

        if(mobile.isEmpty() || mobile.length() < 10){
            phoneEditText.setError("Enter a valid mobile");
            phoneEditText.requestFocus();
            return;
        }

        Intent intent = new Intent(SignUp.this, SendCode.class);
        intent.putExtra("mobile", mobile);
        startActivity(intent);
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        switch (item.getItemId()) {
            case android.R.id.home:
                onBackPressed();
                return true;
        }

        return super.onOptionsItemSelected(item);
    }
}
