library(ggplot2)
library(plotly)


BRAFAZ628 <- read.table("BRAF_AZ628.csv", header = T, sep = ",")
BRAFgdc0879 <- read.table("BRAF_gdc0879.csv", header = T, sep = ",")
BRAFvem6vem <- read.table("BRAF_vem6vem.csv", header = T, sep = ",")
BRAFwt <- read.table("BRAF_wt.csv", header = T, sep = ",")



dat <- list(BRAFAZ628=BRAFAZ628[,2],BRAFgdc0879=BRAFgdc0879[,2],BRAFvem6vem=BRAFvem6vem[,2], BRAFwt = BRAFwt[,2])
dat <- lapply(dat, function(x) cbind(x = seq_along(x), y = x))

list.names <- names(dat)
lns <- sapply(dat, nrow)
dat <- as.data.frame(do.call("rbind", dat))
dat$group <- rep(list.names, lns)
names(dat) <- c("C_alpha_atom_number", "Square_fluctuations", "Protein_type")


g <- ggplot(dat, aes(x = C_alpha_atom_number, y = Square_fluctuations, colour = Protein_type)) +
  theme_bw() +
  geom_line(size=2)
g
p <- ggplotly(g)
p
plot(BRAFAZ628[1:500,2], BRAFgdc0879[1:500,2])

pairs(~BRAFAZ628[1:500,2]+BRAFgdc0879[1:500,2]+BRAFvem6vem[1:500,2]+BRAFwt[1:500,2], 
      main="Protein type Scatterplot Matrix")
