library(jsonlite)
library(ggpubr)


raw_data = data.frame(fromJSON("api.pushshift.io.json"))

data= data.frame(Date = as.Date(as.POSIXct(raw_data$data.created_utc, 
										 origin = "1970-01-01", 
										 tz = "Europe/Paris"), 
							  tz = "Europe/Paris"),
				 Num_Comments = raw_data$data.num_comments)

data = data[which(data$Num_Comments > 5),]

data$Weekday = factor(weekdays(data$Date), 
					  levels = c("Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"),
					  labels = c("Lundi","Mardi","Mercredi","Jeudi","Vendredi","Samedi"))

ggscatter(data, x = "Date", y = "Num_Comments",
		  color = "Weekday",
		  palette = get_palette("Dark2", 6)) +
	labs(x = "Date", y = "Nombre de Commentaires", color = "Jour") +
	theme_minimal()
