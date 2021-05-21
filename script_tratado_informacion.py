import re

#myfile = open("prueba_01.txt", "r")
#myfile_2 = open("recoutTest_copia_prueba.mlf", "w")
myfile = open("recoutTest.mlf", "r")
#myfile_2 = open("prueba_02.txt", "w")
myfile_2 = open("recoutTest_tratado.mlf", "w")

archivo = ""
breakline = "\n"

while myfile:
    line  = myfile.readline()
    
    if line.startswith("#") == True:
        search_term = "palabra" 
        #print(archivo)
        myfile_2.write(search_term)
        myfile_2.write(breakline) 

    elif line.startswith(".") == True:
        pass
    elif line == "":
        break

    elif line.startswith("\"*/") == True:


        archivo = line
        #print(archivo)
        myfile_2.write(archivo)
        #myfile_2.write(" ")
        #myfile_2.write(line)
        #print(line)
    #myfile_2.write(archivo)
    else :
        
        string = line + " " + archivo
        for s in string.split('\n'):
            #print (s) 
            line2 = re.sub("[ ]",";",s)
            myfile_2.write(line2)
        
        myfile_2.write(breakline)                       
        #print (string)
        #breakline = "\n"
        #string2 = string.remove(breakline)
        #myfile_2.writeline(string)

        #myfile_2.write(" ")
        #myfile_2.write(s)
        
 
myfile.close()
myfile_2.close()
#myfile_2.close()






