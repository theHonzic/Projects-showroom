package cz.mendelu.thetrips.utils


import android.view.View
import android.widget.ImageView
import android.widget.TextView
import cz.mendelu.thetrips.R
import de.hdodenhof.circleimageview.CircleImageView

class UIUtils {

    companion object{
        fun getImageToVehicle(vehicle: String, image: CircleImageView) {
            if (vehicle == "Ship" || vehicle == "Loď") image.setImageResource(R.drawable.ic_ship)
            if (vehicle == "Plane" || vehicle == "Letadlo") image.setImageResource(R.drawable.ic_plane)
            if (vehicle == "Car" || vehicle == "Auto") image.setImageResource(R.drawable.ic_car)
            if (vehicle == "Train" || vehicle == "Vlak") image.setImageResource(R.drawable.ic_train)
            if (vehicle == "Bus" || vehicle == "Autobus") image.setImageResource(R.drawable.ic_bus)
        }

        fun checkStringNotNullOrBlank(string: String?): String{
            if (string.isNullOrBlank()){
                return ""
            }else{
                return string
            }
        }

        fun displayDateOnCard(textView: TextView, imageView: ImageView, start: Long?, end: Long?, to: String, unknown: String){
            if (start != 0L && end != 0L){
                textView.setText("${UIUtils.checkStringNotNullOrBlank(DateUtils.getDateString(start!!))} ${to} ${UIUtils.checkStringNotNullOrBlank(DateUtils.getDateString(end!!))}")
            } else {
                if (start == 0L && end == 0L){
                    imageView.visibility = View.GONE
                    textView.visibility = View.GONE
                } else if (end == 0L){
                    textView.setText("${UIUtils.checkStringNotNullOrBlank(DateUtils.getDateString(start!!))} ${to} ${unknown}")
                } else if (start == 0L){
                    textView.setText("${unknown} ${to} ${UIUtils.checkStringNotNullOrBlank(DateUtils.getDateString(end!!))}")

                }
            }
        }

        fun getLong(long: Long?): Long{
            if (long == null ||  long == 0L){
                return 0L
            } else {
                return long
            }
        }
    }
}