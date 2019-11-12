library(shiny)
library(ggplot2)
library(adegenet) ## deal with genind objects
library(ade4)
library(reshape2)
library(plyr)

###########################################################################################
load(
  "/Users/hoffman ava/bogr_side/blue-grama-diversity/src/genomics_prep/genind_all.R"
)

## color palette (standard)
col.pal <-
  read.csv("/Users/hoffman ava/bogr_side/blue-grama-diversity/utils/color_key.csv",
           header = T)
col.pal.v <-
  as.vector(col.pal[, 3])
names(col.pal.v) <- col.pal[, 2]
col.pal.names <-
  as.vector(col.pal[, 2])
names(col.pal.names) <- col.pal[, 6]
col.pal.colors <-
  as.vector(col.pal[, 3])
names(col.pal.colors) <- col.pal[, 6]

## color palette (for groupings)
col.pal.alt <-
  read.csv(
    "/Users/hoffman ava/bogr_side/blue-grama-diversity/utils/color_key_alt.csv",
    header = T
  )
col.pal.alt.v <-
  as.vector(col.pal.alt[, 3])
names(col.pal.alt.v) <- col.pal.alt[, 2]
col.pal.alt.names <-
  as.vector(col.pal.alt[, 2])
names(col.pal.alt.names) <- col.pal.alt[, 6]
col.pal.alt.colors <-
  as.vector(col.pal.alt[, 3])
names(col.pal.alt.colors) <- col.pal.alt[, 6]

## remove all but one of each clone
indNames(genind.data1)
genind.1clone.only <-
  genind.data1[c(5, 12, 18, 21, 27, 33, 41, 44, 48, 50, 55, 58, 65:335)]
indNames(genind.1clone.only) <-
  gsub("Bgedge", "SGS", indNames(genind.1clone.only))
indNames(genind.1clone.only) <-
  gsub("BgHq", "SGS", indNames(genind.1clone.only))
indNames(genind.1clone.only)

## Remove NAs
genind.1clone.only$tab <-
  tab(genind.1clone.only, NA.method = "mean")

###########################################################################################


# Define UI for app that creates genetic diversity DAPC plots ----
ui <- fluidPage(
  # App title ----
  titlePanel("Genetic diversity in blue grama"),
  
  # Sidebar layout with input and output definitions ----
  sidebarLayout(
    # Sidebar panel for inputs ----
    sidebarPanel(
      # Input: number of PCs ----
      
      sliderInput(
        inputId = "n_pca",
        label = h4("Number of PCs:"),
        min = 10,
        max = 100,
        value = 60
      ),
      
      # Input: sites included ----
      
      checkboxGroupInput(
        inputId = "sites",
        label = h4("Sites to include:"),
        choices = list(
          'Andrus' = 'Andrus',
          'Beech Trail' = 'Beech Trail',
          'Buffalo Gap' = 'Buffalo Gap',
          'Cedar Point' = 'Cedar Point',
          'Cibola' = 'Cibola',
          'Comanche' = 'Comanche',
          'Davidson Mesa' = 'Davidson Mesa',
          'Heil Valley' = 'Heil Valley',
          'Kelsall' = 'Kelsall',
          'Konza' = 'Konza',
          'Rabbit Mountain' = 'Rabbit Mountain',
          'Rock Creek' = 'Rock Creek',
          'Sevilleta' = 'Sevilleta',
          'SGS' = 'SGS',
          'Steele' = 'Steele',
          'Walker Ranch' = 'Walker Ranch',
          'Wonderland' = 'Wonderland'
        ),
        selected = c('Sevilleta',
                     'SGS',
                     'Konza',
                     'Cibola')
      ),
      
      # Input: grouping schema ----
      
      radioButtons(
        inputId = "grouping",
        label = h4("Grouping resolution: "),
        choices = list(
          "Site" = 1,
          "Region" = 2,
          "State" = 3
        ),
        selected = 2
      )
      
    ),
    
    # Main panel for displaying outputs ----
    mainPanel(# Output: Histogram ----
              plotOutput(outputId = "distPlot"))
  )
)


# Define server logic required to draw the DAPC plot of sites/groupings ----
server <- function(input, output) {
  output$distPlot <- renderPlot({
    ## Filter out any that are deselected from the DAPC
    genind.1clone.only <- genind.1clone.only[(genind.1clone.only@pop %in% input$sites),]
    
    if (input$grouping == 1) {
      grp <- pop(genind.1clone.only)
      ## n.da should be one less than the number of groups
      DAPC <- dapc(
        genind.1clone.only$tab,
        grp,
        n.pca = input$n_pca,
        n.da = length(unique(grp)) - 1
      )
      ## plot as groups
      plot.dat <- as.data.frame(DAPC$ind.coord)
      plot.dat <- cbind(plot.dat, DAPC$grp)
      names(plot.dat)[length(unique(grp))] <- "pop"
      plot.dat <- merge(plot.dat, col.pal)
      
      return(
        ggplot(data = plot.dat, aes(x = LD1, y = LD2)) +
          scale_color_manual(values = col.pal.colors, labels = col.pal.names) +
          theme_classic() +
          ## ellipses for visual aide
          stat_ellipse(
            data = subset(plot.dat, `abbv` == "A"),
            color = "#859D59"
          ) +
          stat_ellipse(
            data = subset(plot.dat, `abbv` == "BT"),
            color = "#6BAD9E"
          ) +
          stat_ellipse(
            data = subset(plot.dat, `abbv` == "DM"),
            color = "#217b7e"
          ) +
          stat_ellipse(
            data = subset(plot.dat, `abbv` == "HV"),
            color = "#426081"
          ) +
          stat_ellipse(
            data = subset(plot.dat, `abbv` == "RC"),
            color = "#399F2F"
          ) +
          stat_ellipse(
            data = subset(plot.dat, `abbv` == "RM"),
            color = "#A2D48E"
          ) +
          stat_ellipse(
            data = subset(plot.dat, `abbv` == "ST"),
            color = "#5EB54C"
          ) +
          stat_ellipse(
            data = subset(plot.dat, `abbv` == "WR"),
            color = "#A6CEE3"
          ) +
          stat_ellipse(
            data = subset(plot.dat, `abbv` == "CIB"),
            color = "#F88A89"
          ) +
          stat_ellipse(
            data = subset(plot.dat, `abbv` == "SEV"),
            color = "#E73233"
          ) +
          stat_ellipse(
            data = subset(plot.dat, `abbv` == "SGS"),
            color = "#FDB35A"
          ) +
          stat_ellipse(
            data = subset(plot.dat, `abbv` == "CO"),
            color = "#E19B78"
          ) +
          stat_ellipse(
            data = subset(plot.dat, `abbv` == "CP"),
            color = "#A889C1"
          ) +
          stat_ellipse(
            data = subset(plot.dat, `abbv` == "BG"),
            color = "#CBB0CE"
          ) +
          stat_ellipse(
            data = subset(plot.dat, `abbv` == "KNZ"),
            color = "#795199"
          ) +
          stat_ellipse(
            data = subset(plot.dat, `abbv` == "K"),
            color = "#72ADD1"
          ) +
          stat_ellipse(
            data = subset(plot.dat, `abbv` == "W"),
            color = "#3386AE"
          ) +
          geom_vline(xintercept = 0) + geom_hline(yintercept = 0) +
          geom_point(aes(color = legend.order),
                     size = 2) +
          labs(colour = "Site")
      )
    }
    
    if (input$grouping == 2) {
      genind.regional <- genind.1clone.only
      revalue(pop(genind.regional), c("Wonderland" = "Boulder")) -> pop(genind.regional)
      revalue(pop(genind.regional), c("Konza" = "Kansas")) -> pop(genind.regional)
      revalue(pop(genind.regional), c("Cedar Point" = "Nebraska")) -> pop(genind.regional)
      revalue(pop(genind.regional), c("Rabbit Mountain" = "Boulder")) -> pop(genind.regional)
      revalue(pop(genind.regional), c("SGS" = "SGS")) -> pop(genind.regional)
      revalue(pop(genind.regional), c("Kelsall" = "Boulder")) -> pop(genind.regional)
      revalue(pop(genind.regional), c("Sevilleta" = "New Mexico")) -> pop(genind.regional)
      revalue(pop(genind.regional), c("Cibola" = "New Mexico")) -> pop(genind.regional)
      revalue(pop(genind.regional), c("Steele" = "Boulder")) -> pop(genind.regional)
      revalue(pop(genind.regional), c("Beech Trail" = "Boulder")) -> pop(genind.regional)
      revalue(pop(genind.regional), c("Andrus" = "Boulder")) -> pop(genind.regional)
      revalue(pop(genind.regional), c("Heil Valley" = "Boulder")) -> pop(genind.regional)
      revalue(pop(genind.regional), c("Davidson Mesa" = "Boulder")) -> pop(genind.regional)
      revalue(pop(genind.regional), c("Rock Creek" = "Boulder")) -> pop(genind.regional)
      revalue(pop(genind.regional), c("Comanche" = "S. Colorado")) -> pop(genind.regional)
      revalue(pop(genind.regional), c("Buffalo Gap" = "S. Dakota")) -> pop(genind.regional)
      revalue(pop(genind.regional), c("Walker Ranch" = "Boulder")) -> pop(genind.regional)
      
      grp <- pop(genind.regional)
      ## n.da should be one less than the number of groups
      DAPC <- dapc(
        genind.regional$tab,
        grp,
        n.pca = input$n_pca,
        n.da = length(unique(grp)) - 1
      )
      ## plot as groups
      plot.dat <- as.data.frame(DAPC$ind.coord)
      plot.dat <- cbind(plot.dat, DAPC$grp)
      names(plot.dat)[length(unique(grp))] <- "pop"
      print(names(plot.dat))
      plot.dat <- merge(plot.dat, col.pal.alt)
      
      return(
        ggplot(data = plot.dat, aes(x = LD1, y = LD2)) +
          scale_color_manual(values = col.pal.alt.colors, labels = col.pal.alt.names) +
          theme_classic() +
          ## ellipses for visual aide
          stat_ellipse(
            data = subset(plot.dat, `abbv` == "BO"),
            color = "#217b7e"
          ) +
          stat_ellipse(
            data = subset(plot.dat, `abbv` == "KS"),
            color = "#795199"
          ) +
          stat_ellipse(
            data = subset(plot.dat, `abbv` == "NB"),
            color = "#72ADD1"
          ) +
          stat_ellipse(
            data = subset(plot.dat, `abbv` == "SGS"),
            color = "#FDB35A"
          ) +
          stat_ellipse(
            data = subset(plot.dat, `abbv` == "NM"),
            color = "#E73233"
          ) +
          stat_ellipse(
            data = subset(plot.dat, `abbv` == "SC"),
            color = "#F88A89"
          ) +
          stat_ellipse(
            data = subset(plot.dat, `abbv` == "SD"),
            color = "#CBB0CE"
          ) +
          geom_vline(xintercept = 0) + geom_hline(yintercept = 0) +
          geom_point(aes(color = legend.order),
                     size =2) +
          labs(colour = "Site")
      )
    }
    
    if (input$grouping == 3) {
      genind.grouped <- genind.1clone.only
      revalue(pop(genind.grouped), c("Wonderland" = "Colorado")) -> pop(genind.grouped)
      revalue(pop(genind.grouped), c("Konza" = "Kansas")) -> pop(genind.grouped)
      revalue(pop(genind.grouped), c("Cedar Point" = "Nebraska")) -> pop(genind.grouped)
      revalue(pop(genind.grouped), c("Rabbit Mountain" = "Colorado")) -> pop(genind.grouped)
      revalue(pop(genind.grouped), c("SGS" = "Colorado")) -> pop(genind.grouped)
      revalue(pop(genind.grouped), c("Kelsall" = "Colorado")) -> pop(genind.grouped)
      revalue(pop(genind.grouped), c("Sevilleta" = "New Mexico")) -> pop(genind.grouped)
      revalue(pop(genind.grouped), c("Cibola" = "New Mexico")) -> pop(genind.grouped)
      revalue(pop(genind.grouped), c("Steele" = "Colorado")) -> pop(genind.grouped)
      revalue(pop(genind.grouped), c("Beech Trail" = "Colorado")) -> pop(genind.grouped)
      revalue(pop(genind.grouped), c("Andrus" = "Colorado")) -> pop(genind.grouped)
      revalue(pop(genind.grouped), c("Heil Valley" = "Colorado")) -> pop(genind.grouped)
      revalue(pop(genind.grouped), c("Davidson Mesa" = "Colorado")) -> pop(genind.grouped)
      revalue(pop(genind.grouped), c("Rock Creek" = "Colorado")) -> pop(genind.grouped)
      revalue(pop(genind.grouped), c("Comanche" = "Colorado")) -> pop(genind.grouped)
      revalue(pop(genind.grouped), c("Buffalo Gap" = "S. Dakota")) -> pop(genind.grouped)
      revalue(pop(genind.grouped), c("Walker Ranch" = "Colorado")) -> pop(genind.grouped)
      
      grp <- pop(genind.grouped)
      ## n.da should be one less than the number of groups
      DAPC <- dapc(genind.grouped$tab,
                   grp,
                   n.pca = input$n_pca,
                   n.da = length(unique(grp)) - 1)
      ## plot as groups
      plot.dat <- as.data.frame(DAPC$ind.coord)
      plot.dat <- cbind(plot.dat, DAPC$grp)
      names(plot.dat)[length(unique(grp))] <- "pop"
      plot.dat <- merge(plot.dat, col.pal.alt)
      print(plot.dat)
      
      return(
        ggplot(data = plot.dat, aes(x = LD1, y = LD2)) +
          scale_color_manual(values = col.pal.alt.colors, labels = col.pal.alt.names)  +
          theme_classic() +
          ## ellipses for visual aide
          stat_ellipse(
            data = subset(plot.dat, `abbv` == "KS"),
            color = "#795199"
          ) +
          stat_ellipse(
            data = subset(plot.dat, `abbv` == "NB"),
            color = "#72ADD1"
          ) +
          stat_ellipse(
            data = subset(plot.dat, `abbv` == "NM"),
            color = "#E73233"
          ) +
          stat_ellipse(
            data = subset(plot.dat, `abbv` == "CO"),
            color = "#FDB35A"
          ) +
          stat_ellipse(
            data = subset(plot.dat, `abbv` == "SD"),
            color = "#CBB0CE"
          ) +
          geom_vline(xintercept = 0) + geom_hline(yintercept = 0) +
          geom_point(aes(color = legend.order),
                     size = 2) +
          labs(colour = "Site")
      )
    }
    
  })
  
}

shinyApp(ui = ui, server = server)