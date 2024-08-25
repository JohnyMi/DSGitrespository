from Loteria import stav_sportku, losovanie_loterie,kym_nevyhram

stavka = stav_sportku()
print(stavka)

#losovanie = losovanie_loterie()
#print(losovanie)

trvanie, roky, cena = kym_nevyhram(stavka)
print(f"Losovanie trvalo {trvanie} sekúnd")
print(f"na výhru som čakal {roky} rokov")
print(f"Na losovanie som minul {cena} EUR")

