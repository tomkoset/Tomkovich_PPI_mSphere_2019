#####################
# 
# analysis of experiment - Treat mice with abx and/or PPI and challenge with C difficile
# 
# input:
#	data/mothur/ppi.opti_mcc.braycurtis.0.03.lt.ave.pcoa.axes
#	data/process/ppi_metadata.txt
#
# output:
#	pcoa plots
#		
#
#####################

library(tidyverse)

metadata <- read.table('data/process/ppi_metadata.txt', header = T, sep = '\t', stringsAsFactors = F)

# read in pcoa data
pcoa <- read_tsv('data/mothur/ppi.opti_mcc.braycurtis.0.03.lt.ave.pcoa.axes') %>%
  select(group, axis1, axis2) %>% rename(shared_names = group) %>% 
	right_join(metadata, by = "shared_names") # join with cleaned up metadata for day, mouse, treatment
  # Select O+, C+, and CO+ groups. Convert Group letter labels to more descriptive labels
pcoa <- pcoa %>% filter(Group != "NA") %>% 
  mutate(Group = case_when(Group == 'O+' ~ 'PPI', 
                           Group == 'C+' ~ 'Clindamycin',
                           Group == 'CO+' ~ 'Clindamycin + PPI'))
#plot all samples
pcoa %>%  
  ggplot(aes(x=axis1, y=axis2, color=Group, alpha = day)) +
  geom_point() +
  theme_classic()+
  labs(title="All groups, all timepoints") +
  theme(plot.title = element_text(hjust = 0.5))


#plot just PPI samples
pcoa %>% filter(Group == "PPI") %>%  
  ggplot(aes(x=axis1, y=axis2, color=Group, alpha = day)) +
  geom_point()+
  theme_classic() +
  labs(title="PPI-treated mice") +
  theme(plot.title = element_text(hjust = 0.5))

#plot just Clindamycin samples
pcoa %>% filter(Group == "Clindamycin") %>%  
  ggplot(aes(x=axis1, y=axis2, color=Group, alpha = day)) +
  geom_point() +
  theme_classic()+
  labs(title="Clindamycin-treated mice") +
  theme(plot.title = element_text(hjust = 0.5))

#plot just Clindamycin + PPI samples
pcoa %>% filter(Group == "Clindamycin + PPI") %>%  
  ggplot(aes(x=axis1, y=axis2, color=Group, alpha = day)) +
  geom_point() +
  theme_classic() +
  labs(title="Clindamycin/PPI treated mice") +
  theme(plot.title = element_text(hjust = 0.5))

# plot for before abx
pcoa %>% filter(day < 7) %>% 
  ggplot(aes(x=axis1, y=axis2, color=Group, alpha = day)) +
  geom_point() +
  theme_classic() +
  labs(title="Before antibiotic treatment") +
  theme(plot.title = element_text(hjust = 0.5))
  

#plot before abx with D0 removed
pcoa %>% filter(day < 7) %>% filter(day > 0) %>% 
  ggplot(aes(x=axis1, y=axis2, color=Group, alpha = day)) +
  geom_point() +
  theme_classic()+
  labs(title="Before antibiotic treatment without initial baseline day") +
  theme(plot.title = element_text(hjust = 0.5))

# plot day after abx
pcoa %>%	filter(day == 7) %>% 
  ggplot(aes(x=axis1, y=axis2, color=Group, alpha = day)) +
  geom_point() +
  theme_classic()+
  labs(title="Day after antibiotic treatment") +
  theme(plot.title = element_text(hjust = 0.5))

# plot after abx & C. diff
pcoa %>% filter(day > 7) %>% 
  ggplot(aes(x=axis1, y=axis2, color=Group, alpha = day)) +
  geom_point() +
  theme_classic() +
  labs(title="After antibiotic treatment & C. difficile challenge") +
  theme(plot.title = element_text(hjust = 0.5))
