package cz.mendelu.thetrips.fragments

import android.graphics.Bitmap
import android.graphics.Color
import android.view.LayoutInflater
import androidx.navigation.fragment.navArgs
import com.google.zxing.BarcodeFormat
import com.google.zxing.WriterException
import com.google.zxing.common.BitMatrix
import com.google.zxing.qrcode.QRCodeWriter
import cz.mendelu.thetrips.R
import cz.mendelu.thetrips.architecture.BaseFragment
import cz.mendelu.thetrips.databinding.FragmentShareBinding
import cz.mendelu.thetrips.utils.GoogleCalendarUtils
import cz.mendelu.thetrips.utils.UIUtils
import cz.mendelu.thetrips.viewModels.ShareFragmentViewModel


class ShareFragment: BaseFragment<FragmentShareBinding, ShareFragmentViewModel>(ShareFragmentViewModel::class){

    override val bindingInflater: (LayoutInflater) -> FragmentShareBinding
        get() = FragmentShareBinding::inflate

    private val arguments: ShareFragmentArgs by navArgs()

    override fun initViews() {
        viewModel.id = if (arguments.id != -1L) arguments.id else null

        val trip = viewModel.findTripById()

        val writer = QRCodeWriter()

        try {
            val bitMatrix: BitMatrix = writer.encode(
                GoogleCalendarUtils.generateLink(
                    "${getString(R.string.trip_to)} ${UIUtils.checkStringNotNullOrBlank(trip.destination)} ${getString(
                        R.string.from
                    )} ${UIUtils.checkStringNotNullOrBlank(trip.departure)}",
                    "${getString(R.string.end_of_the_trip_in)} ${UIUtils.checkStringNotNullOrBlank(trip.destination)}",
                    UIUtils.checkStringNotNullOrBlank(trip.description),
                    UIUtils.checkStringNotNullOrBlank(trip.destination),
                    UIUtils.getLong(trip.startDate), UIUtils.getLong(trip.endDate)),
                BarcodeFormat.QR_CODE, 512, 512
            )

            val width: Int = bitMatrix.width
            val height: Int = bitMatrix.height
            val bmp = Bitmap.createBitmap(width, height, Bitmap.Config.RGB_565)

            for (x in 0 until width){
                for (y in 0 until height){
                    bmp.setPixel(x, y, if (bitMatrix.get(x, y)) Color.BLACK else Color.WHITE)
                }
            }

            binding.qrCode.setImageBitmap(bmp)
        } catch (e: WriterException){
            e.printStackTrace()
        }

    }

    override fun onActivityCreated() {}

}