x <- read.table("docs/HomeWork_4/exercise/h7n1_beam_results_009.txt", header = T)
dim(x)

path <- "docs/HomeWork_4/exercise/"
filename <- dir(path)
filename

file_dev <- substr(filename, 1, 4)
file_dev

file_id <- gsub("^h[0-9]n[0-9]_", "", filename)
file_id

id_tmp <- gsub(".*?([0-9]+).*", "\\1", file_id)
id_tmp
ID <- paste0("ID",id_tmp)
ID

full_filename <- paste0(path,filename)
full_filename

datl <- lapply(full_filename, function(x) read.table(x,header = TRUE))
datl

dat <- do.call(rbind, datl)
dat

id_info <- data.frame(ID = rep(ID, each = 3), file_dev = rep(file_dev, each = 3), stringsAsFactors = F)
id_info

dat_fin <- cbind(id_info, dat)
dat_fin

beam_crf <- readRDS("docs/HomeWork_4/beam-crf-ex.rds")
beam_crf

require(tidyverse)
beam_crf <- beam_crf %>%
  mutate(eeg_id = regmatches(eeg_filenam, regexpr("^ID[0-9]{3}",eeg_filenam)))


head(dat_fin)
head(beam_crf)

beam_sub <- dat_fin %>%
  inner_join(beam_crf, by = c("ID" = "eeg_id",
                              "file_dev" = "eegdvid"))
beam_sub
beam_sub <- merge(dat_fin, beam_crf, by.x = c("ID", "file_dev"), by.y = c("eeg_id", "eegdvid") )
summary(beam_sub)

beam_sub2 <- beam_sub %>%
  select(usubjid, sex, age, literacy, Row, MDF, PF, ATR) %>%
  mutate_at(vars(sex, literacy, Row),
            ~ factor(.)) %>%
  mutate(age = floor(age))

beam_sub2 %>%
  group_by(Row) %>%
  summarise_at(vars(MDF, PF, ATR),
               list(mean = ~ mean(.),
               sd = ~ sd(.),
               min = ~ min(.),
               median = ~ median(.),
               max = ~ max(.)))

beam_sub2 %>%
  add_count(literacy) %>%
  group_by(literacy, n) %>%
  summarise_if( ~ is.numeric(.),
               ~ mean(.))
  
aggregate(cbind(MDF, PF, ATR) ~ Row, data = beam_sub2, FUN = function(x) c(mean = mean(x),
                                                                           sd = sd(x),
                                                                           min = min(x),
                                                                           median = median(x),
                                                                           max = max(x)))
tap_p2 <- data.frame(with(beam_sub2, table(literacy)))
names(tap_p2)[2] <- "n"
desc_p2 <- aggregate(cbind(age, MDF, PF, ATR) ~ literacy,
                     data = beam_sub2,
                     mean)
desc_p2 <- merge(tap_p2, desc_p2, by.x = "literacy")
desc_p2
