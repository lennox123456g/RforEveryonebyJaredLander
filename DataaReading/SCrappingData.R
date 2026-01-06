#DATASCRAPPING FORM WEBSITES 
#USING HADLEY WICKAM rvest PACKAGE to
#to extract data into a usable format 
#we put the menu and restaurant details for Ribalta, a beloved New York
#pizzeria, into an HTML file
#The file can be read directly from the URL, or from disc, using read_html. This
#creates an xml_document object that holds all of the HTML
#The address and phone number are stored in an ordered
#list, section identifiers are in spans and the items and prices are in tables
library(rvest)
ribalta <- read_html('http://www.jaredlander.com/data/ribalta.html')
class(ribalta)
ribalta

#By exploring the HTML we see that the address is stored in a span, which is an
#element of an ordered list. First we use html_nodes to select all span elements
#within ul elements.
ribalta %>% html_nodes('ul') %>% html_nodes('span')


ribalta %>% html_nodes('.street')

ribalta %>% html_nodes('.street') %>% html_text()


ribalta %>%
   html_nodes('table.food-items') %>%
   magrittr::extract2(5) %>%
   html_table()
