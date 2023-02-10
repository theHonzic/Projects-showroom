package cz.mendelu.thetrips.fragments

import android.view.LayoutInflater
import android.view.View.GONE
import androidx.navigation.fragment.findNavController
import cz.mendelu.thetrips.R
import cz.mendelu.thetrips.architecture.BaseFragment
import cz.mendelu.thetrips.databinding.FragmentHomeBinding
import cz.mendelu.thetrips.model.Trip
import cz.mendelu.thetrips.utils.SPUtils
import cz.mendelu.thetrips.utils.UIUtils
import cz.mendelu.thetrips.viewModels.HomeViewModel


class HomeFragment: BaseFragment<FragmentHomeBinding, HomeViewModel>(HomeViewModel::class){

    override fun initViews() {

        val closestTrip: Trip = viewModel.getLatest()

        if (closestTrip != null){
            binding.latestCardLayout.departure.setText("${UIUtils.checkStringNotNullOrBlank(getString(
                R.string.from
            ))} ${UIUtils.checkStringNotNullOrBlank(closestTrip.departure)}")
            binding.latestCardLayout.destinationText.setText("${UIUtils.checkStringNotNullOrBlank(getString(
                R.string.trip_to
            ))} ${UIUtils.checkStringNotNullOrBlank(closestTrip.destination)}")
            UIUtils.getImageToVehicle(UIUtils.checkStringNotNullOrBlank(closestTrip.vehicle), binding.latestCardLayout.image)
            binding.latestCardLayout.noTripsMessage.visibility = GONE
            UIUtils.displayDateOnCard(binding.latestCardLayout.date,
                binding.latestCardLayout.calendarIcon,
                UIUtils.getLong(closestTrip.startDate),
                UIUtils.getLong(closestTrip.endDate),
                getString(
                R.string.to_lower_case
            ),
                getString(R.string.unknown))

            binding.latestCardLayout.root.setOnClickListener{
                val action = HomeFragmentDirections.actionHomeFragmentToTripDetailFragment(closestTrip.id!!)
                findNavController().navigate(action)
            }

        } else if (viewModel.getTripsCount().equals(0)){

            hideCardContetnSetMessage("${getText(R.string.no_trips)}")
            binding.fab.visibility = GONE

            binding.latestCardLayout.root.setOnClickListener{
                findNavController().navigate(R.id.action_homeFragment_to_addNewTripFragment2)
            }

        } else if (!viewModel.getTripsCount().equals(0) && closestTrip == null){
            hideCardContetnSetMessage("${getText(R.string.no_upcoming)}")
        }

        if (SPUtils.readString(requireContext(), "name") != ""){
            binding.infoMessage.visibility = GONE

            binding.upcomingTrips.text = "${getText(R.string.show)} ${SPUtils.readString(requireContext(), "name")}'s ${getText(
                R.string.home_fragment_upcoming_button
            )}"
            binding.pastTrips.text = "${getText(R.string.show)} ${SPUtils.readString(requireContext(), "name")}'s ${getText(
                R.string.home_fragment_past_button
            )}"
            binding.mapFragment.text = "${getText(R.string.show)} ${SPUtils.readString(requireContext(), "name")}'s ${getText(
                R.string.home_fragment_map_button
            )}"
        } else {
            binding.infoMessage.message = getString(R.string.name_note)
        }

        binding.mapFragment.setOnClickListener{
            findNavController().navigate(R.id.action_homeFragment_to_mapFragment)
        }

        binding.fab.setOnClickListener{
            findNavController().navigate(R.id.action_homeFragment_to_addNewTripFragment2)
        }

        binding.pastTrips.setOnClickListener{
            findNavController().navigate(R.id.action_homeFragment_to_pastTripsFragment)
        }

        binding.upcomingTrips.setOnClickListener{
            findNavController().navigate(R.id.action_homeFragment_to_upcomingTripsFragment)
        }

        binding.fabInfo.setOnClickListener {
            findNavController().navigate(R.id.action_homeFragment_to_appInfoFragment)
        }
    }

    private fun hideCardContetnSetMessage(message: String){
        binding.latestCardLayout.image.visibility = GONE
        binding.latestCardLayout.destinationText.visibility = GONE
        binding.latestCardLayout.date.visibility = GONE
        binding.latestCardLayout.departure.visibility = GONE
        binding.latestCardLayout.calendarIcon.visibility = GONE

        binding.latestCardLayout.noTripsMessage.message = message
    }

    override fun onActivityCreated(){
    }

    override val bindingInflater: (LayoutInflater) -> FragmentHomeBinding
        get() = FragmentHomeBinding::inflate
}