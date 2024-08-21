def stav_sportku():
    vybrane_cisla = []
    while len (vybrane_cisla) < 6:
        cislo = input("Zadaj číslo od 1-49 bez opakovania: ")
        #Test zadanej hodnoty, či je zadané číslo
        if cislo.isnumeric():
            cislo = int(cislo)
        else:
            print("Zadaná hodnota nie je číslo, next time zadaj číslo")
            continue

        #Test interval
        if not 49 >= cislo >= 1:
            print("Zadané číslo sa nenachádza v intervale 1-49")
            continue

        if cislo in vybrane_cisla:
            print("Toto číslo už bolo zadané, zadaj iné")
        else:
            vybrane_cisla.append(cislo)
    return vybrane_cisla
