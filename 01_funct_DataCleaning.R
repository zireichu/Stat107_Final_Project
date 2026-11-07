source("~/GitHub/Stat107_Final_Project/00_requirements.R")
raw_data <- read_csv("C:/Users/zirei/OneDrive/Documents/GitHub/Stat107_Final_Project/Most-Recent-Cohorts-Institution.csv",
  show_col_types = FALSE)
dim(raw_data)
glimpse(raw_data)
pell_vars <- c(
  "OMENRYP_PELL_ALL",
  "OMENRAP_PELL_ALL",
  "OMAWDP8_PELL_ALL",
  "OMENRUP_PELL_ALL")
id_vars <- c(
  "UNITID",
  "OPEID",
  "OPEID6",
  "INSTNM",
  "STABBR")
research_vars <- c(
  "ICLEVEL",
  "PREDDEG",
  "C150_4"
)
pcip_vars <- names(raw_data)[
  grepl("^PCIP", names(raw_data))]
keep_vars <- unique(c(
  pell_vars,
  id_vars,
  research_vars,
  pcip_vars))
missing_vars <- setdiff(
  c(pell_vars, id_vars, research_vars),
  names(raw_data))
if (length(missing_vars) > 0) {
  stop(
    paste(
      "Missing required variables:",
      paste(missing_vars, collapse = ", ")   ) )}
clean_data <- raw_data %>%
  select(all_of(keep_vars))
dim(clean_data)
missing_summary <- clean_data %>%
  summarise(
    across(everything(), ~ sum(is.na(.)))
  ) %>%
  pivot_longer(
    cols = everything(),
    names_to = "Variable",
    values_to = "Missing_Count"
  ) %>%
  filter(Missing_Count > 0) %>%
  arrange(desc(Missing_Count))
print(missing_summary, n = 30)
duplicate_ids <- clean_data %>%
  count(UNITID) %>%
  filter(n > 1)
duplicate_ids
nrow(duplicate_ids)
table(clean_data$PREDDEG, useNA = "ifany")
table(clean_data$ICLEVEL, useNA = "ifany")
clean_data %>%
  count(STABBR, sort = TRUE)
write_csv(
  clean_data,
  "C:/Users/zirei/OneDrive/Documents/GitHub/Stat107_Final_Project/12_DataSaving.csv")
save(
  clean_data,
  file = "C:/Users/zirei/OneDrive/Documents/GitHub/Stat107_Final_Project/12_SavingData.RData")
dim(clean_data)

