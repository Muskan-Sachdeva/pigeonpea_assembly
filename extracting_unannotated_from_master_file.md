################extracting the unannotated gene ids from the master file



library(dplyr)

library(readr)





\##reading master file in R

master\_file <- read\_tsv("NSPP\_50\_master\_annotation.tsv", show\_col\_types = FALSE)





\##

master\_file <- master\_file %>%

  mutate(

    has\_sprot  = !is.na(sprot\_subject\_id)  \& sprot\_subject\_id  != "",

    has\_legume = !is.na(legume\_subject\_id) \& legume\_subject\_id != "",

    has\_ncbi   = !is.na(nr\_subject\_id)     \& nr\_subject\_id     != "",

    has\_emap   = !is.na(Description)       \& Description       != "",

    has\_ipr    = !is.na(ipr\_ids)           \& ipr\_ids           != "",

    has\_any\_db = has\_sprot | has\_legume | has\_ncbi | has\_emap | has\_ipr

  )





\##unannotated genes ids extract in new separate file



unannot\_ids <- master\_file %>%

  filter(!has\_any\_db) %>%

  pull(protein\_id) %>%

  unique()



length(unannot\_ids)   # yahan ~2510 aana chahiye



write\_lines(unannot\_ids, "NSPP\_50\_unannotated\_from\_master\_ids.txt")





\######################################extracting all the ids from braker.noStop.aa output



cd /exports/cmvm/eddie/eb/groups/HighlanderLab/visitors/Muskan/braker\_output/NSPP\_50"



grep ">" braker.noStop.aa | sed 's/^>//' > braker\_ids.txt





\######################### R me set difference nikalna



library(readr)

library(dplyr)



\# 1) Master ids (set B)

master\_ids <- master\_file$protein\_id %>% unique()



\# 2) BRAKER ids (set A)

braker\_ids <- read\_lines("/exports/cmvm/eddie/eb/groups/HighlanderLab/visitors/Muskan/braker\_output/NSPP\_50/braker\_ids.txt")



length(braker\_ids)   # 49243

length(master\_ids)   # 45718



\# 3) Jo BRAKER me hain, par master me nahi:

only\_in\_braker <- setdiff(braker\_ids, master\_ids)



length(only\_in\_braker)   # 3525



\# 4) File me save karo

write\_lines(only\_in\_braker, "NSPP\_50\_extra\_from\_BRAKER\_not\_in\_master\_ids.txt")





\####################################################################################################################################################

\##merging the files jo unannotated h master file me and jo present nhi h braker ke master file me :



file 1: NSPP\_3C\_unannotated\_from\_master\_ids.txt ## ids jo master files me unannotated h

file 2: NSPP\_3C\_extra\_from\_BRAKER\_not\_in\_master\_ids.txt ## jo ids braker me h but master file me nhi



library(readr)



\# 1) Dono files se IDs read karo

ids\_unannot\_master <- read\_lines("NSPP\_50\_unannotated\_from\_master\_ids.txt")

ids\_extra\_braker   <- read\_lines("NSPP\_50\_extra\_from\_BRAKER\_not\_in\_master\_ids.txt")



length(ids\_unannot\_master)  # ~2510

length(ids\_extra\_braker)    # ~3525



\# 2) Union = dono ka merged set, duplicates automatically hata dega

all\_unannot\_for\_relaxed <- union(ids\_unannot\_master, ids\_extra\_braker)

length(all\_unannot\_for\_relaxed)



\# 3) Nayi file me likho

write\_lines(

  all\_unannot\_for\_relaxed,

  "NSPP\_50\_unannot\_all\_BRAKER\_for\_relaxed\_ids.txt"

)





\################################################NSPP\_3C\_unannot\_all\_BRAKER\_for\_relaxed\_ids.txt  :  final file going to use for relaxed annotation



\###################################################################################################################################################



\## now extracting the fasta seuences for all these ids form braker.noStop.aa using seqtk



conda activate assembly

module load miniforge

conda install -c bioconda seqtk



seqtk subseq /exports/cmvm/eddie/eb/groups/HighlanderLab/visitors/Muskan/braker\_output/NSPP\_50/braker.noStop.aa /exports/cmvm/eddie/eb/groups/HighlanderLab/visitors/Muskan/master\_files/NSPP\_50/NSPP\_50\_unannot\_all\_BRAKER\_for\_relaxed\_ids.txt \\

  > **NSPP\_3C\_unannot\_all\_BRAKER\_for\_relaxed.fa**



\###checking fasta is correct or not

wc -l NSPP\_50\_unannot\_all\_BRAKER\_for\_relaxed\_ids.txt

grep -c "^>" NSPP\_50\_unannot\_all\_BRAKER\_for\_relaxed.fa







 

