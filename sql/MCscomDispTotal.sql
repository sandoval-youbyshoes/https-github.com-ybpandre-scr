SELECT 
   Cadastro.*, 
   ifnull(MT.Tiponovo,"NA") As TipoNovo2,
   C.Nome, 
   C.Referencia, 
   C.Ordem,
   concat('/mnt/z/fotosmc/',cadastro.ModeloCor,'.jpg') as ImageFile
FROM YouHist.cadastromc cadastro
LEFT JOIN 3IboxBase.`COMBINACAO` C ON (`C`.`REFERENCIA` = Modelo AND ((RIGHT(`cadastro`.`ModeloCor`, 4) + 0) = `C`.`ORDEM`))
Left Join youhist.modelostipos MT using (Modelo)
WHERE    Cadastro.ModeloCor IN (SELECT ModeloCor FROM YouHist.cadastromc where Colecao <> "GERAL" and NumLojasGCentralEmp > 4)