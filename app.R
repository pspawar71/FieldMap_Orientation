library(shiny)
library(leaflet)
library(sf)

# Define UI
ui <- fluidPage(
  titlePanel("SOYGEN Field Trial Coordinates"),
  sidebarLayout(
    sidebarPanel(
      h3("Please Enter the Coordinates (The provided coordinates are for the Purdue ACRE field trial)"),
      tabsetPanel(
        tabPanel("First Row, First Range",
                 numericInput("lat1", "Latitude", value = 40.481212, min = -90, max = 90),
                 numericInput("lng1", "Longitude", value = -86.999901, min = -180, max = 180)
        ),
        tabPanel("First Row, Last Range",
                 numericInput("lat2", "Latitude", value = 40.481991, min = -90, max = 90),
                 numericInput("lng2", "Longitude", value = -86.999902, min = -180, max = 180)
        ),
        tabPanel("Last Row, Last Range",
                 numericInput("lat3", "Latitude", value = 40.481995, min = -90, max = 90),
                 numericInput("lng3", "Longitude", value = -86.999397, min = -180, max = 180)
        ),
        tabPanel("Last Row, First Range",
                 numericInput("lat4", "Latitude", value = 40.481211, min = -90, max = 90),
                 numericInput("lng4", "Longitude", value = -86.999396, min = -180, max = 180)
        )
      )
    ),
    mainPanel(
      leafletOutput("map")
    )
  )
)

# Define server logic
server <- function(input, output) {
  output$map <- renderLeaflet({
    # Define the coordinates and labels
    coords <- data.frame(
      lat = c(input$lat1, input$lat2, input$lat3, input$lat4),
      lng = c(input$lng1, input$lng2, input$lng3, input$lng4),
      label = c("First Row, First Range", "First Row, Last Range", "Last Row, Last Range", "Last Row, First Range"),
      color = c("red", "blue", "white", "orange")
    )
    
    # Create a leaflet map
    leaflet() %>%
      addProviderTiles(providers$Esri.WorldImagery) %>%  # Google Satellite Map
      addCircleMarkers(
        data = coords,
        ~lng, ~lat,
        color = ~color,
        radius = 8,
        label = ~label,
        fillOpacity = 0.8,
        stroke = FALSE
      ) %>%
      addPolygons(
        lng = c(input$lng1, input$lng2, input$lng3, input$lng4, input$lng1),
        lat = c(input$lat1, input$lat2, input$lat3, input$lat4, input$lat1),
        color = "blue",
        weight = 4,
        fillOpacity = 0.1
      ) %>%
      addLegend(
        position = "bottomright",
        colors = c("red", "blue", "white", "orange"),
        labels = c("First Row, First Range", "First Row, Last Range", "Last Row, Last Range", "Last Row, First Range"),
        title = "Marker Colors"
      )
  })
}

# Run the application 
shinyApp(ui = ui, server = server)
