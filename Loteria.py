import random
from datetime import datetime


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
        zkontrolovane = prijat_cislo(cislo, vybrane_cisla, od=od, do=do)
        if zkontrolovane:
            vybrane_cisla.append(int(cislo))
    return vybrane_cisla


def losovanie_loterie(pocet_cisiel=6, od=1, do=49):
    # do +1 je tam preto lebo range vyberá po predposlednú hodnotu, chcem 49 tak potrebujem 49+1
    return random.sample(range(od, do + 1), pocet_cisiel)


def kym_nevyhram(stastne_cisla,
                 cena_losu=2,
                 max_losovanie_riadkov=10,
                 pocet_losovani_tyzdenne=3,
                 vypis_n_losovani=1000000):
    # Losuje sportku tak dlouho, dokud šťastná čísla nevyhrají jackpot.
    # Vrací počet losování, počet let do výhry a cenu podání.
    # Losuje se 3xtýdně, kdy je možné vsadit 10 sloupců naráz.
    lucky = sorted(stastne_cisla)
    i = 0
    start = datetime.now()
    while True:
        losovanie = sorted(losovanie_loterie())
        if lucky == losovanie:
            break
        i += 1
        if i % vypis_n_losovani == 0:
            print(i)
    vypocet_trvania = datetime.now() - start
    # 52 týždňov v roku
    rokov_do_vyhry = i / max_losovanie_riadkov / pocet_losovani_tyzdenne / 52
    cena_losov = i * cena_losu
    return vypocet_trvania.seconds, rokov_do_vyhry, cena_losov
