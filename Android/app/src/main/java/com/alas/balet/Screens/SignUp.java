package com.alas.balet.Screens;

import android.content.Intent;
import android.os.Bundle;
import android.support.v7.app.ActionBar;
import android.support.v7.app.AppCompatActivity;
import android.view.MenuItem;
import android.view.View;
import android.widget.EditText;
import android.widget.TextView;

import com.alas.balet.MainActivity;
import com.alas.balet.Objects.User;
import com.alas.balet.R;

public class SignUp extends AppCompatActivity {
    User user = new User();
    EditText phoneEditText;
    EditText nameEditText;
    EditText passwordEditText;
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
        nameEditText = findViewById(R.id.editText2);
        passwordEditText = findViewById(R.id.editText3);

    }

    public void sendPhone(View v)
    {
        String mobile = phoneEditText.getText().toString().trim();

        if(mobile.isEmpty() || mobile.length() < 10){
            phoneEditText.setError("Enter a valid mobile");
            phoneEditText.requestFocus();
            return;
        }

        user.setPhone(phoneEditText.getText().toString().trim());
        user.setName(nameEditText.getText().toString().trim());
        user.setPassword(passwordEditText.getText().toString().trim());

        Intent intent = new Intent(SignUp.this, SendCode.class);
        intent.putExtra("user", user);
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
