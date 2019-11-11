'''
replace text through files
'''
import os
directory="/Users/avahoffman/Dropbox/Research/Bouteloua_diversity/Genomics/Bouteloua_genomics/03.5-genotyping_prep"
if not os.path.exists(directory+"/new"):
    os.makedirs(directory+"/new")
for filename in os.listdir(directory):
    if filename.endswith(".sh"):
        print(os.path.join(directory, filename))
        with open(directory+"/"+filename) as open_file, open(directory+"/new/"+filename,"w") as new_file:
            linecount=0
            for line1 in open_file:
                linecount+=1 # TEXT TO BE MODIFIED BELOW
                line2=line1.replace("time=24:00:00","time=6:00:00") 
                new_file.write(line2)
        continue
    else:
        continue