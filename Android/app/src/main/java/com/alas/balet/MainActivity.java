package com.alas.balet;

import android.app.Dialog;
import android.content.Intent;
import android.support.annotation.NonNull;
import android.support.design.widget.NavigationView;
import android.support.v4.widget.DrawerLayout;
import android.support.v7.app.ActionBar;
import android.support.v7.app.ActionBarDrawerToggle;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.MenuItem;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ListView;
import android.widget.Toast;

import com.alas.balet.ListAdapters.ParkingsAdapter;
import com.alas.balet.Objects.Parking;
import com.alas.balet.Screens.GetParking;
import com.google.firebase.database.DataSnapshot;
import com.google.firebase.database.DatabaseError;
import com.google.firebase.database.DatabaseReference;
import com.google.firebase.database.FirebaseDatabase;
import com.google.firebase.database.ValueEventListener;

import java.util.ArrayList;
import java.util.List;

public class MainActivity extends AppCompatActivity {
    private DatabaseReference mDatabase;
    private DrawerLayout drawerLayout;
    private ActionBarDrawerToggle toggleBar;
    private NavigationView navigationView;
    private Dialog locationDialog;
    List<Parking> parkings = new ArrayList<>();
    ListView parkingsList;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        drawerLayout = findViewById(R.id.activity_main);
        toggleBar = new ActionBarDrawerToggle(this, drawerLayout,R.string.Open, R.string.Close);
        drawerLayout.addDrawerListener(toggleBar);
        toggleBar.syncState();

        getSupportActionBar().setDisplayOptions(ActionBar.DISPLAY_SHOW_CUSTOM);
        getSupportActionBar().setCustomView(R.layout.nav_bar);
        getSupportActionBar().setDisplayHomeAsUpEnabled(true);

        mDatabase = FirebaseDatabase.getInstance().getReference();
        DatabaseReference reference = mDatabase.child("Parkings");

        final ParkingsAdapter adapter=new ParkingsAdapter(MainActivity.this, parkings);
        parkingsList = findViewById(R.id.list);
        parkingsList.setAdapter(adapter);

        ValueEventListener postListener = new ValueEventListener(){
            @Override
            public void onDataChange(DataSnapshot snapshot) {
                for (DataSnapshot postSnapshot : snapshot.getChildren()) {
                    boolean flag = false;

                    Parking parking = new Parking();
                    parking.setId(Integer.parseInt(postSnapshot.child("id").getValue().toString()));
                    parking.setName(postSnapshot.child("name").getValue().toString());
                    parking.setDescription(postSnapshot.child("description").getValue().toString());
                    parking.setPrice(Integer.parseInt(postSnapshot.child("price").getValue().toString()));
                    parking.setImage(postSnapshot.child("image").getValue().toString());
                    parking.setSpaces(Integer.parseInt(postSnapshot.child("spaces").getValue().toString()));
                    parking.setLatitude(postSnapshot.child("latitude").getValue().toString());
                    parking.setLongitude(postSnapshot.child("longitude").getValue().toString());

                    //Update
                    for(Parking parkingAux:parkings){
                        if(parkingAux.getId() == parking.getId()){
                            parkings.remove(parkingAux);
                            parkings.add(parking);
                            flag = true;
                            break;
                        }
                    }

                    //Add
                    if(flag == false){
                        parkings.add(parking);
                    }

                    adapter.notifyDataSetChanged();

                }

            }
            @Override
            public void onCancelled(DatabaseError firebaseError) {

            }
        };
        reference.addValueEventListener(postListener);

        parkingsList.setOnItemClickListener(new AdapterView.OnItemClickListener() {
            @Override
            public void onItemClick(AdapterView<?> parent, View view, int position, long id) {
                Parking parkingAux;
                String idIntentParameter = String.valueOf(parkings.get(position).getId());
                for(Parking parking:parkings){
                    if(parking.getId() == Integer.parseInt(idIntentParameter)){
                        Intent getParkingIntent = new Intent(MainActivity.this, GetParking.class);
                        getParkingIntent.putExtra("parking", parking);
                        startActivity(getParkingIntent);
                        break;
                    }
                }
            }
        });

//        locationDialog = new Dialog(this);
//        locationDialog.setContentView(R.layout.location_dialog);
//        final Button btnUnderstood = locationDialog.findViewById(R.id.btnUnderstood);

//        locationDialog.getWindow().setBackgroundDrawable(new ColorDrawable(Color.TRANSPARENT));
//        locationDialog.show();

//        btnUnderstood.setOnClickListener(new View.OnClickListener() {
//            public void onClick(View v) {
//                locationDialog.dismiss();
//            }
//        });

        //Navigation and side menu
        navigationView = findViewById(R.id.nv);
        navigationView.setNavigationItemSelectedListener(new NavigationView.OnNavigationItemSelectedListener() {
            @Override
            public boolean onNavigationItemSelected(@NonNull MenuItem item) {
                int id = item.getItemId();
                switch(id)
                {
                    case R.id.account:
                        Toast.makeText(MainActivity.this, "Mi cuenta",Toast.LENGTH_SHORT).show();
                        break;
                    case R.id.drivers:
                        Toast.makeText(MainActivity.this, "Choferes",Toast.LENGTH_SHORT).show();
                        break;
                    case R.id.payment:
                        Toast.makeText(MainActivity.this, "Pagos",Toast.LENGTH_SHORT).show();
                        break;
                    case R.id.historial:
                        Toast.makeText(MainActivity.this, "Historial",Toast.LENGTH_SHORT).show();
                        break;
                    case R.id.legal:
                        Toast.makeText(MainActivity.this, "Legal",Toast.LENGTH_SHORT).show();
                        break;
                    default:
                        return true;
                }
                return true;
            }
        });

    }

    @Override
    public void onStart() {
        super.onStart();
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        if (toggleBar.onOptionsItemSelected(item)) {
            return true;
        }
        return super.onOptionsItemSelected(item);
    }

}
