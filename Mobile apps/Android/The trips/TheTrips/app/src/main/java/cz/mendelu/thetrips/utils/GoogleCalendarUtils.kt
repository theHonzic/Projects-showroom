package cz.mendelu.thetrips.utils

import android.net.Uri

class GoogleCalendarUtils {
    companion object{
        fun generateLink(titleStart: String, titleEnd: String, details: String, location: String, startDate: Long, endDate:Long): String{
            val uriBuilder: Uri.Builder = Uri.Builder()
            var uri = uriBuilder.scheme("https")
                .authority("www.google.com")
                .appendPath("calendar")
                .appendPath("render")
                .appendQueryParameter("action", "TEMPLATE")
                .appendQueryParameter("details", details)
                .appendQueryParameter("location", location)
            if (UIUtils.getLong(startDate) != 0L && UIUtils.getLong(endDate) != 0L){
                uri.appendQueryParameter("text", titleStart)
                uri.appendQueryParameter("dates", "${DateUtils.getGoogleDateFormat(startDate)}/${DateUtils.getGoogleDateFormat(UIUtils.getLong(endDate)+86400000L)}")
            } else if (UIUtils.getLong(startDate) == 0L && UIUtils.getLong(endDate) != 0L){
                uri.appendQueryParameter("dates", "${DateUtils.getGoogleDateFormat(endDate)}/${DateUtils.getGoogleDateFormat(UIUtils.getLong(endDate)+86400000L)}")
                uri.appendQueryParameter("text", titleEnd)
            } else if (UIUtils.getLong(startDate) != 0L && UIUtils.getLong(endDate) == 0L){
                uri.appendQueryParameter("text", titleStart)
                uri.appendQueryParameter("dates", "${DateUtils.getGoogleDateFormat(UIUtils.getLong(startDate))}/${DateUtils.getGoogleDateFormat(UIUtils.getLong(startDate)+86400000L)}")
            } else if (UIUtils.getLong(startDate) ==0L || UIUtils.getLong(endDate) ==0L){
                uri.appendQueryParameter("text", titleStart)
            }

            return uri.build().toString()
        }
    }
}