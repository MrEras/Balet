package com.alas.balet;

import android.app.Dialog;
import android.support.annotation.NonNull;
import android.support.design.widget.NavigationView;
import android.support.v4.widget.DrawerLayout;
import android.support.v7.app.ActionBar;
import android.support.v7.app.ActionBarDrawerToggle;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.MenuItem;
import android.widget.ListView;
import android.widget.Toast;

import com.alas.balet.com.alas.ListAdapters.ParkingsAdapter;
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
    ListView list;
    String[] name = {"Alejandro","Memo","Eras"};
    List<String> names = new ArrayList<>();
    //List<String> images = new ArrayList<>();
    //List<String> descriptions = new ArrayList<>();
    String[] images = {"https://www.uwgb.edu/UWGBCMS/media/Maps/images/map-icon.jpg"};
    String[] descriptions = {"Dios"};

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

        ValueEventListener postListener = new ValueEventListener(){
            @Override
            public void onDataChange(DataSnapshot snapshot) {
                for (DataSnapshot postSnapshot : snapshot.getChildren()) {
                    names.add(postSnapshot.child("Name").getValue().toString());
                    //images.add(postSnapshot.child("Name").getValue().toString());
                    //descriptions.add(postSnapshot.child("Name").getValue().toString());

                    //HOLA ALEX, cambie el adaptador a aqui para que se muestre despues de leer cambio :O
                    // y ya solo seria cmbiarle de array a List<String>  aqui y en  ParkingsAdapter las otras propiedades
                    // o que?

                    ParkingsAdapter adapter=new ParkingsAdapter(MainActivity.this, names, images,descriptions);
                    list=(ListView)findViewById(R.id.list);
                    list.setAdapter(adapter);
                }

            }
            @Override
            public void onCancelled(DatabaseError firebaseError) {

            }
        };
        reference.addValueEventListener(postListener);//addListenerForSingleValueEvent
        //names.add("alex");
        //ParkingsAdapter adapter=new ParkingsAdapter(MainActivity.this, names, images,descriptions);
        //list=(ListView)findViewById(R.id.list);
        //list.setAdapter(adapter);



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
    public boolean onOptionsItemSelected(MenuItem item) {
        if (toggleBar.onOptionsItemSelected(item)) {
            return true;
        }
        return super.onOptionsItemSelected(item);
    }

}
