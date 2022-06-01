
#Isak Jonsson Öhström - 2A - 01-06-2022


#varaibler:

$uppdateringsfrekvens = 10
#en variabeln som används längre ned i funktionen och bestämmer intervallet i sekunder mellan uppdateringar av matsedeln.

$onskad_rad_i_html = 19
#om användaren lägger till data i eller ändrar sin skolmat.html fil kan man ändra vilken rad som dagens matsedel skall stå på.



# Beskrivning:							Denna funktion har för syfte att ta fram en textrad innehållande dagens lunchmeny för skolmatsalen.
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




def dagensmat(rss)          #definaerar min funktion vid namn degansmat med ett rss flöde som argument
    
    dagens_mat1 = ""        #initiserar variabel dagens_mat1 som skall innhålla förstarätten.
    dagens_mat2 = ""        #initiserar variabel dagens_mat1 som skall innhålla alternativrätt.
    i = 0                   #initsiering av i som används för inkrementering då while-loopen skall leta i rss-filen.
    
    while i < rss.length        #en hile loop som körs tills programmet har sökt igenom hela rss-flödets längd.
    
        if rss[i..i+5] == "CDATA["          #if-condiotion som letar efter en start-tagg där textraden med matsedeln finns.
    
            i += 6                          
    
            while rss[i] != "." && rss[i..i+4] != "<br/>"       #while loop som har för syfte att kopiera taxten med mat-sedeln fram tills dess att den stöter på . eller radbrytning.
    
                dagens_mat1 += rss[i]          #skriver som string till variabeln för första-rätt.
                #p rss[i]
    
                i += 1
    
            end
    
            if rss[i..i+4] == "<br/>"       #hoppa över radbrytningen.
                i += 5

            else

                while rss[i..i+4] != "<br/>"    #om ovan while-loop skulle avslutats på en punkt (innan radbrytning) skall "i" inkrementeras fram tills den kommer fram till radbrytningen.
        
                    i += 1      

                end
                i += 5          #hoppa över radbrytningen
            end 
    
            while rss[i] != "." && rss[i] != "]" && rss[i] != nil            #while loop som har för syfte att kopiera taxten med mat-sedeln fram tills dess att den stöter på någon form av avslutande tagg i rss-dokumentet.      
    
                dagens_mat2 += rss[i]               #skriver som string till variabeln för alternativ-rätt.
                #p rss[i]
    
                i += 1      #inkrementera fram ett steg.
    
                
            end

            
        end
        i += 1
    end
    
    return dagens_mat1, dagens_mat2         #låter funktionen returnera strängarna för första respektive alternativrätt som funktionen letat reda på.
   
end


# Beskrivning:							Denna funktion har för syfte att skriva ut (och ersätta) en textrad som skall skrivas ut i en html-fil.
# Argument 1: klass - beskrivning		String - Argumentet är en textrad med innehållet som skall skrivas ut och pressentaras på html-sidan.						
# Return: klass - beskrivning		    String - Funktionen returnerar en bekräftelse som säger att html-filen har uppdterats, i denna funktionen är dock inte reurnen så viktog som de kommadon som utförts i funktionen, då en output blir att innehållet i skolmat.html förändras
#
# Exempel:								Exempel på olika argument och förväntad return
#										
#										write_to_html(Korv med potatissallad) #=> Skolmat.html får innehåll som följande:
#<!DOCTYPE html>
#<html lang="en">
#<head>
 #   <meta charset="UTF-8">
  #  <meta name="viewport" content="width=device-width, initial-scale=1.0">
   # <meta http-equiv="X-UA-Compatible" content="ie=edge">
#    <meta http-equiv="refresh" content="5" >   
#    <!-- uppdaterar sidan automatiskt för att visa nya förändringar.-->
 #   <title>Document</title>

 #   <style>
  #  h1{text-align: center;}
    
  #  </style>
#</head>
#<body>

    
#<h1>

#Korv med potatissallad

#</h1>


#</body>
#</html>


#   
# By:									Isak Jonsson Öhström
# Date:									01-06-22



def write_to_html(forsaratt)        #definererar funktionen men dyfte attt skriva ut matsedeln i ett html-dokument.


    if  File.file?("skolmat.html")      #om det redan finns en fil vid namn skolmat.html:

        gamlahtml = File.readlines("skolmat.html")   #spara det nuvarande innehållet från skolmat.html som en array till en variabel.

        #p html

        gamlahtml[$onskad_rad_i_html] = (forsaratt + "\n")   #ändra den rad (19) där jag har skrivit dagens maträtt och ersätt den med det argument som funktionen fått som inout (dagens förstarätt)


        nyahtml = File.open("skolmat.html", "w")  #skapar en ny fil som skriver över den gamla skolmat.html och tilldelar denna varaibeln html

        nyahtml.write(gamlahtml.join)    #skriver innehållet från varaibeln gamlahtml (där funktionen har skrivit i dangsns maträtt) till den än så länge tomma skolmat.html. då jag änvänder .readlines (som gör varje rad till ett element i en array) högre upp för att identifiera varje rad i dokumentet behöver jag nu använda .join för att göra om enna array till en string.

        #k = 0
        #while k < 28

        #gamlahtml.write(html[k])

        #k += 1
        #end

        nyahtml.close     #stänger dokumentet vilket sparar filen


        return "html-filen är uppdaterad"       #en lite onödig return men kan vara bra med en bekräftelse till användare om det önskas.


    else 
        raise "filen skolmat.html hittades ej"      #om filen skolmat.html inte finns kastas eff felmeddelande. då funktionen behöver innehållet i den gamla filen för att kopiera till den nya, kan funktionen inte bara skapa en ny .html fil i de fall då den saknas.
    end

    



end

j = 0

#nedan while loop läser in datan från webben och kör sedan funktionen dagensmat med web-datan som argument. loppen körs om igen 100 gånger med ett intervall på 10 sek, tanken är att det skall vara ett enkelt "auto-refesch" för att alltid visa den aktuella måltiden i terminalen och skriva ut det i ett html-dokument.

user_input = ""

while j < 100 && user_input != "avsluta"

   


    require 'open-uri'          #inkluderar ett biblotek för att kunna kopiera innehåll från web-sidor.

    open("lunch-data_rss.txt", "wb") do |file|      #skapar och öppnar en ny .txt fil vid namn lunch-data_rss.txt som skall skrivas till.
    URI.open("http://www.skolmaten.se/it-gymnasiet-goteborg/rss/days") do |uri|     #öppnar url-länken till sidan där rss-flödet innehållande matsedeln finns.
        file.write(uri.read)        #skrivr innehållet från rss-flödet till .txt filen.
    end
    end





    puts dagensmat(File.read("lunch-data_rss.txt"))[0]  #anropar funktionen "dagensmat" och skriver ut förstarätten i terminalen med en radbrytning efter.

    puts dagensmat(File.read("lunch-data_rss.txt"))[1]  #anropar funktionen "dagensmat" och skriver ut alternativrätten i terminalen med en radbrytning efter.

    puts ""     #lite mellanrum för lättläslighet i terminalen.



    puts write_to_html(dagensmat(File.read("lunch-data_rss.txt"))[0])


    j += 1      #j inkremnteras upp för att räkna antalet varv while-loopen körts. (upp till 100 gånger.)

   

    sleep ($uppdateringsfrekvens)      #vänta 10sek tills den kör programmet igen för att uppdatera matsedeln.
    

end