import re, os, shutil

myfile = open("recoutTest.mlf", "r")
myfile_2 = open("recoutTest_tratado_2.mlf", "w")

archivo = ""
breakline = "\n"


while myfile:
    line  = myfile.readline()
    
    if line.startswith("#") == True:
        search_term = "palabra" 
        myfile_2.write(search_term)
        myfile_2.write(breakline) 

    elif line.startswith(".") == True:
        pass
    elif line == "":
        break

    elif line.startswith("\"*/") == True:
        archivo = line
        myfile_2.write(archivo)
    else :
        
        string = line + " " + archivo
        for s in string.split('\n'):
            line2 = re.sub("[ ]",";",s)
            myfile_2.write(line2)
        
        myfile_2.write(breakline)   
        
myfile.close()
myfile_2.close()









