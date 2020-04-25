WITH EinkunnEkki1 AS (
    SELECT  MAX([auðkenni]) [Auðkenni], (orð) Orð, max(millivísun) Millivísun, [einkunn orðs] [Einkunn Orðs], Birting, Orðflokkur
    FROM dbo.Kristin
    WHERE millivísun IS NOT NULL

    GROUP BY [auðkenni], [einkunn orðs], birting, orðflokkur, orð
),
EinkunnEr1 AS (
    SELECT MAX([auðkenni]) [Auðkenni], (orð) [Tilvísað Orð], [einkunn orðs] [Ný Einkunn], Birting [Birting Tv], orðflokkur [Orðflokkur Tv]
    FROM dbo.Kristin
    GROUP BY [auðkenni], [einkunn orðs], birting, orðflokkur, orð
)

, CASE  WHEN ek1.[Einkunn Orðs] >= e1.[Ný Einkunn] THEN ek1.[Orð]
        ELSE e1.[Tilvísað Orð]
END [Hærra orð]

, CASE  WHEN e1.[Ný Einkunn] <= ek1.[Einkunn Orðs] THEN e1.[Tilvísað Orð]
        ELSE ek1.[Orð]
END [Lægra orð]

, CASE  WHEN ek1.[Einkunn Orðs] >= e1.[Ný Einkunn] THEN ek1.[Einkunn Orðs]
        ELSE e1.[Ný Einkunn]
END [Hærri einkunn]

, CASE  WHEN e1.[Ný Einkunn] <= ek1.[Einkunn Orðs] THEN e1.[Ný Einkunn]
        ELSE ek1.[Einkunn Orðs]
END [Lægri einkunn]

FROM EinkunnEkki1 ek1 
    JOIN EinkunnEr1 e1
    ON ek1.millivísun = e1.auðkenni

    ORDER BY [orð]
