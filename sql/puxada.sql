
SELECT Local, sku, LEAST(FaltaEM,EstEMCD) as Reabastecer FROM youhist.evalcomcdn where faltaEM > 0 and Local NOT LIKE '%Centro%' and local not like '%Tambore%' and estEMCD > 0