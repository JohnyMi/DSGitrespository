import random

def prijat_cislo(cislo, vybrane_cisla, od=1, do=49):
    # Test zadanej hodnoty, či je zadané číslo
    if cislo.isnumeric():
        cislo = int(cislo)
    else:
        print(f"Zadaná hodnota ´{cislo}´ nie je číslo, next time zadaj číslo!")
        return False

    # Test interval
    if not do >= cislo >= od:
        print(f"Číslo {cislo} sa nenachádza v intervale 1-49")
        return False

    if cislo in vybrane_cisla:
        print(f"Číslo {cislo} už bolo zadané, zadaj iné!")
        return False
    else:
        return True

def stav_sportku(pocet_cisiel=6, od=1, do=49):
    vybrane_cisla = []
    print(f"Vyber si svojích {pocet_cisiel} šťastných čísiel!")
    while len(vybrane_cisla) < pocet_cisiel:
        cislo = input(f"Zadaj číslo od {od} do {do} bez opakovania: ")
        zkontrolovane = prijat_cislo(cislo, vybrane_cisla, od=od ,do=do)
        if zkontrolovane:
            vybrane_cisla.append(int(cislo))
    return vybrane_cisla


def losovanie_loterie(pocet_cisiel=6, od=1, do=49):
    # do +1 je tam preto lebo range vyberá po predposlednú hodnotu, chcem 49 tak potrebujem 49+1
    return random.sample(range(od, do + 1), pocet_cisiel)

