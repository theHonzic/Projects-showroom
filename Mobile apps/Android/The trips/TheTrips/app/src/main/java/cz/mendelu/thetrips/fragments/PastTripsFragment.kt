package cz.mendelu.thetrips.fragments

import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.lifecycle.Observer
import androidx.navigation.fragment.findNavController
import androidx.recyclerview.widget.DiffUtil
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import cz.mendelu.thetrips.R
import cz.mendelu.thetrips.architecture.BaseFragment
import cz.mendelu.thetrips.databinding.FragmentPastTripsBinding
import cz.mendelu.thetrips.databinding.RowTripListBinding
import cz.mendelu.thetrips.model.Trip
import cz.mendelu.thetrips.utils.UIUtils
import cz.mendelu.thetrips.viewModels.PastTripsViewModel


class PastTripsFragment: BaseFragment<FragmentPastTripsBinding, PastTripsViewModel>(PastTripsViewModel::class){

    private val tripsList: MutableList<Trip> = mutableListOf()
    private lateinit var adapter: TripAdapter
    private lateinit var layoutManager: LinearLayoutManager

    override fun initViews() {

        layoutManager = LinearLayoutManager(requireContext())
        adapter = TripAdapter()
        binding.tripsList.layoutManager = layoutManager
        binding.tripsList.adapter = adapter

        binding.fab.setOnClickListener{
            findNavController().navigate(R.id.action_pastTripsFragment_to_addNewTripFragment2)
        }

        viewModel
            .getPast()
            .observe(viewLifecycleOwner, object : Observer<MutableList<Trip>>{
                override fun onChanged(t: MutableList<Trip>?) {
                    val diffCallback = TripDiffUtils(tripsList, t!!)
                    val diffResult = DiffUtil.calculateDiff(diffCallback)
                    diffResult.dispatchUpdatesTo(adapter)
                    tripsList.clear()
                    tripsList.addAll(t!!)
                }
            }
            )
    }

    inner class TripDiffUtils(private val oldList: MutableList<Trip>, private val newList: MutableList<Trip>): DiffUtil.Callback(){

        override fun getOldListSize(): Int = oldList.size

        override fun getNewListSize(): Int = newList.size

        override fun areItemsTheSame(oldItemPosition: Int, newItemPosition: Int): Boolean {
            return oldList[oldItemPosition].id == newList[newItemPosition].id
        }

        override fun areContentsTheSame(oldItemPosition: Int, newItemPosition: Int): Boolean {
            return oldList[oldItemPosition].departure == newList[newItemPosition].departure &&
                    oldList[oldItemPosition].destination == newList[newItemPosition].destination &&
                    oldList[oldItemPosition].description == newList[newItemPosition].description &&
                    oldList[oldItemPosition].vehicle == newList[newItemPosition].vehicle &&
                    oldList[oldItemPosition].longitude == newList[newItemPosition].longitude &&
                    oldList[oldItemPosition].latitude == newList[newItemPosition].latitude &&
                    oldList[oldItemPosition].startDate == newList[newItemPosition].startDate &&
                    oldList[oldItemPosition].endDate == newList[newItemPosition].endDate
        }
    }

    inner class TripAdapter: RecyclerView.Adapter<TripAdapter.TripViewHolder>(){

        inner class TripViewHolder(val binding: RowTripListBinding): RecyclerView.ViewHolder(binding.root){}

        override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): TripViewHolder{
            return TripViewHolder(RowTripListBinding.inflate(LayoutInflater.from(parent.context), parent, false))
        }

        override fun onBindViewHolder(holder: TripViewHolder, position: Int){
            val trip = tripsList.get(position)

            holder.binding.contentLayout.destinationText.setText("${getString(R.string.trip_to)} ${UIUtils.checkStringNotNullOrBlank(trip.destination!!)}")
            holder.binding.contentLayout.departure.setText("${getString(R.string.from)} ${UIUtils.checkStringNotNullOrBlank(trip.departure!!)}")

            UIUtils.displayDateOnCard(holder.binding.contentLayout.date,
                holder.binding.contentLayout.calendarIcon,
                UIUtils.getLong(trip.startDate),UIUtils.getLong(trip.endDate),
                getString(R.string.to_lower_case),
                getString(R.string.unknown)
            )

            UIUtils.getImageToVehicle(UIUtils.checkStringNotNullOrBlank(trip.vehicle!!), holder.binding.contentLayout.image)

            holder.binding.card.setOnClickListener {
                val action = PastTripsFragmentDirections.actionPastTripsFragmentToTripDetailFragment(tripsList.get(holder.adapterPosition).id!!)
                findNavController().navigate(action)
            }
        }

        override fun getItemCount(): Int = tripsList.size

    }

    override fun onActivityCreated(){}

    override val bindingInflater: (LayoutInflater) -> FragmentPastTripsBinding
        get() = FragmentPastTripsBinding::inflate
}