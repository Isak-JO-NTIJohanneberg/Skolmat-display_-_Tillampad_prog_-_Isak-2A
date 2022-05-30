

def dagensmat(rss):
    
  
    dagens_mat1 = ""
    dagens_mat2 = ""
    i = 0
    
    while i < len(rss)-5:
      
    
        if rss[i]+rss[i+1]+rss[i+2]+rss[i+3]+rss[i+4]+rss[i+5] == "CDATA[":
    
            i += 6
            
            
            while rss[i] != "." and rss[i]+rss[i+1]+rss[i+2]+rss[i+3]+rss[i+4] != "<br/>":
                dagens_mat1 += rss[i]
               
    
                i += 1
    
        
    
            if rss[i]+rss[i+1]+rss[i+2]+rss[i+3]+rss[i+4] == "<br/>":
                i += 5

            else:

                while rss[i]+rss[i+1]+rss[i+2]+rss[i+3]+rss[i+4] != "<br/>":
        
                    i += 1

            
                i += 5
            
            while rss[i] != "." and rss[i] != "]" and rss[i] != None:
             
    
                dagens_mat2 += rss[i]
               
    
                i += 1
                
    
        i += 1



    return dagens_mat1, dagens_mat2
   





import urllib.request

get_url= urllib.request.urlopen('http://www.skolmaten.se/it-gymnasiet-goteborg/rss/days')

print(dagensmat(str(get_url.read())))
