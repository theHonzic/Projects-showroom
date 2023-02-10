package cz.mendelu.thetrips.utils

import java.text.SimpleDateFormat
import java.util.*

class DateUtils {
    companion object {
        private val DATE_FORMAT_CS = "dd. MM. yyyy"
        private val DATE_FORMAT_EN = "yyyy/MM/dd"
        private val DATE_FORMAT_GOOGLE_URL = "yyyyMMdd"

        fun getDateString(unixTime: Long): String{
            val calendar = Calendar.getInstance()
            calendar.timeInMillis = unixTime
            val format: SimpleDateFormat;

            if (LanguageUtils.isLanguageCzech()){
                format = SimpleDateFormat(DATE_FORMAT_CS, Locale.GERMAN)
            } else {
                format = SimpleDateFormat(DATE_FORMAT_EN, Locale.ENGLISH)
            }

            return format.format(calendar.getTime())
        }

        fun getGoogleDateFormat(unixTime: Long): String{
            val calendar = Calendar.getInstance()
            calendar.timeInMillis = unixTime
            val format: SimpleDateFormat

            if (LanguageUtils.isLanguageCzech()){
                format = SimpleDateFormat(DATE_FORMAT_GOOGLE_URL, Locale.GERMAN)
            } else {
                format = SimpleDateFormat(DATE_FORMAT_GOOGLE_URL, Locale.ENGLISH)
            }

            return format.format(calendar.getTime())
        }

        fun getUnixTime(year: Int, month: Int, day: Int): Long{
            val calendar = Calendar.getInstance()
            calendar.set(year, month, day)

            return calendar.timeInMillis
        }

        fun getCurrentDateTime(): Long{

            return Calendar.getInstance().timeInMillis
        }
    }
}