select l.local, l.sku, l.Alvo, l.EEM, l.EET, g.EEM as EstCD from new_eval l join new_eval g where l.sku = g.sku and g.local like '%Centro%' and l.local like '%Center Norte%' and (l.Alvo - (l.EEM + l.EET) > 0) and G.EEM > 0 