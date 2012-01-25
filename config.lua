-- Generic config.lua

application = {

   content = { fps = 60, width = 640, height = 960, 
	       scale = "letterBox", xAlign = "center", yAlign = "center", },

   orientation = { default = "portrait", supported = "portrait", },

   androidPermissions = { "android.permission.INTERNET",
			  "android.permission.ACCESS_NETWORK_STATE", },
}