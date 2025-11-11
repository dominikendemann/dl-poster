
#Laden von Apps
library(shiny)
library(reactable)


#Daten
daten_text <- "SuS;Test1_Mathematik_Geometrische_Korper;Test2_Mathematik_Schriftliches_Addieren_Subtrahieren;Test3_Mathematik_Tabellen_und_Diagramme;Test1_Deutsch_Lesetest;Test2_Deutsch_RS_Test;Test3_Deutsch_RS_Test;Anstrengungsbereitschaft;Ausserschulisches_Engagement;Sonstiges
1;2;2;4;5;3;4;mittel;keine Förderung;
2;3;4;3;5;4;5;mittel;keine Förderung;
3;4;3;4;5;4;4;gering;keine Förderung;52 Fehltage
4;1;3;2;3;3;3;hoch;Eltern sehr aktiv;
5;4;2;2;4;2;2;mittel;Hausaufgabenbetreuung;'Abwesend bei VERA Vorbereitung'
6;2;2;2;3;3;2;mittel;Eltern sehr aktiv;
7;2;1;2;3;3;4;hoch;Eltern sehr aktiv;'Leseprobleme, v.a. Leseflüssigkeit'
8;4;4;4;5;4;4;mittel;Hausaufgabenbetreuung;Leseprobleme
9;3;3;4;3;3;3;mittel;Hausaufgabenbetreuung;'Abwesend bei VERA Vorbereitung'
10;4;2;4;5;4;5;mittel;wenig Förderung;'Abwesend bei VERA Vorbereitung'
11;3;4;4;3;2;2;hoch;keine Förderung;
12;5;4;5;5;5;4;mittel;wenig Förderung;
13;2;2;3;2;1;3;hoch;wenig Förderung;
14;1;1;2;1;2;2;hoch;Eltern sehr aktiv; 'Abwesend bei VERA Vorbereitung'
15;3;3;3;2;3;2;mittel;Hausaufgabenbetreuung;
16;3;3;3;5;4;5;gering;keine Förderung;'Unzureichende Sprachkenntnisse'
17;3;3;3;4;5;3;mittel;DaZ-Kurs;'Teilw. Probleme mit D. Sprache'
18;3;4;4;5;3;4;gering;Hausaufgabenbetreuung;
19;2;2;3;4;4;2;mittel;'Eltern sehr aktiv, HA- Betreuung;
20;2;3;4;6;4;5;mittel;keine Förderung;'Probleme mit Sprache'
21;2;2;2;4;3;4;hoch;DaZ-Kurs;'Teilw. Probleme mit D. Sprache'
22;2;4;4;2;4;3;mittel;Eltern sehr aktiv;"

# Daten in ein Dataframe umwandeln
daten1 <- read.table(text = daten_text, sep = ";", header = TRUE, quote = "")

#Shiny UI
ui <- navbarPage(
  title = "",
  header = div(
    style = "padding: 10px; background-color: #f0f0f0; text-align: center; font-size: 14px;",
   HTML(  "Endemann, D., & Gärtner, H. (2025, August). Development of a test to measure the data literacy of pre-service teachers. <i> Poster presentation at the 2025 Biennial Conference of the European Association for Research on Learning and Instruction (EARLI)</i>, Graz, Austria."
  )),
 
  tabPanel("Poster",
           fluidPage(
             mainPanel(
               tags$iframe(id = "poster", style = "width:100vw; height:100vh; border:none;", src = "poster.pdf")
             )
           )),
  # width = "100%", height = "100%",
  
  tabPanel("Stimuli",
           fluidPage(
             tabsetPanel(
               tabPanel("VERA Klassenrückmeldung",
                        tags$iframe(id = "Datei1", width = 1000, height = 800, src = "KRM.pdf")),
               
               tabPanel("VERA Schüler*innenrückmeldung",
                        tags$iframe(id = "Datei2", width = 1000, height = 800, src = "SuSRM.pdf")),
               
               tabPanel("Klassenliste",
                        reactableOutput("tabelle")),
               
               tabPanel("Internes Curriculum Deutsch",
                        tags$iframe(id = "Datei3", width = 1000, height = 800, src = "CurrD.pdf")),
               
               tabPanel("Internes Curriculum Mathematik",
                        tags$iframe(id = "Datei4", width = 1000, height = 800, src = "CurrM.pdf"))
             )
           ))
)


server <- function(input, output) {
  output$tabelle <- renderReactable({
    #Test Theme
    theme <- reactableTheme(color = "hsl(0, 0%, 87%)", backgroundColor = "hsl(220, 13%, 18%)", 
                            borderColor = "hsl(0, 0%, 22%)", stripedColor = "rgba(255, 255, 255, 0.04)", 
                            highlightColor = "rgba(255, 255, 255, 0.06)", inputStyle = list(backgroundColor = "hsl(0, 0%, 24%)"), 
                            selectStyle = list(backgroundColor = "hsl(0, 0%, 24%)"), 
                            pageButtonHoverStyle = list(backgroundColor = "hsl(0, 0%, 24%)"), 
                            pageButtonActiveStyle = list(backgroundColor = "hsl(0, 0%, 28%)"))
    #Test Theme Ende
    
    reactable(
      daten1,
      filterable = TRUE,
      paginationType = "simple", 
      showPageSizeOptions = TRUE,
      striped = TRUE, 
      compact = TRUE,
      fullWidth = FALSE,
      showSortable = TRUE,
      showPageInfo = FALSE,
      defaultPageSize = 23,
      showPagination = FALSE,
      wrap = TRUE,
      theme = theme,
      height = 800,
      width = 1250,
      columns = list(
        SuS = colDef(name = "Schüler*in", width = 100, align = "center"),
        Test1_Mathematik_Geometrische_Korper = colDef(name = "<u> Noten </u> <br> Test 1 Mathematik: <br> Geometrische <br> Körper", width = 125, align = "center", html = TRUE),
        Test2_Mathematik_Schriftliches_Addieren_Subtrahieren = colDef(name = "<u> Noten </u> <br> Test 2 Mathematik: Schriftliches Addieren & Subtrahieren", width = 120, align = "center", html = TRUE),
        Test3_Mathematik_Tabellen_und_Diagramme = colDef(name = "<u> Noten </u> <br> Test 3 Mathematik: Tabellen und Diagramme", width = 120, align = "center", html = TRUE),
        Test1_Deutsch_Lesetest = colDef(name = "<u> Noten </u> <br> Test 1 Deutsch: Lesetest", width = 90, align = "center", html = TRUE),
        Test2_Deutsch_RS_Test = colDef(name = "<u> Noten </u> <br> Test 2 Deutsch: RS-Test", width = 90, align = "center", html = TRUE),
        Test3_Deutsch_RS_Test = colDef(name = "<u> Noten </u> <br> Test 3 Deutsch: RS-Test", width = 90, align = "center", html = TRUE),
        Anstrengungsbereitschaft = colDef(name = "Anstrengungsbereitschaft", width = 160, align = "left"),
        Ausserschulisches_Engagement = colDef(name = "Außerschulisches Engagement", width = 170, align = "left"),
        Sonstiges = colDef(name = "Sonstiges", width = 140, align = "left") 
        
      )
      
      
    )
  })
}

# Shiny-Anwendung starten
shinyApp(ui, server)
