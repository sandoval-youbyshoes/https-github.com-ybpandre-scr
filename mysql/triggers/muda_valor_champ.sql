BEGIN
  IF (new.champion = 'f') THEN
    SET new.champion = 0;
  ELSE
    SET new.champion = 1;
  END IF;
END