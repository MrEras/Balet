package com.alas.balet.com.alas.ListAdapters;

import android.app.Activity;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.ImageView;
import android.widget.TextView;

import com.alas.balet.R;
import com.squareup.picasso.Picasso;

import java.util.List;

public class ParkingsAdapter extends ArrayAdapter<String> {

    private final Activity context;
    private final List<String> names;
    private final String[] descriptions; //List<String> ?
    private final String[] images;

    public ParkingsAdapter(Activity context, List<String> names, String[] images, String[] descriptions) {
        super(context, R.layout.parking_list, names);
        // TODO Auto-generated constructor stub

        this.context = context;
        this.names = names;
        this.images = images;
        this.descriptions = descriptions;
    }


    public View getView(int position, View view, ViewGroup parent) {

        LayoutInflater inflater = context.getLayoutInflater();
        View rowView = inflater.inflate(R.layout.parking_list, null,true);

        TextView drivers_name = rowView.findViewById(R.id.drivers_name);
        ImageView drivers_image = rowView.findViewById(R.id.drivers_image);
        TextView drivers_description = rowView.findViewById(R.id.drivers_description);

        drivers_name.setText(names.get(position));
        Picasso.get()
                .load(images[position])
                .into(drivers_image);
        drivers_description.setText(descriptions[position]);
        return rowView;

    };
}