package com.alas.balet.ListAdapters;

import android.app.Activity;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.ImageView;
import android.widget.TextView;

import com.alas.balet.Objects.Parking;
import com.alas.balet.R;
import com.squareup.picasso.Picasso;

import java.util.List;

public class ParkingsAdapter extends ArrayAdapter<Parking> {

    private final Activity context;
    private final List<Parking> parkings;

    public ParkingsAdapter(Activity context,List<Parking> parkings) {
        super(context, R.layout.parking_list, parkings);
        // TODO Auto-generated constructor stub
        this.context = context;
        this.parkings = parkings;
    }


    public View getView(int position, View view, ViewGroup parent) {

        LayoutInflater inflater = context.getLayoutInflater();
        View rowView = inflater.inflate(R.layout.parking_list, null,true);

        TextView drivers_name = rowView.findViewById(R.id.drivers_name);
        ImageView drivers_image = rowView.findViewById(R.id.drivers_image);
        TextView drivers_description = rowView.findViewById(R.id.drivers_description);

        drivers_name.setText(parkings.get(position).getName());
        Picasso.get()
                .load(parkings.get(position).getImage())
                .into(drivers_image);
        drivers_description.setText(parkings.get(position).getDescription());
        return rowView;

    };
}