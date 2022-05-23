


# Beskrivning:							Detta program och dess huvudfunktion har för syfte att ta fram en textrad innehållande dagens lunchmeny för skolmatsalen.
# Argument 1: klass - beskrivning		String - Argumentet är ett txt dokument för ett helt rss flöde, vilket är automatiskt genereread kopia av rss flödet från Skolmaten.se där datan för matsedeln finns.						
# Return[0]: klass - beskrivning		String - en kort textrad innhållande endast dagens huvud/första rätt
# Return[1]: klass - beskrivning		String - en kort textrad innhållande endast dagens alternativrätt
#
# Exempel:								Exempel på olika argument och förväntad return
#										
#										"Automatgenererat argument 23-05-22" #=> "Korv med potatissallad", "Sojakorv med potatissallad"
#										"Automatgenererat argument 23-05-18" #=> "Chicken a la king med pasta", "Pasta med bönor i vitlök- och persiljesås"
#										"Automatgenererat argument 23-05-10" #=> "Köttbullar med makaroner", "Falafel med makaroner"
#   
# By:									Isak Jonsson Öhström
# Date:									23-05-22





def dagensmat(rss)
    
    dagens_mat1 = ""
    dagens_mat2 = ""
    i = 0
    
    while i < rss.length
    
        if rss[i..i+5] == "CDATA["
    
            i += 6
    
            while rss[i] != "." && rss[i..i+4] != "<br/>"
    
                dagens_mat1 += rss[i]
                #p rss[i]
    
                i += 1
    
            end
    
            if rss[i..i+4] == "<br/>"
                i += 5

            else

                while rss[i..i+4] != "<br/>"
        
                    i += 1

                end
                i += 5
            end
    
            while rss[i] != "." && rss[i] != "]" && rss[i] != nil
    
                dagens_mat2 += rss[i]
                #p rss[i]
    
                i += 1
    
                
            end

            
        end
        i += 1
    end
    
    return dagens_mat1, dagens_mat2
   
end

j = 0

#nedan while loop läser in datan från webben och kör sedan funktionen dagensmat med web-datan som argument. loppen körs om igen 100 gånger med ett intervall på 10 sek, tanken är att det skall vara ett enkelt "auto-refesch" för att alltid visa den aktuella måltiden i terminalen.

while j < 100


    require 'open-uri'

    open("lunch-data_rss.txt", "wb") do |file|
    URI.open("http://www.skolmaten.se/it-gymnasiet-goteborg/rss/days") do |uri|
        file.write(uri.read)
    end
    end





    puts dagensmat(File.read("lunch-data_rss.txt"))[0]

    puts dagensmat(File.read("lunch-data_rss.txt"))[1]

    puts ""


    j += 1

    sleep (10)


end