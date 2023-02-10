package cz.mendelu.thetrips.fragments

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View

import com.google.android.gms.maps.CameraUpdateFactory
import com.google.android.gms.maps.GoogleMap
import com.google.android.gms.maps.OnMapReadyCallback
import com.google.android.gms.maps.SupportMapFragment
import com.google.android.gms.maps.model.*
import cz.mendelu.thetrips.R
import cz.mendelu.thetrips.architecture.BaseFragment
import cz.mendelu.thetrips.databinding.FragmentMapsBinding
import cz.mendelu.thetrips.model.Trip
import cz.mendelu.thetrips.utils.DateUtils
import cz.mendelu.thetrips.utils.UIUtils
import cz.mendelu.thetrips.viewModels.MapsViewModel

class MapsFragment: BaseFragment<FragmentMapsBinding, MapsViewModel>(MapsViewModel::class){

    private var centerLat: Double = 0.0
    private var centerLong: Double = 0.0
    private var tripsList: MutableList<Trip> = mutableListOf()

    override fun initViews() {
        val centerTrip = viewModel.getClosest()

        if (centerTrip != null){

            if (centerTrip.latitude != 0.0 || centerTrip.longitude != 0.0 || centerTrip.latitude != null || centerTrip.longitude != null){
                centerLat = centerTrip.latitude!!
                centerLong = centerTrip.longitude!!
            } else {
                centerLat = 49.197369
                centerLong = 16.6066233
            }

        }

        tripsList = viewModel.getAll()
    }

    private val callback = OnMapReadyCallback{ googleMap ->

        val position: LatLng

        if (centerLat != 0.0 || centerLong!= 0.0){
            position = LatLng(centerLat, centerLong)
        } else {
            //center to Brno
            position = LatLng(49.197369, 16.6066233)
        }

        googleMap.moveCamera(CameraUpdateFactory.newLatLngZoom(position,10.0f))

        if (!tripsList.isNullOrEmpty()){
            for (trip in tripsList){
                if (trip.latitude != 0.0 || trip.longitude != 0.0 || trip.latitude != null || trip.longitude != null) {
                    addMarkerToMap(googleMap, trip)
                }
            }
        }
    }

    fun addMarkerToMap(map: GoogleMap, trip: Trip): Marker?{
        val options = MarkerOptions()

        if (trip.longitude != null || trip.latitude != null || trip.destination != "" || trip.longitude != 0.0 || trip.latitude != 0.0 || trip.destination != null){
            options.position(LatLng(trip.latitude!!, trip.longitude!!))
            options.title("${UIUtils.checkStringNotNullOrBlank(trip.destination)}")

            if (trip.startDate!! >= DateUtils.getCurrentDateTime() || trip.endDate!! >= DateUtils.getCurrentDateTime()){
                options.icon(BitmapDescriptorFactory.defaultMarker(BitmapDescriptorFactory.HUE_CYAN))
            }else{
                options.icon(BitmapDescriptorFactory.defaultMarker(BitmapDescriptorFactory.HUE_RED))
            }

            return map.addMarker(options)

        } else {
            return null
        }
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        val mapFragment = childFragmentManager.findFragmentById(R.id.map) as SupportMapFragment?
        mapFragment?.getMapAsync(callback)
    }

    override fun onActivityCreated() {}

    override val bindingInflater: (LayoutInflater) -> FragmentMapsBinding
        get() = FragmentMapsBinding::inflate
}