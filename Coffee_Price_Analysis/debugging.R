### Debugging heatmap
coffee %>% 
  filter(Date <= '2014-11-30') %>% 
  mutate(years = factor(lubridate::year(Date))) %>% 
  group_by(years) %>% 
  summarize(High = sum(High), Low = sum(Low), Open = sum(Open)) %>%  
  #head()
  
  # draw heatmap based on specified year range
  ## figure out why heatmap is not working
  ggplot(aes(x = High, y = Low, fill = Open)) +
  geom_tile(width = 30000, height = 10000, alpha = 0.8) 
  #scale_fill_gradient(low="white", high="blue")

#### Debugging Time Series
coffee %>% 
  filter(Date <= '2014-11-30') %>% 
  mutate(years = factor(lubridate::year(Date))) %>% 
  group_by(years) %>% 
  #summarize(Close = mean(Close)) %>%  
  # include time series graph based on the avg price per year for coffee
  ggplot(aes(x = years, y = Close)) +
  geom_line(aes(color = "pink3")) +
  theme_minimal() + 
  scale_x_continuous(labels = scales::dollar_format()) + 
  scale_y_continuous(labels = scales::dollar_format(prefix="$", suffix = "M"))
