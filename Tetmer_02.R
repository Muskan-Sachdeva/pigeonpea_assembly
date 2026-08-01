library(Tetmer)

##NSPP_3C_Illumina_Spectrum
#k21

spIll_3C_k21 <- read.spectrum("F:/muskan/Histogram_txt_files/NSPP_3C/Illumina/k21/NSPP_3C_k21_histogram.txt",
                              k=21,
                              nam="Illumina_3C, k=21")
spIll_3C_k21
tetmer(spIll_3C_k21)

##NSPP_3C_ONT_spectrum
#k21

spONT_3C_k21 <- read.spectrum("F:/muskan/Histogram_txt_files/NSPP_3C/ONT/k21/ONT_NSPP_3C_k21_histogram.txt",
                              k=21,
                              nam="ONT_3C, k=21")
spONT_3C_k21
tetmer(spONT_3C_k21)

##NSPP_50_Illumina_Spectrum
#k21
spIll_50_k21 <- read.spectrum("F:/muskan/Histogram_txt_files/NSPP_50/Illumina/k21/Illumina_NSPP_50_k21_histogram.txt",
                              k=21,
                              nam="Illumina_50, k=21")
spIll_50_k21
tetmer(spIll_50_k21)

##NSPP_50_ONT_spectrum
##k21
spONT_50_k21 <- read.spectrum("F:/muskan/Histogram_txt_files/NSPP_50/ONT/k21/ONT_NSPP_50_k21_histogram.txt",
                              k=21,
                              nam="ONT_50, k=21")
spONT_50_k21
tetmer(spONT_50_k21)

##NSPP_70_Illumina
#k21
spIll_70_k21 <- read.spectrum("F:/muskan/Histogram_txt_files/NSPP_70/Illumina/k21/Illumina_NSPP_70_k21_histogram.txt",
                              k=21,
                              nam="Illumina_70, k=21")
spIll_70_k21
tetmer(spIll_70_k21)

##NSPP_70_ONT_Spectrum
#k21
spONT_70_k21 <- read.spectrum("F:/muskan/Histogram_txt_files/NSPP_70/ONT/k21/NSPP_70_k21_ONT_histogram.txt",
                              k=21,
                              nam="ONT_70, k=21")
spONT_70_k21
tetmer(spONT_70_k21)

#####NSPP_87_Illumina
#k21

spIll_87_k21 <- read.spectrum("F:/muskan/Histogram_txt_files/NSPP_87/Illumina/k21/NSPP_87_k21_histogram.txt",
                              k=21,
                              nam="Illumina_87, k=21")
spIll_87_k21
tetmer(spIll_87_k21)

##NSPP_87_ONT
#k21

spONT_87_k21 <- read.spectrum("F:/muskan/Histogram_txt_files/NSPP_87/ONT/k21/ONT_NSPP_87_k21_histogram.txt",
                              k=21,
                              nam="ONT_87, k=21")
spONT_87_k21
tetmer(spONT_87_k21)