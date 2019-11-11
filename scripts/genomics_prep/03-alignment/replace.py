'''
replace text through files
'''
import os
directory="/Users/avahoffman/Dropbox/Research/Bouteloua_diversity/Genomics/Bouteloua_genomics/03-alignment"
if not os.path.exists(directory+"/new"):
    os.makedirs(directory+"/new")
for filename in os.listdir(directory):
    if filename.endswith(".sh"):
        print(os.path.join(directory, filename))
        with open(directory+"/"+filename) as open_file, open(directory+"/new/"+filename,"w") as new_file:
            linecount=0
            for line1 in open_file:
                linecount+=1 # TEXT TO BE MODIFIED BELOW
                line2=line1.replace("#gmapper","gmapper") 
                line3=line2.replace("reference/reference.fasta","reference/reference_samples.fasta")
                new_file.write(line3)
        continue
    else:
        continue