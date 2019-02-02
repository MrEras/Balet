package com.alas.balet.Screens;

import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.support.v7.app.ActionBar;
import android.support.v7.app.AppCompatActivity;
import android.view.MenuItem;
import android.view.View;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.TextView;

import com.alas.balet.Objects.Parking;
import com.alas.balet.R;
import com.squareup.picasso.Picasso;

public class GetParking extends AppCompatActivity {
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.show_parking);

        ActionBar actionBar = getSupportActionBar();
        actionBar.setDisplayOptions(ActionBar.DISPLAY_SHOW_CUSTOM);
        actionBar.setCustomView(R.layout.nav_bar);
        actionBar.setDisplayHomeAsUpEnabled(true);

        Intent i = getIntent();
        Parking parking = (Parking)i.getSerializableExtra("parking");

        ImageView parkingImage = findViewById(R.id.imageView2);
        TextView parkingName = findViewById(R.id.parkingName);
        TextView parkingDescription = findViewById(R.id.parkingDescription);
        TextView parkingPrice = findViewById(R.id.parkingPrice);
        TextView parkingPlaces = findViewById(R.id.parkingPlaces);
        Button btnBook = findViewById(R.id.button);

        Picasso.get().load(parking.getImage()).into(parkingImage);
        parkingName.setText(parking.getName());
        parkingDescription.setText(parking.getDescription());
        parkingPrice.setText("Precio: $"+parking.getPrice()+".00");
        parkingPlaces.setText("Lugares: "+parking.getSpaces()+" disponibles");

        final String latitude = parking.getLatitude();
        final String longitude = parking.getLongitude();
        final String name = parking.getName();

        parkingImage.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {
                Intent intent = new Intent(Intent.ACTION_VIEW, Uri.parse("geo:<"+latitude+">,<"+longitude+">?q=<"+latitude+">,<"+longitude+">("+name+")"));
                startActivity(intent);
            }
        });

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
    public void onClickBtn(View v)
    {
        Intent getParkingIntent = new Intent(GetParking.this, SignUp.class);
        startActivity(getParkingIntent);
    }
}
