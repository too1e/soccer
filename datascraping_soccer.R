library(rvest)
library(dplyr)


urls = c('https://fbref.com/en/comps/Big5/stats/players/Big-5-European-Leagues-Stats',
         'https://fbref.com/en/comps/Big5/shooting/players/Big-5-European-Leagues-Stats',
         'https://fbref.com/en/comps/Big5/passing/players/Big-5-European-Leagues-Stats',
         'https://fbref.com/en/comps/Big5/passing_types/players/Big-5-European-Leagues-Stats',
         'https://fbref.com/en/comps/Big5/defense/players/Big-5-European-Leagues-Stats',
         'https://fbref.com/en/comps/Big5/gca/players/Big-5-European-Leagues-Stats',
         'https://fbref.com/en/comps/Big5/possession/players/Big-5-European-Leagues-Stats',
         'https://fbref.com/en/comps/Big5/playingtime/players/Big-5-European-Leagues-Stats',
         'https://fbref.com/en/comps/Big5/misc/players/Big-5-European-Leagues-Stats')

stats=read_html(urls[1],as.data.frame=TRUE,stringAsFactors=TRUE) %>% html_nodes("table") %>% .[[1]] %>% html_table(fill=TRUE) 
  
  shooting=read_html(urls[2],as.data.frame=TRUE,stringAsFactors=TRUE) %>% html_nodes("table") %>% .[[1]] %>% html_table(fill=TRUE)  
  
  passing=read_html(urls[3],as.data.frame=TRUE,stringAsFactors=TRUE) %>% html_nodes("table") %>% .[[1]] %>% html_table(fill=TRUE) 
  
  passing_types=read_html(urls[4],as.data.frame=TRUE,stringAsFactors=TRUE) %>% html_nodes("table") %>% .[[1]] %>% html_table(fill=TRUE)  
  
  defence=read_html(urls[5],as.data.frame=TRUE,stringAsFactors=TRUE) %>% html_nodes("table") %>% .[[1]] %>% html_table(fill=TRUE)  
  
  gca=read_html(urls[6],as.data.frame=TRUE,stringAsFactors=TRUE) %>% html_nodes("table") %>% .[[1]] %>% html_table(fill=TRUE)  
  
  possession=read_html(urls[7],as.data.frame=TRUE,stringAsFactors=TRUE) %>% html_nodes("table") %>% .[[1]] %>% html_table(fill=TRUE)  
  
  playingtime=read_html(urls[8],as.data.frame=TRUE,stringAsFactors=TRUE) %>% html_nodes("table") %>% .[[1]] %>% html_table(fill=TRUE)  
  
  misc=read_html(urls[9],as.data.frame=TRUE,stringAsFactors=TRUE) %>% html_nodes("table") %>% .[[1]] %>% html_table(fill=TRUE)
  
  
  # Change the column names to the values in the first row
  names(defence) <- defence[1,]  
  names(gca) <- gca[1,] 
  names(misc) <- misc[1,] 
  names(passing) <- passing[1,] 
  names(passing_types) <- passing_types[1,] 
  names(playingtime) <- playingtime[1,] 
  names(possession) <- possession[1,] 
  names(shooting) <- shooting[1,]
  
  
  defence <- defence[-1,] 
  gca <- gca[-1,] 
  misc <- misc[-1,] 
  passing <- passing[-1,] 
  passing_types <- passing_types[-1,] 
  playingtime <- playingtime[-1,] 
  possession <- possession[-1,] 
  shooting <- shooting[-1,]
  
  defence <- defence[,-1] 
  gca <- gca[,-1] 
  misc <- misc[,-1] 
  passing <- passing[,-1] 
  passing_types <- passing_types[,-1] 
  playingtime <- playingtime[,-1] 
  possession <- possession[,-1] 
  shooting <- shooting[,-1]
  
  # Removing the last column from each dataframe
  
  defence <- defence[, -ncol(defence)] 
  gca <- gca[, -ncol(gca)] 
  misc <- misc[, -ncol(misc)] 
  passing <- passing[, -ncol(passing)] 
  passing_types <- passing_types[, -ncol(passing_types)] 
  playingtime <- playingtime[, -ncol(playingtime)] 
  possession <- possession[, -ncol(possession)] 
  shooting <- shooting[, -ncol(shooting)]
  

  
  list=list(stats,shooting,passing,passing_types,defence,gca,possession,misc)




# converts data into numeric form
for (i in 1:8){
  list[[i]][,9:length(list[[i]])]=sapply(list[[i]][,9:length(list[[i]])],as.numeric)
}


# naming columns 
names(list[[1]])=c('Rk','Player','Nation','Pos','Squad','Comp','Age','Born','90s','Gls','Ast','npG','PK','PKA','YCrd','RCrd','Gls p90','Ast p90','GandA p90','npG p90','npGandA p90','xG','npxG','xA','npxG+xA','xG p90','xA p90','xG+xA p90','npxG p90','npxG+xA p90')

names(list[[2]])=c('Rk','Player','Nation','Pos','Squad','Comp','Age','Born','90s','Gls','Sh','SoT','SoT%','Sh p90','SoT p90','Gls pSh','Gls pSoT','Sh Dist','Sh FK','PK','PKA','xG','npxG','npxG pSh','G-xG','npG-xG')

names(list[[3]])=c('Rk','Player','Nation','Pos','Squad','Comp','Age','Born','90s','PassCmp','PassA','Pass%','PassTotDist','PassProgDist','ShortPassCmp','ShortPassA','ShortPass%','MedPassCmp','MedPassA','MedPass%','LongPassCmp','LongPassA','LongPass%','Ast','xA','A-xA','Key Passes','F3 Passes','PA Passes','PA Crosses','Prog Passes')

names(list[[4]])=c('Rk','Player','Nation','Pos','Squad','Comp','Age','Born','90s','PassA','Live Passes','Dead Passes','Passes FK','Thruballs','Pressed Passes','Switches','Crs','CK','InCK','OutCK','StCK','Ground Passes','Low Passes','High Passes','LF Passes','RF Passes','Head Passes','Throwins','OthBP Passes','PassCmp','PassOff','PassOut','PassInt','PassBlockedbyOpp')

names(list[[5]])=c('Rk','Player','Nation','Pos','Squad','Comp','Age','Born','90s','TacklesA','TacklesW','TklDef3rd','TklMid3rd','TklAtt3rd','1v1W','1v1A','1v1%','Past','Pressures','Succ_Press','Succ_Press%','PressDef3rd','PressMid3rd','PressAtt3rd','Blocks','ShBlocked','ShSv','PassBlocked','Int','Tkl+Int','Clr','Err')

names(list[[6]])=c('Rk','Player','Nation','Pos','Squad','Comp','Age','Born','90s','SCA','SCA90','SCAPassLive','SCAPassDead','SCADrib','SCASh','SCAFld','SCADef','GCA','GCA90','GCAPassLive','GCAPassDead','GCADrib','GCASh','GCAFld','GCADef')

names(list[[7]])=c('Rk','Player','Nation','Pos','Squad','Comp','Age','Born','90s','Touches','Touches DefPA','Touches Def3','Touches Mid3','Touches Att3','Touches AttPA','Touches Live','DribCmp','DribA','Drib%','PlayersPast','Megs','Carries','CarryTotDist','CarryProgDist','Prog Carries','F3 Carries','PA Carries','Mis','Dis','RecA','RecCmp','Rec%','Prog Rec')

names(list[[8]])=c('Rk','Player','Nation','Pos','Squad','Comp','Age','Born','90s','YCrd','RCrd','2YCrd','Fls','Fld','Off','Crs','Int','TacklesW','PKwon','PKcon','OG','Recov','AerW','AerL','Aer%')

# order by mins, filter duplicates
for (i in 1:8){
  list[[i]]=list[[i]][order(list[[i]]$`90s`,decreasing=TRUE),]
  list[[i]]=list[[i]][!duplicated(list[[i]]$Player),]
}


#######


# Merging data by 'PlayerName'
merged_data <- playerlist[[1]]

for (i in 2:length(playerlist)) {
  merged_data <- merge(merged_data, playerlist[[i]], by = "Player", all = TRUE)
}

## filter by team 

team_data <- merged_data %>% filter(Squad.x == "Tottenham")
