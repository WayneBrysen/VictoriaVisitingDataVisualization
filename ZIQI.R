library(shiny)
library(shinyjs)

source('tableau-in-shiny-v1.2.R')

data <- read.csv("dataSet/landmarks-and-places-of-interest-including-schools-theatres-health-services-spor.csv", stringsAsFactors = FALSE)

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

      .custom-header {
        background-image: url('melbourneCity.webp');
        background-size: cover;
        color: white;
        text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.7);
        padding: 50px;
        text-align: center;
      }

      .custom-header h1 {
        font-size: 50px;
        margin: 0;
        padding-bottom: 10px;
      }

      .custom-header p {
        font-size: 24px;
      }

      .info-section {
        margin-top: 40px;
        font-size: 18px;
        line-height: 1.6;
      }

      .image-container {
        text-align: center;
        margin-top: 20px;
      }

      .image-container img {
        margin: 10px;
        max-width: 45%;
        height: auto;
      }

      .section-title {
        font-size: 32px;
        font-weight: bold;
        margin-bottom: 20px;
      }

      .section-description {
        font-size: 18px;
        margin-bottom: 20px;
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
    "Good Place to Go",
    fluidPage(
      fluidRow(
        tags$div(
          class = "custom-header",
          tags$h1("Victoria. Every Bit Different"),
          tags$p("Discover the vibrant city of Melbourne, where art meets coffee culture, and historic landmarks blend with modern skyscrapers.")
        )
      ),
      
      # Carousel Section
      fluidRow(
        h2('Discover'),
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
      
      # Tableau Visualization for "Good Place to Go"
      fluidRow(
        h2('Find a Good Place to Go in Melbourne'),
        tableauPublicViz(
          id = 'tableauViz',       
          url = 'https://public.tableau.com/views/A3Table/InterestPointOnMelbourneCity?:language=en-US&publish=yes&:sid=&:display_count=n&:origin=viz_share_link',
          height = "600px"
        )
      )
    )
  ),
  

  tabPanel(
    "Traffic Congestion",
    fluidPage(
          fluidRow(
            tags$div(
              class = "custom-header",
              tags$h1("Plan Your Trip with Melbourne Public Transport Insights"),
              tags$p("Navigate Melbourne's busiest and quietest train stations with real-time data.")
            )
        ),
      
      
    fluidRow(
        h2('Discover the Traffic in Melbourne'),
        div(
          class = "image-container",
          tags$div(
            style = "position: relative; display: inline-block; margin-right: 10px;",
            tags$img(src = "trans.jpg", style = "width: 300px; max-width: 500px; height: 200px;"),
            tags$div(
              style = "position: absolute; top: 20px; left: 20px; color: white; font-size: 24px; 
                       font-weight: bold; text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.7);",
              "Busiest Train Routes"
            )
          ),
          tags$div(
            style = "position: relative; display: inline-block;",
            tags$img(src = "tram.jpg", style = "width: 300px; max-width: 500px; height: 200px;"),
            tags$div(
              style = "position: absolute; top: 20px; left: 20px; color: white; font-size: 24px; 
                       font-weight: bold; text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.7);",
              "Less Crowded Stations"
            )
          ),
          tags$div(
            style = "position: relative; display: inline-block;",
            tags$img(src = "bg.jpg", style = "width: 300px; max-width: 500px; height: 200px;"),
            tags$div(
              style = "position: absolute; top: 20px; left: 20px; color: white; font-size: 24px; 
                       font-weight: bold; text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.7);",
              "Better experience"
            )
          )
        ),
        

        p(class = "section-description", "The interactive map below highlights passenger traffic at Melbourne's major train stations. Larger bubbles indicate higher traffic, so you can avoid the rush and plan your trip with ease. Perfect for travelers who want to explore popular tourist destinations or find quieter spots to enjoy their visit."),
        

        div(
          h2(class = "section-title", 'Explore Melbourne’s Train Station Traffic'),
        ),
        
        div(style = "display: flex; justify-content: center; align-items: center;",
            div(style = "flex: 1; margin-right: 20px;",  # left sheet
                tableauPublicViz(
                  id = 'tableauVizTrafficLeft',       
                  url = 'https://public.tableau.com/views/BookA3_17289846245930/Sheet1?:language=zh-CN&publish=yes&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link',
                  height = "600px",
                  width = "80%"  
                )
            ),
            div(style = "flex: 1;", # right sheet
                tableauPublicViz(
                  id = 'tableauVizTrafficRight',       
                  url = 'https://public.tableau.com/views/BookA3_17289846245930/Sheet2?:language=zh-CN&publish=yes&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link',
                  height = "600px",
                  width = "80%"  
                )
            )
        ),
      

        p(class = "section-description", "Did you know? Flinders Street Station, located in the heart of the city, is one of the busiest stations, especially during peak hours. If you’re visiting iconic landmarks nearby, try traveling outside peak times to make your journey more comfortable."),
        
        p(class = "section-description", "Looking for a quieter station? Consider exploring areas like Brighton or Sandringham, which offer beautiful coastal views and fewer crowds, making for a more relaxing journey.")
    )
  ))
  ,
  
  tabPanel("Placeholder 2"),
  tabPanel("Placeholder 3")
)

server <- function(input, output, session) {}

shinyApp(ui = ui, server = server, options = list(launch.browser = TRUE))
