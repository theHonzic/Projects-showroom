package cz.mendelu.thetrips.fragments

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import androidx.navigation.fragment.navArgs
import com.google.android.gms.maps.CameraUpdateFactory
import com.google.android.gms.maps.OnMapReadyCallback
import com.google.android.gms.maps.SupportMapFragment
import com.google.android.gms.maps.model.LatLng
import com.google.android.gms.maps.model.MarkerOptions
import cz.mendelu.thetrips.R
import cz.mendelu.thetrips.architecture.BaseFragment
import cz.mendelu.thetrips.databinding.FragmentTripDetailMapBinding
import cz.mendelu.thetrips.model.Trip
import cz.mendelu.thetrips.utils.DateUtils
import cz.mendelu.thetrips.utils.UIUtils
import cz.mendelu.thetrips.viewModels.TripDetailMapViewModel

class TripDetailMapFragment: BaseFragment<FragmentTripDetailMapBinding, TripDetailMapViewModel>(TripDetailMapViewModel::class){

    private val arguments: TripDetailFragmentArgs by navArgs()

    private lateinit var trip: Trip
    private var centerLat: Double = 0.0
    private var centerLong: Double = 0.0

    override fun initViews() {
        viewModel.id = if (arguments.id != -1L) arguments.id else null
        trip = viewModel.findTripById()
        if (trip != null){

            if (trip.latitude != 0.0 || trip.longitude != 0.0 || trip.latitude != null || trip.longitude != null){
                centerLat = trip.latitude!!
                centerLong = trip.longitude!!
            }

        }
    }

    private val callback = OnMapReadyCallback{googleMap ->
        val position: LatLng

        if (centerLat != 0.0 || centerLong!= 0.0){
            position = LatLng(centerLat, centerLong)
        } else {
            //center to Brno
            position = LatLng(49.197369, 16.6066233)
        }

        googleMap.moveCamera(CameraUpdateFactory.newLatLngZoom(position,13.0f))

        if (UIUtils.getLong(trip.startDate) != 0L && UIUtils.getLong(trip.endDate) != 0L){
            googleMap.addMarker(MarkerOptions()
                .position(LatLng(trip.latitude!!, trip.longitude!!))
                .title("${DateUtils.getDateString(trip.startDate!!)} ${getString(R.string.to_lower_case)} ${DateUtils.getDateString(trip.endDate!!)}"))
        } else {

            if (UIUtils.getLong(trip.startDate) == 0L && UIUtils.getLong(trip.endDate) != 0L){
                googleMap.addMarker(MarkerOptions()
                    .position(LatLng(trip.latitude!!, trip.longitude!!))
                    .title("${getString(R.string.unknown)} ${getString(R.string.to_lower_case)} ${DateUtils.getDateString(trip.endDate!!)}"))
            } else if (UIUtils.getLong(trip.endDate) == 0L && UIUtils.getLong(trip.startDate) != 0L){
                googleMap.addMarker(MarkerOptions()
                    .position(LatLng(trip.latitude!!, trip.longitude!!))
                    .title("${DateUtils.getDateString(trip.startDate!!)} ${getString(R.string.to_lower_case)} ${getString(
                        R.string.unknown
                    )}"))
            } else if (UIUtils.getLong(trip.startDate) == 0L && UIUtils.getLong(trip.endDate) == 0L){
                googleMap.addMarker(MarkerOptions()
                    .position(LatLng(trip.latitude!!, trip.longitude!!))
                    .title("${getString(R.string.unknown)} ${getString(R.string.to_lower_case)} ${getString(
                        R.string.unknown
                    )}"))
            }
        }
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        val mapFragment = childFragmentManager.findFragmentById(R.id.map) as SupportMapFragment?
        mapFragment?.getMapAsync(callback)
    }

    override fun onActivityCreated(){}

    override val bindingInflater: (LayoutInflater) -> FragmentTripDetailMapBinding
        get() = FragmentTripDetailMapBinding::inflate
}