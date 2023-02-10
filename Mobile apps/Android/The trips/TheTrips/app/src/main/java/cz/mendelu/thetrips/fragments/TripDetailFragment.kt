package cz.mendelu.thetrips.fragments

import android.content.Intent
import android.graphics.Color
import android.net.Uri
import android.view.LayoutInflater
import androidx.appcompat.app.AlertDialog
import androidx.lifecycle.lifecycleScope
import androidx.navigation.fragment.findNavController
import androidx.navigation.fragment.navArgs
import cz.mendelu.thetrips.R
import cz.mendelu.thetrips.architecture.BaseFragment
import cz.mendelu.thetrips.databinding.FragmentTripDetailBinding
import cz.mendelu.thetrips.utils.DateUtils
import cz.mendelu.thetrips.utils.GoogleCalendarUtils
import cz.mendelu.thetrips.utils.UIUtils
import cz.mendelu.thetrips.viewModels.TripDetailViewModel
import kotlinx.coroutines.launch


class TripDetailFragment: BaseFragment<FragmentTripDetailBinding, TripDetailViewModel>(TripDetailViewModel::class){

    private val arguments: TripDetailFragmentArgs by navArgs()

    override fun initViews() {
        viewModel.id = if (arguments.id != -1L) arguments.id else null
        val trip = viewModel.findTripById()

        viewModel.trip = trip

        if (trip != null){
            binding.descriptionText.setText("${UIUtils.checkStringNotNullOrBlank(trip.description)}")
            binding.departureText.setText(UIUtils.checkStringNotNullOrBlank(trip.departure!!))
            binding.destinationText.setText("${getString(R.string.trip_to)} ${UIUtils.checkStringNotNullOrBlank(trip.destination!!)}")
            UIUtils.getImageToVehicle(UIUtils.checkStringNotNullOrBlank(trip.vehicle!!), binding.imageView)

            if (UIUtils.getLong(trip.endDate) != 0L){
                binding.endDateText.setText(DateUtils.getDateString(trip.endDate!!))
            } else {
                binding.endDateText.setText(getString(R.string.unknown))
            }

            if (UIUtils.getLong(trip.startDate) != 0L){
                binding.startDateText.setText(DateUtils.getDateString(trip.startDate!!))
            } else {
                binding.startDateText.setText(getString(R.string.unknown))
            }
        }

        binding.updateButton.setOnClickListener{
            val action = TripDetailFragmentDirections.actionTripDetailFragmentToUpdateTripFragment(viewModel.id!!)
            findNavController().navigate(action)
        }

        binding.deleteButton.setOnClickListener{
            showDeleteDialog()
        }

        binding.mapButton.setOnClickListener{
            val action = TripDetailFragmentDirections.actionTripDetailFragmentToTripDetailMap(viewModel.id!!)
            findNavController().navigate(action)
        }

        binding.addToCalendar.setOnClickListener{

            val openURL = Intent(android.content.Intent.ACTION_VIEW)
            openURL.data = Uri.parse(
                GoogleCalendarUtils.generateLink("${getString(R.string.trip_to)} ${UIUtils.checkStringNotNullOrBlank(trip.destination)}",
                "${getString(R.string.end_of_the_trip_in)} ${UIUtils.checkStringNotNullOrBlank(trip.destination)}",
                UIUtils.checkStringNotNullOrBlank(trip.description),
                UIUtils.checkStringNotNullOrBlank(trip.destination),
                UIUtils.getLong(trip.startDate),
                UIUtils.getLong(trip.endDate))
            )

            startActivity(openURL)

        }

        binding.share.setOnClickListener{
            val action = TripDetailFragmentDirections.actionTripDetailFragmentToShareFragment(viewModel.id!!)
            findNavController().navigate(action)
        }
    }

    private fun showDeleteDialog(){
        AlertDialog.Builder(requireContext(), R.style.alert_dialog)
            .setMessage("${getString(R.string.delete_dialog_q)} ${UIUtils.checkStringNotNullOrBlank(viewModel.trip!!.destination)}?")
            .setTitle(getString(R.string.delete_dialog_title))
            .setPositiveButton(getString(R.string.yes)) { _, _ ->
                lifecycleScope.launch {
                    viewModel.deleteTrip()
                }.invokeOnCompletion {
                    finishCurrentFragment()
                }
            }
            .setNegativeButton(getString(R.string.no), null)
            .setIcon(R.drawable.ic_warning)
            .show()
            .getButton(AlertDialog.BUTTON_POSITIVE).setTextColor(Color.BLACK)
    }

    override fun onActivityCreated(){}

    override val bindingInflater: (LayoutInflater) -> FragmentTripDetailBinding
        get() = FragmentTripDetailBinding::inflate
}