SELECT 
   Col, 
   Sum( EstTotal ) As EstTot
   , sum( if(LocalC="0-CD", EstTotal,0) ) as EstTotCD
   , sum( if(LocalC="3-SPM",EstTotal,0) ) as EstTotSPM
   , sum( if(LocalC="4-TTP",EstTotal,0) ) as EstTotTTP
   , sum( if(LocalC="5-IBR",EstTotal,0) ) as EstTotIBR
   , sum( if(LocalC="6-ABC",EstTotal,0) ) as EstTotABC
   , sum( if(LocalC="7-CNT",EstTotal,0) ) as EstTotCNT
FROM youhist.new_eval
where EstTotal>0
group by COL