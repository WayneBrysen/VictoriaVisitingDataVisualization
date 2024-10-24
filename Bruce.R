library(shiny)
library(shinyjs)
source('tableau-in-shiny-v1.2.R')

data <- read.csv("dataSet/Path.csv", stringsAsFactors = FALSE)

set.seed(123) 
selected_data <- data[sample(1:nrow(data), 10), ]

ui <- navbarPage(
  title = "Discover Melbourne",
  header = setUpTableauInShiny(),
  
  tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.8.1/slick.min.css"),
    tags$link(rel = "stylesheet", type = "text/css", href = "https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.8.1/slick-theme.min.css"),
    tags$script(src = "https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js"),
    tags$script(src = "https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.8.1/slick.min.js"),
    tags$style(HTML("
      .carousel-item {
        padding: 1px;
        text-align: center;
      }
      .slick-slide {
        margin: 0 5px;
      }
      .slick-slide img {
        margin: auto;
        width: 100%;
        max-width: 150px;
        height: 100px;
        object-fit: cover;
        display: block;
      }
      
      .carousel-caption {
        padding: 0px;
        color: black;
        font-size: 10px;
        margin-top: 0px;
        position: relative;
        bottom: 0;
        width: 50%;
      }
      
      h2 {
        text-align: left;
        margin-top: 20px;
        font-weight: bold;
      }
      
      .carousel-item:hover img {
        box-shadow: none;
      }
    ")),
    
    tags$script(HTML("
      $(document).ready(function(){
        $('.carousel').slick({
          infinite: false,
          slidesToShow: 5,
          slidesToScroll: 2,
          dots: true,
          arrows: true,
          draggable: true
        });
      });
    "))
  ),
  
  tabPanel(
    "Find Tram to Take",
    fluidPage(
      fluidRow(
        tags$div(
          style = "position: relative; width: 100%; height: 600px; overflow: hidden;",
          tags$img(
            src = "tram.jpg",
            style = "width: 100%; height: 100%; object-fit: cover; position: absolute; top: 0; left: 0; z-index: -1;"
          ),
          tags$h1(
            "Victoria. Every Bit Different", 
            style = "position: absolute; bottom: 10%; left: 2%; transform: translate(0, 0);
                     color: white; font-size: 40px; font-weight: bold; padding: 10px; margin: 0;
                     text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.7);"
          ),
          tags$p(
            "Explore Melbourne the Easy Way – Hop on a Tram, Discover the City!",
            style = "position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%);
                     color: white; font-size: 30px; font-weight: bold; padding: 10px; margin: 0; width: 80%; text-align: center;
                     text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.7);"
          )
        )
      ),
      
      # Carouse
      fluidRow(
        h2('Trams'),
        div(class = "carousel",
            lapply(1:nrow(selected_data), function(i) {
              div(
                class = "carousel-item",
                tags$img(src = selected_data$IMAGEURL[i], alt = selected_data$Feature.Name[i]),
                div(
                  class = "carousel-caption",
                  p(selected_data$Feature.Name[i], style = "margin: 0;")
                )
              )
            })
        )
      ),
      
      # Tableau
      fluidRow(
        h2('Find Tram to Take in Melbourne'),
        tableauPublicViz(
          id = 'tableauViz1',       
          url = 'https://public.tableau.com/views/MelbournePTVTramMap/1_1?:language=zh-CN&publish=yes&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link',
          height = "1080px"
        )
      )
    )
  ),
  
  tabPanel("Placeholder 1"),
  tabPanel("Placeholder 2"),
  tabPanel("Placeholder 3")
)

server <- function(input, output, session) {
  
}

shinyApp(ui = ui, server = server, options = list(launch.browser = TRUE))
