def stav_sportku(pocet_cisiel=6, od=1, do=49):
    vybrane_cisla = []
    print(f"Vyber si svojích {pocet_cisiel} šťastných čísiel!")
    while len (vybrane_cisla) < pocet_cisiel:
        cislo = input(f"Zadaj číslo od {od} do {do} bez opakovania: ")
        #Test zadanej hodnoty, či je zadané číslo
        if cislo.isnumeric():
            cislo = int(cislo)
        else:
            print(f"Zadaná hodnota ´{cislo}´ nie je číslo, next time zadaj číslo!")
            continue

        #Test interval
        if not do >= cislo >= od:
            print("Zadané číslo sa nenachádza v intervale 1-49")
            continue

        if cislo in vybrane_cisla:
            print(f"Číslo {cislo} už bolo zadané, zadaj iné!")
        else:
            vybrane_cisla.append(cislo)
    return vybrane_cisla
