csv_files <- list.files("Data/", pattern = "\\.csv$", full.names = TRUE)

csv_filenum <- length(csv_files)

df <- read.csv("Data/wingspan_vs_mass.csv")

head(df, 5)

letter_b <- list.files("Data/", pattern = "^b", full.names = TRUE, recursive = TRUE)

for (file in letter_b) {
  cat(file, ": ", readLines(file, n = 1), "\n")
}

for (file in csv_files) {
  cat(file, ": ", readLines(file, n = 1), "\n")
}
